import Mathlib
/-!
# 1/a + 1/b = (a+b)/(a*b)

Packet: `elementary.algebra.sum_reciprocals_eq_sum_over_product.v1`
Level:  L1_proof_basics · Domain: algebra · Trust rung 1 (Lean kernel).

For nonzero reals a, b: 1/a + 1/b = (a + b) / (a * b). Kernel-verified
through the tracked proof-search loop (episode 580850dc): `field_simp`
clears denominators using `ha`/`hb` first, then `ring` closes the
resulting polynomial identity -- bare `ring` alone cannot, since it has
no way to use `a ≠ 0`/`b ≠ 0` to cancel `a * a⁻¹`/`b * b⁻¹` to `1` (see
the paired negative example
`negative.algebra.frac_sum_bare_ring.missing_field_simp.v1`).
-/

namespace MathCorpus.Elementary.Algebra

theorem sum_reciprocals_eq_sum_over_product (a b : ℝ) (ha : a ≠ 0) (hb : b ≠ 0) :
    1 / a + 1 / b = (a + b) / (a * b) := by
  field_simp
  ring

end MathCorpus.Elementary.Algebra
