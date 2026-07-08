import Mathlib
/-!
# Bezout's identity

Packet: `elementary.number_theory.bezout.v1`
Level:  L2_olympiad · Domain: number_theory · Trust rung 1 (Lean kernel).

For every pair of integers a, b: gcd(a, b) is expressible as an integer linear
combination of a and b, i.e. there exist integers u, v with gcd(a,b) = a*u + b*v.
Kernel-verified through the tracked proof-search loop (episode 5d1a3305).
-/

namespace MathCorpus.Elementary.NumberTheory

theorem bezout (a b : ℤ) : ∃ u v : ℤ, (Int.gcd a b : ℤ) = a * u + b * v := by
  exact ⟨Int.gcdA a b, Int.gcdB a b, Int.gcd_eq_gcd_ab a b⟩

end MathCorpus.Elementary.NumberTheory
