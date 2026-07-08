import Mathlib
/-!
# Nonnegative discriminant implies a real root

Packet: `elementary.algebra.quad_formula_real_root.v1`
Level:  L1_proof_basics · Domain: algebra · Trust rung 1 (Lean kernel).

If the discriminant b^2 - 4ac of a quadratic a*x^2 + b*x + c (a nonzero) is
nonnegative, the quadratic has a real root -- the existence half of the
quadratic formula. Builds on this domain's existing quad_form_nonneg.
Kernel-verified through the tracked proof-search loop (episode 9435347e).
-/

namespace MathCorpus.Elementary.Algebra

theorem quad_formula_real_root (a b c : ℝ) (ha : a ≠ 0) (hD : 0 ≤ b ^ 2 - 4 * a * c) :
    ∃ x : ℝ, a * x ^ 2 + b * x + c = 0 := by
  have hs : Real.sqrt (b ^ 2 - 4 * a * c) ^ 2 = b ^ 2 - 4 * a * c := Real.sq_sqrt hD
  set s := Real.sqrt (b ^ 2 - 4 * a * c) with hs_def
  refine ⟨(s - b) / (2 * a), ?_⟩
  have h2a : (2 : ℝ) * a ≠ 0 := mul_ne_zero two_ne_zero ha
  field_simp
  linear_combination hs

end MathCorpus.Elementary.Algebra
