import Mathlib
/-!
# Euler's sum of powers conjecture is false for k=5

Packet: `frontier.formal_conjectures.euler_sum_of_powers_false_for_k5.v1`
Level:  L7_frontier · Domain: frontier · Trust rung 1 (Lean kernel).

Source: https://en.wikipedia.org/wiki/Euler's_sum_of_powers_conjecture --
Euler's sum of powers conjecture states that for integers n > 1 and k > 1,
if the sum of n positive integers each raised to the k-th power equals
another integer raised to the k-th power, then k <= n. This packet
disproves the k=5 instance via the explicit counterexample found by
Lander and Parkin in 1966 (the first known counterexample to Euler's
conjecture, found by computer search): 27^5 + 84^5 + 110^5 + 133^5 =
144^5, so n=4 < 5.

ANTI-OVERCLAIM: the general conjecture remains open for k >= 6; this
packet only disproves the specific k=5 instance.

Kernel-verified through the tracked proof-search loop (episode
9ca64991-f41a-41c4-9045-c3f056b0eee4).
-/

namespace MathCorpus.Frontier.FormalConjectures

theorem euler_sum_of_powers_false_for_k5 :
    ¬ (∀ (n b : ℕ) (_ : 1 < n) (a : Fin n → ℕ) (_ : ∀ i, a i > 0)
        (_ : ∑ i, (a i) ^ 5 = b ^ 5), 5 ≤ n) := by
  push_neg
  use 4, 144
  norm_num
  use ![27, 84, 110, 133]
  decide

end MathCorpus.Frontier.FormalConjectures
