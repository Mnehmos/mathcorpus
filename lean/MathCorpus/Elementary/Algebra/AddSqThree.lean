import Mathlib

/-!
# Three-variable binomial square expansion

Packet: `elementary.algebra.add_sq_three.v1`
Level:  L1_proof_basics · Domain: algebra · Trust rung 1 (Lean kernel).

(a + b + c) ^ 2 = a^2 + b^2 + c^2 + 2ab + 2bc + 2ca. Natural extension of
`binomial_sq`; reusable for the geometry/inequalities three-variable
families (`three_var_am_gm`, `three_var_sq_ge`).
Kernel-verified through the tracked proof-search loop (episode 29f871d5).
-/

namespace MathCorpus.Elementary.Algebra

theorem add_sq_three (a b c : ℤ) :
    (a + b + c) ^ 2 = a ^ 2 + b ^ 2 + c ^ 2 + 2 * a * b + 2 * b * c + 2 * c * a := by
  ring

end MathCorpus.Elementary.Algebra
