#!/usr/bin/env python3
"""Author packet(s) + Lean source from a compact batch spec.

The proof-search loop produces, per target, a verified statement and an integrity record.
This tool turns a small spec into (a) the Lean proof file and (b) the full concept packet
JSON, injecting the standard rung-1 trust/training scaffolding so each cycle only has to
supply what is genuinely per-packet. Run `stamp_hashes.py` + `validate_packets.py` after.

Spec JSON shape:
{
  "toolchain": {"lean_version": "...", "mathlib_rev": "..."},
  "environment_hash": "...",
  "packets": [
    {
      "packet_id": "elementary.algebra.binomial_cube.v1",
      "title": "Binomial cube",
      "domain": "algebra", "level": "L0_elementary", "difficulty_bin": "D0",
      "packet_rel": "elementary/algebra/binomial_cube.v1.json",
      "namespace": "MathCorpus.Elementary.Algebra",
      "lean_module": "MathCorpus.Elementary.Algebra.BinomialCube",
      "module_path": "lean/MathCorpus/Elementary/Algebra/BinomialCube.lean",
      "theorem_name": "binomial_cube",
      "formal_statement_pp": "theorem binomial_cube (a b : ℤ) : (a + b) ^ 3 = ...",
      "file_proof": "ring",
      "informal_statement": "...",
      "informal_proof_idea": "...",
      "dedupe_cluster_id": "algebra.binomial_cube",
      "template_family_id": "algebra.factorization_basics",
      "kits": ["core_algebra", "ring_automation"],
      "tactic_tags": ["ring"],
      "prerequisite_concepts": ["distributivity", "binomial"],
      "verification": {
        "episode_id": "...", "import_manifest_hash": "...",
        "trajectory_first_hash": "...", "trajectory_last_hash": "...",
        "verified_at": "2026-07-07T17:35:52Z"
      },
      "eligibility": "public_train"         # optional, default public_train
    }
  ]
}

Usage:
    python tools/author_packet.py <spec.json>
"""

from __future__ import annotations

import argparse
import json
import sys
from pathlib import Path

REPO = Path(__file__).resolve().parent.parent

def render_lean(spec: dict) -> str:
    opens = spec.get("opens", [])
    opens_block = ("\n" + "\n".join(opens) + "\n") if opens else ""
    proof_lines = spec["file_proof"].split("\n")
    proof_block = "\n".join(("  " + ln) if ln.strip() else "" for ln in proof_lines)
    return (
        f"import Mathlib{opens_block}\n"
        f"/-!\n"
        f"# {spec['title']}\n\n"
        f"Packet: `{spec['packet_id']}`\n"
        f"Level:  {spec['level']} · Domain: {spec['domain']} · Trust rung 1 (Lean kernel).\n\n"
        f"{spec['informal_statement']}\n"
        f"Kernel-verified through the tracked proof-search loop "
        f"(episode {spec['verification']['episode_id'][:8]}).\n"
        f"-/\n\n"
        f"namespace {spec['namespace']}\n\n"
        f"{spec['formal_statement_pp']} := by\n"
        f"{proof_block}\n\n"
        f"end {spec['namespace']}\n"
    )


def _verification(v: dict, env_hash: str) -> dict:
    """Assemble the verification record. episode_id + environment_hash uniquely identify
    the proof in the proofsearch ledger; trajectory hashes / verified_at are optional
    auditability extras included only when supplied."""
    rec = {
        "verifier": "proofsearch",
        "environment_hash": env_hash,
        "episode_id": v["episode_id"],
        "outcome": "kernel_verified",
        "kernel_verified": True,
        "fidelity_status": v.get("fidelity_status", "attested"),
        "step_count": v.get("step_count", 1),
    }
    for opt in ("import_manifest_hash", "trajectory_first_hash", "trajectory_last_hash", "verified_at"):
        if v.get(opt):
            rec[opt] = v[opt]
    return rec


