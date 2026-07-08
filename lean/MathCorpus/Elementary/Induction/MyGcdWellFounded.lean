import Mathlib

/-!
# Euclidean gcd via genuine well-founded recursion (SubmitModule)

Packet: `elementary.induction.mygcd_wellfounded.v1`
Level:  L1_proof_basics · Domain: algebra · Trust rung 1 (Lean kernel).

Defines `myGcd` by the Euclidean algorithm (`myGcd a 0 = a`,
`myGcd a (b+1) = myGcd (b+1) (a % (b+1))`) via `Nat.strongRecOn` -- a
genuinely well-founded, non-structural recursion (the recursive call's new
second argument `a % (b+1)` is not a direct `Nat.succ` predecessor of
`b+1`; Lean's default structural/automatic termination checker cannot
justify it and asks for an explicit `termination_by`, which the
proof-search environment's `SubmitModule` `def` items cannot express
since they are single expressions with no room for command-level
modifiers). This is the domain's first packet using a genuinely
decreasing-measure recursion rather than plain structural `Nat.rec`
(`myfactorial_eq_factorial`, `fib_le_two_pow`, `even_odd_mutual_totality`
all used only structural recursion).

Two earlier attempts in this same tracked episode are preserved as
lessons: (1) writing `myGcd` via ordinary equation-compiler pattern syntax
kernel-failed with "Could not find a decreasing measure" -- confirming
Lean's automatic termination checker cannot discharge this case without
an explicit measure, which `SubmitModule` cannot supply; (2) after
switching to an explicit `Nat.strongRecOn` term (which type-checks and
compiles), the base-case proof `rfl` failed because `Nat.strongRecOn`
(built on `WellFounded.fix`) does not reduce definitionally -- fixed by
using the `Nat.strongRecOn_eq` unfolding lemma via `simp` instead of
`rfl`.
Kernel-verified through the tracked proof-search loop (episode 7e36dbd3).
-/

namespace MathCorpus.Elementary.Induction

def myGcd : ℕ → ℕ → ℕ := fun a b =>
  Nat.strongRecOn (motive := fun _ => ℕ → ℕ) b
    (fun n ih x =>
      match n with
      | 0 => x
      | (m + 1) => ih (x % (m + 1)) (Nat.mod_lt x (Nat.succ_pos m)) (m + 1))
    a

theorem mygcd_wellfounded (a : ℕ) : myGcd a 0 = a := by
  simp [myGcd, Nat.strongRecOn_eq]

end MathCorpus.Elementary.Induction
