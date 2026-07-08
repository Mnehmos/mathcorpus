import Mathlib
/-!
# A hand-rolled Fibonacci sequence satisfies fib n <= 2^n

Packet: `elementary.induction.fib_le_two_pow.v1`
Level:  L1_proof_basics · Domain: algebra · Trust rung 1 (Lean kernel).

Defines a Fibonacci-style sequence from scratch via a pair-encoding recursion
(`fibPair n = (fib n, fib (n+1))`), turning the 2-step Fibonacci recurrence into ordinary
1-step structural recursion (`Nat.rec`) on pairs, then proves the growth bound `fib n <= 2^n`
by induction on the strengthened pair invariant. Combines recursion (`SubmitModule`, three
helper declarations) with an induction-proved growth bound.
Kernel-verified through the tracked proof-search loop (episode 11c5774d), second attempt: the
first attempt tried to swap goals via `show` relying on `Prod.fst`/`Prod.snd` defeq directly,
which left `omega` looking at the un-reduced `(fibPair (n + 1)).2` atom instead of its
constituents; replaced with an explicit `fibPair_succ : fibPair (n + 1) = (..)` `rfl` lemma
used as a `simp` rewrite, which reduces the pair projections before `omega` runs.
-/

namespace MathCorpus.Elementary.Induction

def fibPair : ℕ → ℕ × ℕ := fun n => Nat.rec (0, 1) (fun _ p => (p.2, p.1 + p.2)) n

def fib : ℕ → ℕ := fun n => (fibPair n).1

theorem fibPair_succ (n : ℕ) : fibPair (n + 1) = ((fibPair n).2, (fibPair n).1 + (fibPair n).2) :=
  rfl

theorem fibPair_le (n : ℕ) : (fibPair n).1 ≤ 2 ^ n ∧ (fibPair n).2 ≤ 2 ^ n := by
  induction n with
  | zero => decide
  | succ n ih =>
    obtain ⟨ih1, ih2⟩ := ih
    simp only [fibPair_succ, pow_succ]
    omega

theorem fib_le_two_pow (n : ℕ) : fib n ≤ 2 ^ n :=
  (fibPair_le n).1

end MathCorpus.Elementary.Induction
