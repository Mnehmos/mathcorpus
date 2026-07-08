import Mathlib
/-!
# The average of two reals lies between their min and max

Packet: `elementary.inequalities.avg_between_min_max.v1`
Level:  L0_elementary · Domain: algebra · Trust rung 1 (Lean kernel).

For every pair of real numbers a, b: min a b <= (a+b)/2 <= max a b -- the average of two numbers always lies between their minimum and maximum.
Kernel-verified through the tracked proof-search loop (episode c5bd7202).
-/

namespace MathCorpus.Elementary.Inequalities

theorem avg_between_min_max (a b : ℝ) : min a b ≤ (a + b) / 2 ∧ (a + b) / 2 ≤ max a b := by
  rcases le_total a b with h | h
  · exact ⟨by rw [min_eq_left h]; linarith, by rw [max_eq_right h]; linarith⟩
  · exact ⟨by rw [min_eq_right h]; linarith, by rw [max_eq_left h]; linarith⟩

end MathCorpus.Elementary.Inequalities
