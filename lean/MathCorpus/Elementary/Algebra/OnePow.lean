import Mathlib
/-!
# One raised to any power is one

Packet: `elementary.algebra.one_pow.v1`
Level:  L0_elementary · Domain: algebra · Trust rung 1 (Lean kernel).

One raised to any power is one.
Kernel-verified through the tracked proof-search loop (episode f48ac8ac).
-/

namespace MathCorpus.Elementary.Algebra

theorem one_pow : ∀ (n : ℕ), (1 : ℤ) ^ n = 1 := by
  intro n; exact _root_.one_pow n

end MathCorpus.Elementary.Algebra
