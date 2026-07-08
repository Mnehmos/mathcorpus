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
`dvd_lcm_right'`), `even_sq`, `well_ordering`, `bezout` (the domain's
first `Int`-based, as opposed to `Nat`-only, gcd fact), and this cycle's
`sq_mod_two_eq_self_mod_two` (`n^2 % 2 = n % 2` via `Nat.even_or_odd`
case split — the follow-up positive packet for the domain's own
`sq_parity_omega_nonlinear_failure` negative example, closing that
lingering gap).

Next targets: see `QUEUE.md`.
