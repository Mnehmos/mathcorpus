import Mathlib
open MvPolynomial

/-!
# Jacobian Conjecture is false in dimension 3 (certified refutation of the formal-conjectures instance)

Packet: `frontier.jacobian.jacobian_conjecture_false_dim_three.v1`
Level:  L7_frontier · Domain: frontier · Trust rung 1 (Lean kernel).

The Jacobian Conjecture (Keller 1939) is FALSE in dimension 3: there is a polynomial map F : C^3 -> C^3 with a nonzero constant Jacobian determinant (a Keller map) that is not invertible. This packet certifies exactly the negated formal-conjectures instance `jacobian_conjecture` in dimension 3 - the explicit witness is F(x,y,z) = ((1+xy)^3 z + y^2(1+xy)(4+3xy), y + 3x(1+xy)^2 z + 3xy^2(4+3xy), 2x - 3x^2 y - x^3 z), with det Jac F = -2. It does NOT resolve the dimension-2 problem (open), the map's fiber/image geometry, general-n stabilization, or the Dixmier/Mathieu/Zhao/cubic-reduction bridges (open or only conditionally proved elsewhere).
Kernel-verified through the tracked proof-search loop (episode 1f9dfbee).
-/

namespace MathCorpus.Frontier.Jacobian

theorem jacobian_conjecture_false_dim_three :
    ¬ (∀ F : Fin 3 → MvPolynomial (Fin 3) ℂ,
         IsUnit (Matrix.of fun i j => pderiv i (F j)).det →
         ∃ G : Fin 3 → MvPolynomial (Fin 3) ℂ,
           (fun i => bind₁ G (F i)) = X ∧ (fun i => bind₁ F (G i)) = X) := by
  intro h
  have hdet : (Matrix.of fun i j => pderiv i ((![(1 + X 0 * X 1)^3 * X 2 + (X 1)^2 * (1 + X 0 * X 1) * (C 4 + C 3 * X 0 * X 1), X 1 + C 3 * X 0 * (1 + X 0 * X 1)^2 * X 2 + C 3 * X 0 * (X 1)^2 * (C 4 + C 3 * X 0 * X 1), C 2 * X 0 - C 3 * (X 0)^2 * X 1 - (X 0)^3 * X 2] : Fin 3 → MvPolynomial (Fin 3) ℂ) j)).det = C (-2 : ℂ) := by
    rw [Matrix.det_fin_three]
    set_option maxRecDepth 400000 in
    simp [pderiv_mul, pderiv_pow, pderiv_C, pderiv_X_self, pderiv_X_of_ne, pderiv_one, Derivation.map_add, Derivation.map_sub]
    set_option maxRecDepth 400000 in
    simp only [map_ofNat, map_one]
    set_option maxRecDepth 400000 in
    ring
  obtain ⟨G, -, hFG⟩ := h (![(1 + X 0 * X 1)^3 * X 2 + (X 1)^2 * (1 + X 0 * X 1) * (C 4 + C 3 * X 0 * X 1), X 1 + C 3 * X 0 * (1 + X 0 * X 1)^2 * X 2 + C 3 * X 0 * (X 1)^2 * (C 4 + C 3 * X 0 * X 1), C 2 * X 0 - C 3 * (X 0)^2 * X 1 - (X 0)^3 * X 2] : Fin 3 → MvPolynomial (Fin 3) ℂ) (by rw [hdet]; exact (isUnit_iff_ne_zero.mpr (by norm_num : (-2 : ℂ) ≠ 0)).map (C : ℂ →+* MvPolynomial (Fin 3) ℂ))
  have h1 : ∀ (p : Fin 3 → ℂ) (i : Fin 3), aeval (fun j => aeval p ((![(1 + X 0 * X 1)^3 * X 2 + (X 1)^2 * (1 + X 0 * X 1) * (C 4 + C 3 * X 0 * X 1), X 1 + C 3 * X 0 * (1 + X 0 * X 1)^2 * X 2 + C 3 * X 0 * (X 1)^2 * (C 4 + C 3 * X 0 * X 1), C 2 * X 0 - C 3 * (X 0)^2 * X 1 - (X 0)^3 * X 2] : Fin 3 → MvPolynomial (Fin 3) ℂ) j)) (G i) = p i := by
    intro p i
    have hi := congrArg (fun q => aeval p q) (congrFun hFG i)
    simp only [aeval_bind₁, aeval_X] at hi
    exact hi
  have epts : (fun j => aeval (![0, 0, -1/4] : Fin 3 → ℂ) ((![(1 + X 0 * X 1)^3 * X 2 + (X 1)^2 * (1 + X 0 * X 1) * (C 4 + C 3 * X 0 * X 1), X 1 + C 3 * X 0 * (1 + X 0 * X 1)^2 * X 2 + C 3 * X 0 * (X 1)^2 * (C 4 + C 3 * X 0 * X 1), C 2 * X 0 - C 3 * (X 0)^2 * X 1 - (X 0)^3 * X 2] : Fin 3 → MvPolynomial (Fin 3) ℂ) j)) = (fun j => aeval (![1, -3/2, 13/2] : Fin 3 → ℂ) ((![(1 + X 0 * X 1)^3 * X 2 + (X 1)^2 * (1 + X 0 * X 1) * (C 4 + C 3 * X 0 * X 1), X 1 + C 3 * X 0 * (1 + X 0 * X 1)^2 * X 2 + C 3 * X 0 * (X 1)^2 * (C 4 + C 3 * X 0 * X 1), C 2 * X 0 - C 3 * (X 0)^2 * X 1 - (X 0)^3 * X 2] : Fin 3 → MvPolynomial (Fin 3) ℂ) j)) := by
    funext j
    fin_cases j <;> (set_option maxRecDepth 40000 in simp) <;> norm_num
  have a0 := h1 ![0, 0, -1/4] 0
  have b0 := h1 ![1, -3/2, 13/2] 0
  rw [epts] at a0
  have hcontra : (![0, 0, -1/4] : Fin 3 → ℂ) 0 = (![1, -3/2, 13/2] : Fin 3 → ℂ) 0 := a0.symm.trans b0
  norm_num at hcontra

end MathCorpus.Frontier.Jacobian
