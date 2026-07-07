# Takedown Policy

MathCorpus pairs permissive licensing with an explicit removal path, so downstream users
can synchronize deletions.

## Contact

Open a GitHub issue labeled `takedown`, or email the maintainers (see repository
metadata). For sensitive claims, request a private channel in the issue and a maintainer
will follow up.

## Required request fields

- packet ID or URL
- claimed rights basis
- affected content type (proof body, prose, certificate, benchmark statement, etc.)
- desired action (restore / redact / remove-from-future-exports / remove-with-tombstone)

## Process

1. **Immediate temporary quarantine within 2 business days** of a good-faith request.
   The affected packet's `training.eligibility` is set to `quarantined` and it is dropped
   from the next export.
2. **Review** by the project lead plus one maintainer.
3. **Resolution**, one of: restore · redact · remove from future exports · remove and
   publish a tombstone entry.
4. **Tombstone**: a record is appended to [`governance/REMOVALS.jsonl`](governance/REMOVALS.jsonl)
   so downstream consumers can reconcile deletions.

## Tombstone record shape

```json
{
  "packet_id": "...",
  "removed_at": "YYYY-MM-DDThh:mm:ssZ",
  "action": "remove_with_tombstone",
  "reason_class": "rights_claim | license_incompat | contamination | author_request | other",
  "affected_hashes": { "packet_sha256": "..." },
  "notes": "public-safe summary only"
}
```

This governance holds even for entirely self-authored content: imported Lean repositories
and benchmark-adjacent materials create nontrivial provenance risk over time.
