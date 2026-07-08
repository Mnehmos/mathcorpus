import Mathlib
/-!
# Accumulator-passing foldl equals reverse-append

Packet: `elementary.induction.foldl_cons_eq_reverse_append.v1`
Level:  L1_proof_basics · Domain: induction · Trust rung 1 (Lean kernel).

For any list l and accumulator acc, folding l with (fun a x => x :: a)
starting from acc equals l.reverse ++ acc. Kernel-verified through the
tracked proof-search loop (episode 0ab12a3b): plain `induction l` (acc
fixed, not generalized) followed by `simp [ih]` in both cases closes the
goal directly -- `simp` bridges the accumulator-shift gap on its own, so
the classic "induction without generalizing the accumulator" trap does
not actually bite here (contrast with weaker closing tactics, which may
still need `induction l generalizing acc`).
-/

namespace MathCorpus.Elementary.Induction

theorem foldl_cons_eq_reverse_append (l acc : List ℕ) :
    l.foldl (fun a x => x :: a) acc = l.reverse ++ acc := by
  induction l with
  | nil => simp
  | cons x xs ih => simp [ih]

end MathCorpus.Elementary.Induction
