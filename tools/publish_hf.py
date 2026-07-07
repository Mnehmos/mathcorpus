#!/usr/bin/env python3
"""Publish the public export to a Hugging Face dataset repo (optional).

The Hub is a *mirror*, not a trust layer: it distributes only what the public export
already contains (redaction is applied upstream by export_jsonl / export_parquet). This
tool uploads the exports/ directory and the hf/ dataset card.

Requires `huggingface_hub` and an auth token. Dry-run by default.

Usage:
    python tools/publish_hf.py --repo <org>/mathcorpus --exports exports/ --card hf/README.md
    python tools/publish_hf.py --repo <org>/mathcorpus --push        # actually upload
"""

from __future__ import annotations

import argparse
import sys
from pathlib import Path


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("--repo", required=True, help="Hub dataset repo id, e.g. org/mathcorpus")
    ap.add_argument("--exports", default="exports", help="Export directory to upload.")
    ap.add_argument("--card", default="hf/README.md", help="Dataset card to upload as README.md.")
    ap.add_argument("--push", action="store_true", help="Actually upload (default is dry-run).")
    args = ap.parse_args()

    exports = Path(args.exports)
    files = sorted(exports.glob("*.jsonl")) + sorted(exports.glob("*.parquet"))
    print(f"Would publish to hf.co/datasets/{args.repo}:")
    print(f"  card: {args.card}")
    for f in files:
        print(f"  file: {f}")

    if not args.push:
        print("\nDry run. Re-run with --push to upload.")
        return 0

    try:
        from huggingface_hub import HfApi
    except ImportError:
        print("huggingface_hub not installed (`pip install huggingface_hub`).", file=sys.stderr)
        return 2

    api = HfApi()
    api.create_repo(args.repo, repo_type="dataset", exist_ok=True)
    api.upload_file(path_or_fileobj=args.card, path_in_repo="README.md",
                    repo_id=args.repo, repo_type="dataset")
    for f in files:
        api.upload_file(path_or_fileobj=str(f), path_in_repo=f.name,
                        repo_id=args.repo, repo_type="dataset")
    print(f"Published {len(files)} file(s) to {args.repo}.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
