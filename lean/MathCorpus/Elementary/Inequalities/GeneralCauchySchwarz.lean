import Mathlib
/-!
# General n-term Cauchy-Schwarz inequality

Packet: `elementary.inequalities.general_cauchy_schwarz.v1`
Level:  L2_olympiad · Domain: inequalities · Trust rung 1 (Lean kernel).

For real-valued functions a, b on an arbitrary Finset index, the Cauchy-
Schwarz inequality (sum a_i*b_i)^2 <= (sum a_i^2) * (sum b_i^2). Extends
`cauchy_two_term`/`cauchy_three_term` to the general finite case,
mirroring `general_amgm`'s n-term extension of the AM-GM ladder.
Kernel-verified through the tracked proof-search loop (episode fcb86396).
-/

namespace MathCorpus.Elementary.Inequalities

theorem general_cauchy_schwarz (ι : Type) (s : Finset ι) (a b : ι → ℝ) :
    (∑ i ∈ s, a i * b i) ^ 2 ≤ (∑ i ∈ s, (a i) ^ 2) * (∑ i ∈ s, (b i) ^ 2) := by
  exact Finset.sum_mul_sq_le_sq_mul_sq s a b

end MathCorpus.Elementary.Inequalities
