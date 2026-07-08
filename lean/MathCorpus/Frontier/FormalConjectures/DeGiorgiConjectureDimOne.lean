import Mathlib

open scoped Laplacian

/-!
# De Giorgi's conjecture holds in dimension 1 (EuclideanSpace restatement)

Packet: `frontier.formal_conjectures.degiorgi_conjecture_dim_one.v1`
Level:  L7_frontier · Domain: frontier · Trust rung 1 (Lean kernel).

Source: De Giorgi's conjecture on entire solutions of `Δ u + u - u^3 = 0`
(rigidity of level sets in low dimension). Upstream Lean statement (sibling
repo mnehmos.llm-driven-proof-search.environment/formal-conjectures,
FormalConjectures/Paper/DeGiorgi.lean::DeGiorgi_one) states the dimension
`n = 1` case, which trivially holds since `u` is injective (its first
partial derivative is everywhere positive). The upstream file is
sorry-free for this specific case.

This packet restates the same content without the upstream file's named
predicates `IsBoundedSolution` (a `structure ... : Prop`), `HasPositiveDeriv`,
`HasHyperplaneLevelSets`, `DeGiorgi_conclusion` (all file-local `def`s/
`structure`s in the sibling checkout), and without its local `ℝ^n` notation
(`scoped[EuclideanGeometry] notation "ℝ^" n => EuclideanSpace ℝ (Fin n)`,
defined in that repo's own `FormalConjecturesForMathlib` extension, not
plain Mathlib) -- inlined here as `EuclideanSpace ℝ (Fin n)` for `n = 1`
and as the plain conjunction/Prop each predicate unfolds to. This is a
restatement avoiding those upstream-repo-local declarations, not a verbatim
transport of the upstream proof term (see `statement_fidelity:
adapted_with_review` in the packet JSON) -- though the proof strategy
(injectivity via `strictMono_of_deriv_pos` plus the surjectivity of
`t ↦ EuclideanSpace.single 0 t`) is the same as the upstream proof.

De Giorgi's conjecture ITSELF remains open in dimensions 4-8 (`n ≥ 9` is a
known counterexample, proved by Del Pino-Kowalczyk-Wei); this packet proves
only the elementary `n = 1` case, which the upstream file's own comment
calls "trivial." It does not touch the harder `n = 2` (Ghoussoub-Gui) or
`n = 3` (Ambrosio-Cabre) cases, both `sorry` upstream, nor the open
`4 <= n <= 8` cases.

Kernel-verified through the tracked proof-search loop (episode
fb137309-7985-4cb7-805e-6305ae6e1872).
-/

namespace MathCorpus.Frontier.FormalConjectures

theorem degiorgi_conjecture_dim_one :
    ∀ u : EuclideanSpace ℝ (Fin 1) → ℝ,
      ((ContDiff ℝ 2 u ∧ (∃ C, ∀ x, |u x| ≤ C) ∧ (∀ x, (Δ u x) + u x - (u x) ^ 3 = 0)) ∧
        (∀ x, 0 < lineDeriv ℝ u x (EuclideanSpace.single 0 1))) →
      ∀ y ∈ Set.range u, ∃ S : AffineSubspace ℝ (EuclideanSpace ℝ (Fin 1)),
        u ⁻¹' {y} = S ∧ Module.finrank ℝ S.direction = 1 - 1 := by
  intro u ⟨hu_sol, hu_deriv⟩ y hy
  obtain ⟨x, rfl⟩ := hy
  refine ⟨affineSpan ℝ {x}, ?_, ?_⟩
  · rw [AffineSubspace.coe_affineSpan_singleton, ← Set.image_singleton]
    apply Set.preimage_image_eq
    refine Function.Injective.of_comp_right
        (g := fun t : ℝ ↦ EuclideanSpace.single (0 : Fin 1) t) ?_ ?_
    · refine (strictMono_of_deriv_pos (fun t ↦ ?_)).injective
      specialize hu_deriv (EuclideanSpace.single (0 : Fin 1) t)
      rw [(by simp : t = t + 0), ← deriv_comp_const_add, Function.comp_def]
      unfold lineDeriv at hu_deriv
      convert hu_deriv
      aesop
    · exact fun t ↦ ⟨t 0, by ext i; fin_cases i; simp⟩
  · simp [direction_affineSpan]

end MathCorpus.Frontier.FormalConjectures
