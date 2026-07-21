import Mathlib

/-!
# Distance to a fixed point in a metric space is continuous

Packet: `analysis.metric_space_continuous_dist.v1`
Level:  L4_advanced_undergrad · Domain: analysis · Trust rung 1 (Lean kernel).

For any point p in a metric space X, the function x ↦ dist x p is continuous.
-/

namespace MathCorpus.Undergrad.Analysis

theorem continuous_dist' : ∀ {X : Type*} [MetricSpace X] (p : X), Continuous (fun x => dist x p) := by
  intro X inst p
  exact continuous_id.dist continuous_const

end MathCorpus.Undergrad.Analysis
