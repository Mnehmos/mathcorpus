import Mathlib

/-!
# isEven / isOdd totality, via mutual recursion (SubmitModule mutual_group)

Packet: `elementary.induction.even_odd_mutual_totality.v1`
Level:  L1_proof_basics · Domain: algebra · Trust rung 1 (Lean kernel).

Defines `isEven`, `isOdd : ℕ → Bool` by mutual recursion and proves every
natural number is classified as even or odd. This domain's first packet
exercising `SubmitModule`'s `mutual_group` (a prior packet,
`myfactorial_eq_factorial`, demonstrated single-def structural recursion
via plain `SubmitModule`; mutual recursion was the remaining undemonstrated
sub-feature).
Kernel-verified through the tracked proof-search loop (episode 11b1ffdb).
-/

namespace MathCorpus.Elementary.Induction

mutual
  def isEven : ℕ → Bool
    | 0 => true
    | (k + 1) => isOdd k
  def isOdd : ℕ → Bool
    | 0 => false
    | (k + 1) => isEven k
end

theorem even_odd_mutual_totality (n : ℕ) : isEven n = true ∨ isOdd n = true := by
  induction n with
  | zero => left; rfl
  | succ k ih =>
    simp only [isEven, isOdd]
    tauto

end MathCorpus.Elementary.Induction
