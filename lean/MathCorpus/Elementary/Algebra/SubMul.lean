import Mathlib

/-!
# Right distributivity over subtraction

Packet: `elementary.algebra.sub_mul.v1`
Level:  L0_elementary · Domain: algebra · Trust rung 1 (Lean kernel).

Multiplication distributes over subtraction on the right: (a - b) * c =
a*c - b*c. Completes the mul_add'/add_mul' distributivity family.
Kernel-verified through the tracked proof-search loop (episode ed63843f).
-/

namespace MathCorpus.Elementary.Algebra

theorem sub_mul' (a b c : ℤ) : (a - b) * c = a * c - b * c := sub_mul a b c

end MathCorpus.Elementary.Algebra
