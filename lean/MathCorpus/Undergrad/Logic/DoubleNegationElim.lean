import Mathlib

/-!
# Double negation elimination

Packet: `undergrad.logic.double_negation_elim.v1`
Level:  L3_undergrad · Domain: logic · Trust rung 1 (Lean kernel).

Classically, double negation implies the proposition.
-/

namespace MathCorpus.Undergrad.Logic

theorem double_negation_elim' (P : Prop) (h : ¬¬P) : P := by
  exact Classical.byContradiction fun hnot => h hnot

end MathCorpus.Undergrad.Logic
