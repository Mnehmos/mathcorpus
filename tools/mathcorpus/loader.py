"""Discover and load packet JSON files."""

from __future__ import annotations

import glob as _glob
import json
from dataclasses import dataclass
from pathlib import Path
from typing import Any, Iterable


@dataclass
class LoadedPacket:
    path: Path
    data: dict[str, Any]


def _iter_json_paths(arg: str) -> Iterable[Path]:
    p = Path(arg)
    if any(ch in arg for ch in "*?[") and not p.exists():
        for m in _glob.glob(arg, recursive=True):
            yield Path(m)
        return
    if p.is_dir():
        yield from sorted(p.rglob("*.json"))
        return
    if p.is_file():
        yield p
        return
    # Fall back to glob semantics for patterns the shell did not expand.
    for m in _glob.glob(arg, recursive=True):
        yield Path(m)


def discover(args: list[str]) -> list[Path]:
    """Expand CLI args (files, directories, or globs) into a de-duplicated path list."""
    seen: dict[str, Path] = {}
    for arg in args:
        for path in _iter_json_paths(arg):
            if path.suffix == ".json":
                seen.setdefault(str(path.resolve()), path)
    return [seen[k] for k in sorted(seen)]


def load(path: Path) -> LoadedPacket:
    with Path(path).open("r", encoding="utf-8") as fh:
        return LoadedPacket(path=Path(path), data=json.load(fh))


def load_all(args: list[str]) -> list[LoadedPacket]:
    return [load(p) for p in discover(args)]
