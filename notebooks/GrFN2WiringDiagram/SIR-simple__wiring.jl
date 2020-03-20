using Catlab
using Catlab.WiringDiagrams
using Catlab.Doctrines
import Catlab.Doctrines: ⊗, id
import Base: ∘
include("SIR-simple__functions.jl")
⊗(a::WiringDiagram, b::WiringDiagram) = otimes(a, b)
∘(a::WiringDiagram, b::WiringDiagram) = compose(b, a)
⊚(a,b) = b ∘ a


SIR_simple__global__sir__0__beta__neg1, SIR_simple__global__sir__0__S__neg1, SIR_simple__global__sir__0__I__neg1, SIR_simple__global__sir__0__R__neg1, SIR_simple__global__sir__0__dt__neg1, SIR_simple__global__sir__0__gamma__neg1 = Ob(FreeSymmetricMonoidalCategory, :SIR_simple__global__sir__0__beta__neg1, :SIR_simple__global__sir__0__S__neg1, :SIR_simple__global__sir__0__I__neg1, :SIR_simple__global__sir__0__R__neg1, :SIR_simple__global__sir__0__dt__neg1, :SIR_simple__global__sir__0__gamma__neg1)
SIR_simple__global__sir__0__infected__0, SIR_simple__global__sir__0__recovered__0 = Ob(FreeSymmetricMonoidalCategory, :SIR_simple__global__sir__0__infected__0, :SIR_simple__global__sir__0__recovered__0)
SIR_simple__global__sir__0__I__0, SIR_simple__global__sir__0__S__0, SIR_simple__global__sir__0__R__0 = Ob(FreeSymmetricMonoidalCategory, :SIR_simple__global__sir__0__I__0, :SIR_simple__global__sir__0__S__0, :SIR_simple__global__sir__0__R__0)


id_SIR_simple__global__sir__0__R__neg1 = id(Ports([SIR_simple__global__sir__0__R__neg1]))
id_SIR_simple__global__sir__0__S__neg1 = id(Ports([SIR_simple__global__sir__0__S__neg1]))
id_SIR_simple__global__sir__0__I__neg1 = id(Ports([SIR_simple__global__sir__0__I__neg1]))


IN_0 = WiringDiagram(Hom(:L0_REWIRE, SIR_simple__global__sir__0__beta__neg1 ⊗ SIR_simple__global__sir__0__S__neg1 ⊗ SIR_simple__global__sir__0__I__neg1 ⊗ SIR_simple__global__sir__0__R__neg1 ⊗ SIR_simple__global__sir__0__dt__neg1 ⊗ SIR_simple__global__sir__0__gamma__neg1, SIR_simple__global__sir__0__beta__neg1 ⊗ SIR_simple__global__sir__0__S__neg1 ⊗ SIR_simple__global__sir__0__I__neg1 ⊗ SIR_simple__global__sir__0__R__neg1 ⊗ SIR_simple__global__sir__0__dt__neg1 ⊗ SIR_simple__global__sir__0__gamma__neg1 ⊗ SIR_simple__global__sir__0__I__neg1 ⊗ SIR_simple__global__sir__0__dt__neg1 ⊗ SIR_simple__global__sir__0__R__neg1 ⊗ SIR_simple__global__sir__0__S__neg1 ⊗ SIR_simple__global__sir__0__I__neg1))
WD_SIR_simple__global__sir__0__recovered__0 = WiringDiagram(Hom(SIR_simple__sir__assign__recovered__0, SIR_simple__global__sir__0__gamma__neg1 ⊗ SIR_simple__global__sir__0__I__neg1 ⊗ SIR_simple__global__sir__0__dt__neg1, SIR_simple__global__sir__0__recovered__0))
WD_SIR_simple__global__sir__0__infected__0 = WiringDiagram(Hom(SIR_simple__sir__assign__infected__0, SIR_simple__global__sir__0__beta__neg1 ⊗ SIR_simple__global__sir__0__S__neg1 ⊗ SIR_simple__global__sir__0__I__neg1 ⊗ SIR_simple__global__sir__0__R__neg1 ⊗ SIR_simple__global__sir__0__dt__neg1, SIR_simple__global__sir__0__infected__0))
OUT_1 = IN_0 ⊚ (WD_SIR_simple__global__sir__0__infected__0 ⊗ WD_SIR_simple__global__sir__0__recovered__0 ⊗ id_SIR_simple__global__sir__0__R__neg1 ⊗ id_SIR_simple__global__sir__0__S__neg1 ⊗ id_SIR_simple__global__sir__0__I__neg1)


IN_1 = WiringDiagram(Hom(:L1_REWIRE, SIR_simple__global__sir__0__infected__0 ⊗ SIR_simple__global__sir__0__recovered__0 ⊗ SIR_simple__global__sir__0__R__neg1 ⊗ SIR_simple__global__sir__0__S__neg1 ⊗ SIR_simple__global__sir__0__I__neg1, SIR_simple__global__sir__0__I__neg1 ⊗ SIR_simple__global__sir__0__infected__0 ⊗ SIR_simple__global__sir__0__recovered__0 ⊗ SIR_simple__global__sir__0__S__neg1 ⊗ SIR_simple__global__sir__0__infected__0 ⊗ SIR_simple__global__sir__0__R__neg1 ⊗ SIR_simple__global__sir__0__recovered__0))
WD_SIR_simple__global__sir__0__R__0 = WiringDiagram(Hom(SIR_simple__sir__assign__R__0, SIR_simple__global__sir__0__R__neg1 ⊗ SIR_simple__global__sir__0__recovered__0, SIR_simple__global__sir__0__R__0))
WD_SIR_simple__global__sir__0__S__0 = WiringDiagram(Hom(SIR_simple__sir__assign__S__0, SIR_simple__global__sir__0__S__neg1 ⊗ SIR_simple__global__sir__0__infected__0, SIR_simple__global__sir__0__S__0))
WD_SIR_simple__global__sir__0__I__0 = WiringDiagram(Hom(SIR_simple__sir__assign__I__0, SIR_simple__global__sir__0__I__neg1 ⊗ SIR_simple__global__sir__0__infected__0 ⊗ SIR_simple__global__sir__0__recovered__0, SIR_simple__global__sir__0__I__0))
OUT_2 = OUT_1 ⊚ IN_1 ⊚ (WD_SIR_simple__global__sir__0__I__0 ⊗ WD_SIR_simple__global__sir__0__S__0 ⊗ WD_SIR_simple__global__sir__0__R__0)

