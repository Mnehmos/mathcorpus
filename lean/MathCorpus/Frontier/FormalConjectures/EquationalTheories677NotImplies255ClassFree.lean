import Mathlib
/-!
# Equational Theories: Equation 255 does not imply Equation 677 (class-free restatement)

Packet: `frontier.formal_conjectures.equational_theories_677_255_class_free.v1`
Level:  L7_frontier · Domain: frontier · Trust rung 1 (Lean kernel).

Source: the Equational Theories project (Terence Tao et al.),
https://teorth.github.io/equational_theories/implications/?677&finite
Upstream Lean statement (sibling repo
mnehmos.llm-driven-proof-search.environment/formal-conjectures,
FormalConjectures/Other/EquationalTheories_677_255.lean) uses a `Magma G`
typeclass with `Equation255`/`Equation677` as `abbrev`s over `Magma.op`.
That class is purely notational -- the proof never pattern-matches it as a
class, only ever uses `Magma.op` as a plain binary function -- so this
packet restates the SAME mathematical content with zero custom types,
using `op : Fin 3 -> Fin 3 -> Fin 3` directly. This is a restatement
avoiding the class layer, not a verbatim transport of the upstream proof
term (see `statement_fidelity: adapted_with_review` in the packet JSON).

Witness: `op i j = i + j + 1` on `Fin 3`, matching the upstream operation
table `[[1,2,0],[2,0,1],[0,1,2]]`.

Kernel-verified through the tracked proof-search loop (episode
39013082-f757-41f2-b26b-420d7577a454).
-/

namespace MathCorpus.Frontier.FormalConjectures

theorem equational_theories_677_255_class_free :
    ∃ op : Fin 3 → Fin 3 → Fin 3,
      (∀ x : Fin 3, x = op (op (op x x) x) x) ∧
      ¬ (∀ x y : Fin 3, x = op y (op x (op (op y x) y))) := by
  refine ⟨fun i j => i + j + 1, fun x => by fin_cases x <;> decide, ?_⟩
  decide

end MathCorpus.Frontier.FormalConjectures
