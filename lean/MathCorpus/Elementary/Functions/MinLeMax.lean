import Mathlib
/-!
# The minimum of two reals is at most their maximum

Packet: `elementary.functions.min_le_max.v1`
Level:  L0_elementary · Domain: algebra · Trust rung 1 (Lean kernel).

For every pair of reals a, b: min a b <= max a b. A basic identity relating the
`max_comm`/`max_self`/`min_comm`/`min_self` family already in this domain.
Kernel-verified through the tracked proof-search loop (episode 562a07a3).
-/

namespace MathCorpus.Elementary.Functions

theorem min_le_max (a b : ℝ) : min a b ≤ max a b := by
  exact le_max_of_le_left (min_le_left a b)

end MathCorpus.Elementary.Functions