def build_packet(spec: dict, toolchain: dict, env_hash: str) -> dict:
    v = spec["verification"]
    packet = {
        "packet_id": spec["packet_id"],
        "packet_version": spec.get("packet_version", "1.0.0"),
        "title": spec["title"],
        "domain": spec["domain"],
        "level": spec["level"],
        "kind": spec.get("kind", "concept"),
        "status": "kernel_verified",
        "difficulty_bin": spec.get("difficulty_bin", "D0"),
        "lean_module": spec["lean_module"],
        "theorem_name": spec["theorem_name"],
        "imports": spec.get("imports", ["Mathlib"]),
        "toolchain": dict(toolchain),
        "source_provenance": {
            "source_kind": spec.get("source_kind", "author_written"),
            "source_refs": spec.get("source_refs", []),
            "authors": ["The MathCorpus Authors"],
            "copyright_holder": "The MathCorpus Authors",
            "license_spdx": "Apache-2.0",
            "license_content": "CC-BY-4.0",
            "statement_fidelity": spec.get("statement_fidelity", "author_written"),
        },
        "informal_statement": spec["informal_statement"],
        "informal_proof_idea": spec["informal_proof_idea"],
        "formal_statement_pp": spec["formal_statement_pp"],
        "proof_body_path": spec["module_path"],
        "proof_body_redacted": False,
        "trust": {
            "rung": 1,
            "proof_authority": "lean_kernel",
            "certificate_checker": "kernel_decide",
            "encoding_required": False,
            "encoding_soundness_status": "not_applicable",
            "independent_review_status": "repo_reviewed",
            "public_claim_class": "public_safe",
        },
        "training": {
            "eligibility": spec.get("eligibility", "public_train"),
            "reason_codes": ["public", "non_benchmark", "unredacted"],
            "dedupe_cluster_id": spec["dedupe_cluster_id"],
            "template_family_id": spec["template_family_id"],
            "contamination_risk": "low",
            "can_export_proof_body": True,
        },
        "dependencies": {
            "kits": spec.get("kits", []),
            "tactic_tags": spec.get("tactic_tags", []),
            "prerequisite_concepts": spec.get("prerequisite_concepts", []),
        },
        "metrics": {"loc": spec.get("loc", 3), "tactic_count": spec.get("tactic_count", 1)},
        "artifacts": {"public_files": [spec["module_path"]]},
        "review": {
            "review_basis": "repo self-review; kernel-verified through the tracked proof-search loop",
            "reviewer_status": "repo_reviewed",
        },
        "verification": _verification(v, env_hash),
        "notes": spec.get("notes",
                          f"Proof authority: Lean kernel via the tracked proof-search loop "
                          f"(episode {v['episode_id'][:8]})."),
        "hashes": {"packet_sha256": "0" * 64},
    }
    return packet


def write_lean(spec: dict) -> Path:
    content = render_lean(spec)
    path = REPO / spec["module_path"]
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(content, encoding="utf-8", newline="\n")
    return path


def write_packet(packet: dict, spec: dict) -> Path:
    path = REPO / "packets" / spec["packet_rel"]
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(packet, indent=2, ensure_ascii=False) + "\n",
                    encoding="utf-8", newline="\n")
    return path


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("spec", help="Batch spec JSON.")
    args = ap.parse_args()

    batch = json.loads(Path(args.spec).read_text(encoding="utf-8"))
    toolchain = batch["toolchain"]
    env_hash = batch["environment_hash"]

    n = 0
    for spec in batch["packets"]:
        packet = build_packet(spec, toolchain, env_hash)
        lp = write_lean(spec)
        pp = write_packet(packet, spec)
        print(f"authored {spec['packet_id']}")
        print(f"  lean:   {lp.relative_to(REPO)}")
        print(f"  packet: {pp.relative_to(REPO)}")
        n += 1
    print(f"\n{n} packet(s) authored. Now: stamp_hashes.py + validate_packets.py.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
