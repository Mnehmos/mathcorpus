# Dashboard — Number Theory (Elementary)

| Metric | Value |
|--------|-------|
| Packets | 58+ (multiple concurrent agent instances committing every cycle — re-derive via `python tools/corpus_stats.py`) |
| Level breakdown | mostly L0_elementary/L1_proof_basics, 1 L2_olympiad |

Per-packet detail lives in each packet's own `verification.episode_id`
and in `git log -- packets/elementary/number_theory/`; this file
previously grew an unbounded per-packet bullet list and has been
condensed (same fix already applied across every elementary domain this
session). Highlights: the domain's first primality family (`prime_two`,
`not_prime_one`, `prime_dvd_mul`), the `gcd_*`/`lcm_*` family now
complete (`lcm_comm`, `gcd_mul_lcm`, `dvd_lcm_left'`,
`dvd_lcm_right'`), `even_sq`, `well_ordering`, and this cycle's `bezout`
(the domain's first `Int`-based, as opposed to `Nat`-only, gcd fact —
closes the last item in this domain's `QUEUE.md`).

Next targets: see `QUEUE.md`.
