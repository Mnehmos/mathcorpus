import Mathlib
/-!
# myFactorial equals Nat.factorial, via structural recursion (SubmitModule)

Packet: `elementary.induction.myfactorial_eq_factorial.v1`
Level:  L1_proof_basics · Domain: algebra · Trust rung 1 (Lean kernel).

Defines `myFactorial` from scratch via `Nat.rec` (explicit structural recursion, not
Mathlib's `Nat.factorial`) and proves it agrees with `Nat.factorial`. This domain's first
packet produced via the proof-search environment's `SubmitModule` action (helper def + root
theorem) rather than a single `Solve` tactic block.
Kernel-verified through the tracked proof-search loop (episode 99b8de59).
-/

namespace MathCorpus.Elementary.Induction

def myFactorial : ℕ → ℕ := fun n => Nat.rec 1 (fun k ih => (k + 1) * ih) n

theorem myFactorial_eq_factorial (n : ℕ) : myFactorial n = Nat.factorial n := by
  induction n with
  | zero => rfl
  | succ n ih =>
    show (n + 1) * myFactorial n = Nat.factorial (n + 1)
    rw [Nat.factorial_succ, ih]

end MathCorpus.Elementary.Induction
