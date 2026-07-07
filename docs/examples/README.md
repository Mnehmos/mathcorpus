# Schema illustrations (not corpus members)

These files show the **shape** of packet kinds the corpus will contain. They are **not**
under `packets/`, are **not** validated in CI, and are **not** exported — because their
proofs have not (yet) been produced through the tracked verifier loop.

Keeping them here, rather than in `packets/`, enforces a core invariant:

> **Every packet in `packets/` has proof authority from a checked artifact.** A packet
> that merely *claims* `verified_certificate` without an actual verifier run does not
> belong in the live corpus — that is precisely the "smuggling" the encoding-soundness and
> trust rules forbid.

| File | Illustrates |
|------|-------------|
| `certificate_backed_ramsey.example.json` | A rung-2 certificate-backed finite claim (LRAT replay + canonical-CNF binding + redacted certificate file). Its hashes are placeholders. It will graduate into `packets/frontier/` once R(3,3) ≤ 6 is proved through the loop with a real LRAT certificate and canonical CNF hash. |

When an example graduates, it moves into `packets/`, gets real toolchain + `verification`
+ hash values, and passes `validate_packets.py`.
