# Queue — Functions (Elementary)

Candidate packets to create or formalize next, roughly in priority order.

**Focus/content gap note:** this domain's `README.md` focus is "injective,
surjective, composition, inverse, monotone, fixed point basics, image/
preimage" but all 16 existing packets are actually `abs`/`max`/`min`
identity lemmas — none of the stated focus topics have a packet yet. Treat
the items below as higher priority than another `abs`/`max`/`min` variant.

## Done

- [x] `injective_comp` — the composition of two injective functions is
      injective (D1, L1). Authored 2026-07-08 via tracked episode
      `ab41c15c-582d-481c-967c-c9daa8439bac` (kernel_verified on the
      second attempt: `intro α β γ f g hf hg a b hab; apply hf; apply hg;
      exact hab`; the first attempt kernel-failed on a binder-arity slip,
      not packaged as a negative example — see the packet's `notes`). The
      single most foundational missing packet for this domain's stated
      focus; first packet on that focus (prior 16 were all `abs`/`max`/
      `min` identities).

## Next targets

- [ ] `surjective_comp` — the composition of two surjective functions is
      surjective (D1, L1). Pairs with `injective_comp`.
- [ ] `linear_injective` — `f x = a * x + b` is injective when `a ≠ 0`
      (D0/D1, L0/L1). Concrete, elementary worked example rather than an
      abstract composition lemma — good on-ramp packet.
- [ ] `strictMono_injective` — a strictly monotone function is injective
      (D1, L1). Connects the "monotone" and "injective" parts of the
      domain's stated focus directly.
- [ ] `id_bijective` — the identity function is bijective (D0, L0). Cheap,
      foundational, currently missing.
- [ ] `fixed_point_id` — every point is a fixed point of `id`; `id x = x`
      as a fixed-point-basics statement (D0, L0).

## Backlog

- [ ] `monotone_comp` — composition of two monotone functions is monotone
      (L1).
- [ ] A concrete image/preimage identity, e.g. `f '' (s ∪ t) = f '' s ∪ f
      '' t` (L1/L2).
