import Mathlib
/-!
# Euclidean gcd via genuine well-founded recursion equals Nat.gcd

Packet: `elementary.induction.euclid_gcd_eq_gcd.v1`
Level:  L1_proof_basics · Domain: algebra · Trust rung 1 (Lean kernel).

Defines `euclidGcd` by the Euclidean algorithm
(`euclidGcd b a = if b = 0 then a else euclidGcd (a % b) b`) via `WellFoundedLT.fix` --
a genuinely well-founded, non-structural recursion (the recursive call's new first
argument `a % b` is not a `Nat.succ` predecessor of `b`; Lean's automatic structural
termination checker cannot justify it, and `SubmitModule`'s `def` items are single
expressions with no room for a `termination_by`/`decreasing_by` command). Proves
`euclidGcd` computes the same result as Mathlib's `Nat.gcd`, by strong induction using
the `WellFoundedLT.fix_eq` unfolding lemma (`WellFoundedLT.fix` does not reduce by `rfl`
alone) and `Nat.gcd_rec`.

Named `euclidGcd` (not `myGcd`) to avoid a duplicate top-level Lean identifier: another
concurrent agent independently landed `elementary.induction.mygcd_wellfounded.v1` in this
same namespace using the name `myGcd` for a distinct (weaker) statement
(`myGcd a 0 = a`, via `Nat.strongRecOn`/`Nat.strongRecOn_eq`) before this packet was
authored.
Kernel-verified through the tracked proof-search loop (episode a4a2a972).
-/

namespace MathCorpus.Elementary.Induction

def euclidGcd : ℕ → ℕ → ℕ := fun b a =>
  WellFoundedLT.fix (motive := fun _ => ℕ → ℕ)
    (fun b ih a => if h : b = 0 then a else ih (a % b) (Nat.mod_lt a (Nat.pos_of_ne_zero h)) b)
    b a

theorem euclidGcd_unfold (b a : ℕ) :
    euclidGcd b a = if h : b = 0 then a else euclidGcd (a % b) b := by
  unfold euclidGcd
  rw [WellFoundedLT.fix_eq]

theorem euclidGcd_eq_gcd : ∀ (b a : ℕ), euclidGcd b a = Nat.gcd b a := by
  intro b
  induction b using Nat.strong_induction_on with
  | _ b ih =>
    intro a
    rw [euclidGcd_unfold]
    by_cases hb : b = 0
    · simp [hb]
    · rw [dif_neg hb, ih (a % b) (Nat.mod_lt a (Nat.pos_of_ne_zero hb)), Nat.gcd_rec b a]

end MathCorpus.Elementary.Induction
