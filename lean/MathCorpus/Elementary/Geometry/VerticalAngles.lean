import Mathlib
/-!
# Vertical angles are equal

Packet: `elementary.geometry.vertical_angles.v1`
Level:  L1_proof_basics · Domain: geometry · Trust rung 1 (Lean kernel).

Two angles supplementary to the same angle are equal — the vertical-angles theorem in scalar form.
Kernel-verified through the tracked proof-search loop (episode 8d7f0047).
-/

namespace MathCorpus.Elementary.Geometry

theorem vertical_angles (a b c : ℝ) (h1 : a + b = Real.pi) (h2 : c + b = Real.pi) : a = c := by
  linarith

end MathCorpus.Elementary.Geometry
