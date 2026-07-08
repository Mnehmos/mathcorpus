import Mathlib
/-!
# min plus max equals the sum

Packet: `elementary.inequalities.min_add_max.v1`
Level:  L1_proof_basics · Domain: inequalities · Trust rung 1 (Lean kernel).

min(a,b) + max(a,b) = a + b -- the classic min/max complementary
identity, distinct from the domain's existing min/max INEQUALITIES
(`avg_between_min_max`, `min_add_min_le`, `max_add_le`).
Kernel-verified through the tracked proof-search loop (episode 5c58440d).
-/

namespace MathCorpus.Elementary.Inequalities

theorem min_add_max (a b : ℝ) : min a b + max a b = a + b := by
  rcases le_total a b with h | h
  exacts [by rw [min_eq_left h, max_eq_right h],
    by rw [min_eq_right h, max_eq_left h]; ring]

end MathCorpus.Elementary.Inequalities
