# Governance state

- **`REMOVALS.jsonl`** — append-only tombstone log. One JSON object per removed packet so
  downstream consumers (including the Hugging Face mirror) can reconcile deletions. Schema
  and process: [`../TAKEDOWN_POLICY.md`](../TAKEDOWN_POLICY.md). Currently empty.

Takedown requests are filed per [`../TAKEDOWN_POLICY.md`](../TAKEDOWN_POLICY.md): a
good-faith request triggers temporary quarantine within 2 business days, review by the
project lead plus one maintainer, and a resolution (restore / redact / remove-from-exports
/ remove-with-tombstone).
