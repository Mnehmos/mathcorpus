# Issue Template — Dev Issues

Use this shape when filing a new issue for the dev loop agent:

## Summary

One sentence: what is broken or missing.

## Affects

Which tool (`tools/*.py`), schema field, CI job, or packet-authoring step
this touches.

## Repro (bugs only)

Exact command that reproduces the problem, e.g.
`python tools/validate_packets.py packets/elementary/algebra/foo.v1.json`.

## Expected vs actual

## Proposed fix (optional)

## Priority

One of: schema-validation, hash-integrity, export-manifest, redaction,
dedupe, CI-workflow.
