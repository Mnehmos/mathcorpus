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

- [x] `surjective_comp` — the composition of two surjective functions is
      surjective (D1, L1). Authored 2026-07-08 via tracked episode
      `fd3f917e-f58b-4077-90da-bb1c3d62c203` (kernel_verified on the first
      attempt: `intro α β γ f g hf hg c; obtain ⟨b, hb⟩ := hg c; obtain
      ⟨a, ha⟩ := hf b; exact ⟨a, by rw [Function.comp_apply, ha, hb]⟩`).
      Pairs with `injective_comp`.

- [x] `id_bijective` — the identity function is bijective (D0, L0).
      Authored 2026-07-08 via tracked episode
      `7bce298c-c66f-4696-a952-c7f82691c46a` (kernel_verified on the
      second attempt: `intro α; exact ⟨fun a b hab => hab, fun b => ⟨b,
      rfl⟩⟩`; the first attempt used a bulleted `constructor; · ...; ·
      ...` tactic proof that lost its case-block structure under the
      default `flat_tactic_sequence` transport, leaving a variable out of
      scope — fixed by switching to a bullet-free term-mode proof, not
      packaged as a separate negative example, see the packet's `notes`).
      Picked after another concurrent agent had already claimed
      `linear_injective` and `strictMono_injective` from this queue
      (check `git log -- packets/elementary/functions/` for their current
      status before re-claiming either).

## Next targets

- [ ] `linear_injective` — `f x = a * x + b` is injective when `a ≠ 0`
      (D0/D1, L0/L1). Concrete, elementary worked example rather than an
      abstract composition lemma — good on-ramp packet. (Note: another
      concurrent agent appears to be working this already — check
      `git log` before starting a duplicate attempt.)
- [ ] `strictMono_injective` — a strictly monotone function is injective
      (D1, L1). Connects the "monotone" and "injective" parts of the
      domain's stated focus directly. (Note: another concurrent agent
      appears to have already landed this — check `git log` before
      starting a duplicate attempt.)
- [ ] `fixed_point_id` — every point is a fixed point of `id`; `id x = x`
      as a fixed-point-basics statement (D0, L0).

## Backlog

- [ ] `monotone_comp` — composition of two monotone functions is monotone
      (L1).
- [ ] A concrete image/preimage identity, e.g. `f '' (s ∪ t) = f '' s ∪ f
      '' t` (L1/L2).
