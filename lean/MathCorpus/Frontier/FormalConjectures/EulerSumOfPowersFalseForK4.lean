import Mathlib
/-!
# Euler's sum of powers conjecture is false for k=4

Packet: `frontier.formal_conjectures.euler_sum_of_powers_false_for_k4.v1`
Level:  L7_frontier · Domain: frontier · Trust rung 1 (Lean kernel).

Source: https://en.wikipedia.org/wiki/Euler's_sum_of_powers_conjecture --
Euler's sum of powers conjecture states that for integers n > 1 and k > 1,
if the sum of n positive integers each raised to the k-th power equals
another integer raised to the k-th power, then k <= n. This packet
disproves the k=4 instance via the explicit counterexample found by
Roger Frye in 1988 (following Noam Elkies' 1987 proof that counterexamples
exist for k=4): 95800^4 + 217519^4 + 414560^4 = 422481^4, so n=3 < 4.

ANTI-OVERCLAIM: the general conjecture remains open for k >= 6; this
packet only disproves the specific k=4 instance.

Kernel-verified through the tracked proof-search loop (episode
67410574-3463-4255-b72a-b4f1b430e410).
-/

namespace MathCorpus.Frontier.FormalConjectures

theorem euler_sum_of_powers_false_for_k4 :
    ¬ (∀ (n b : ℕ) (_ : 1 < n) (a : Fin n → ℕ) (_ : ∀ i, a i > 0)
        (_ : ∑ i, (a i) ^ 4 = b ^ 4), 4 ≤ n) := by
  push_neg
  use 3, 422481
  norm_num
  use ![95800, 217519, 414560]
  decide

end MathCorpus.Frontier.FormalConjectures
