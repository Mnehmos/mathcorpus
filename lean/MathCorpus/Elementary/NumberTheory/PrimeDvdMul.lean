import Mathlib

/-!
# A prime divides a product iff it divides a factor

Packet: `elementary.number_theory.prime_dvd_mul.v1`
Level:  L1_proof_basics · Domain: number_theory · Trust rung 1 (Lean kernel).

If p is prime, p ∣ a * b iff p ∣ a or p ∣ b -- the single most reusable
primality lemma for divisibility work; natural next step after
`prime_two`.
Kernel-verified through the tracked proof-search loop (episode b42295d9).
-/

namespace MathCorpus.Elementary.NumberTheory

theorem prime_dvd_mul (p a b : ℕ) (hp : p.Prime) : p ∣ a * b ↔ p ∣ a ∨ p ∣ b :=
  hp.prime.dvd_mul

end MathCorpus.Elementary.NumberTheory
