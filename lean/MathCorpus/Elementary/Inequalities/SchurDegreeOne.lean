import Mathlib
/-!
# Schur's inequality, t = 1 case

Packet: `elementary.inequalities.schur_degree_one.v1`
Level:  L2_olympiad · Domain: algebra · Trust rung 1 (Lean kernel).

For nonnegative reals a, b, c: a(a-b)(a-c) + b(b-a)(b-c) + c(c-a)(c-b) >= 0.
Classic named olympiad inequality.
Kernel-verified through the tracked proof-search loop (episode cbffe931).
-/

namespace MathCorpus.Elementary.Inequalities

theorem schur_degree_one :
    ∀ (a b c : ℝ), 0 ≤ a → 0 ≤ b → 0 ≤ c →
      a * (a - b) * (a - c) + b * (b - a) * (b - c) + c * (c - a) * (c - b) ≥ 0 := by
  intro a b c ha hb hc
  rcases le_total a b with hab | hab <;> rcases le_total b c with hbc | hbc <;>
    rcases le_total a c with hac | hac <;>
    nlinarith [mul_nonneg ha hb, mul_nonneg hb hc, mul_nonneg ha hc,
      mul_nonneg (mul_nonneg ha hb) hc, sq_nonneg (a - b), sq_nonneg (b - c),
      sq_nonneg (a - c), mul_nonneg ha (sq_nonneg (b - c)),
      mul_nonneg hb (sq_nonneg (a - c)), mul_nonneg hc (sq_nonneg (a - b))]

end MathCorpus.Elementary.Inequalities
