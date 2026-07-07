"""Canonical serialization and hashing.

The corpus needs *one* canonical serializer so that every ``*_sha256`` value is
reproducible on any machine. Rules:

* JSON: keys sorted, UTF-8, no ASCII escaping, compact separators, no trailing space.
* File bytes: BOM stripped, CRLF/CR normalized to LF, otherwise exact bytes.

SHA-256 is the digest (NIST FIPS 180-4) used for all integrity hashes.
"""

from __future__ import annotations

import hashlib
import json
from pathlib import Path
from typing import Any


def canonical_json_bytes(obj: Any) -> bytes:
    """Serialize ``obj`` to canonical UTF-8 JSON bytes (sorted keys, compact)."""
    text = json.dumps(obj, sort_keys=True, ensure_ascii=False, separators=(",", ":"))
    return text.encode("utf-8")


def sha256_hex(data: bytes) -> str:
    """Lowercase hex SHA-256 of raw bytes."""
    return hashlib.sha256(data).hexdigest()


def canonical_json_sha256(obj: Any) -> str:
    """SHA-256 over the canonical JSON serialization of ``obj``."""
    return sha256_hex(canonical_json_bytes(obj))


def normalize_file_bytes(path: str | Path) -> bytes:
    """Exact file bytes with BOM stripped and line endings normalized to LF."""
    raw = Path(path).read_bytes()
    if raw.startswith(b"\xef\xbb\xbf"):
        raw = raw[3:]
    return raw.replace(b"\r\n", b"\n").replace(b"\r", b"\n")


def file_sha256(path: str | Path) -> str:
    """SHA-256 over the LF-normalized, BOM-stripped bytes of ``path``."""
    return sha256_hex(normalize_file_bytes(path))
