import Mathlib

/-!
# Every point is a fixed point of the identity function

Packet: `elementary.functions.fixed_point_id.v1`
Level:  L0_elementary · Domain: algebra · Trust rung 1 (Lean kernel).

For every x, id x = x -- the defining fixed-point-basics fact about the
identity function.
Kernel-verified through the tracked proof-search loop (episode 3952d582).
-/

namespace MathCorpus.Elementary.Functions

theorem fixed_point_id {α : Type*} (x : α) : id x = x := rfl

end MathCorpus.Elementary.Functions
