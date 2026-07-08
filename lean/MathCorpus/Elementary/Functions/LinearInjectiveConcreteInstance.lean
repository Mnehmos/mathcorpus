import Mathlib
/-!
# 3n + 7 is injective

Packet: `elementary.functions.linear_injective_concrete_instance.v1`
Level:  L1_proof_basics · Domain: functions · Trust rung 1 (Lean kernel).

The function n ↦ 3n + 7 on naturals is injective. Kernel-verified through
the tracked proof-search loop (episode 9c3f7163): `simp
[Function.Injective]` unfolds the definition and closes the resulting
linear equation directly via simp's default arithmetic-cancellation
lemmas -- no separate `intro a b h` + `omega` step needed here (contrast
with `injective_add_decide_failure.v1`, where `decide` fails outright on
an infinite-domain injectivity goal).
-/

namespace MathCorpus.Elementary.Functions

theorem linear_injective_concrete_instance : Function.Injective (fun n : ℕ => 3 * n + 7) := by
  simp [Function.Injective]

end MathCorpus.Elementary.Functions
