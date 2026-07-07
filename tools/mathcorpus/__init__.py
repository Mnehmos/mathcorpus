"""MathCorpus tooling library.

Shared, functional building blocks used by the command-line tools in ``tools/``:

* :mod:`mathcorpus.canonical` — canonical JSON serialization and SHA-256 helpers
* :mod:`mathcorpus.hashing`   — packet / formal-statement hash computation
* :mod:`mathcorpus.policy`    — cross-field trust, encoding, redaction, split rules
* :mod:`mathcorpus.loader`    — discover and load packet JSON files
"""

__all__ = ["canonical", "hashing", "policy", "loader"]
