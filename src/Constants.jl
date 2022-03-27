#@constant(HubbleConstant, H, "Hubble constant", 74.03, BigFloat(74.03),
#            u"km/s/Mpc", 1.42, BigFloat(1.42), "Hubble Space Telescope 2019-03-18")

#@constant(MONDianGravitationalConstant, ACC0, "Modified gravitational acceleration", 1.2e-8, BigFloat(1.2e-8),
#            u"cm/s^2", 0.0, BigFloat(0.0), "Milgrom 1983")
const ACC0 = 1.2e-8u"cm/s^2"
const HubbleConstant = 74.03u"km/s/Mpc"

"""
$(TYPEDEF)
$(TYPEDFIELDS)
"""
struct Constant
    "light speed"
    c
    "Newtonian constant of gravitation"
    G
    "Planck constant"
    h
    "Elementary charge"
    e
    "Electron mass"
    m_e
    "Neutron mass"
    m_n
    "Protron mass"
    m_p
    "Stefan-Boltzmann constant"
    σ
    "Hubble constant"
    H
    "Kelvin-Boltzmann constant"
    k_B
    "Vacuum electric permittivity (electric constant)"
    ε_0
    "Vacuum magnetic permeability"
    μ_0

    "Modified gravitational acceleration constant"
    ACC0
end

"""
$(TYPEDSIGNATURES)
Construct an immutable struct storing basic physical constants corresponding to `units` (default is `uAstro`).

## Keywords

- c:    Speed of light
- G:    Newtonian constant of gravitation
- m_e:  Electron mass
- m_n:  Neutron mass
- m_p:  Protron mass
- k_B:  Kelvin-Boltzmann constant
- ACC0: Modified gravitational acceleration constant

## Examples

```jl
Constant()
Constant(uSI)
Constant(uCGS)
using Unitful
ustrip(Constant())
```
"""
function Constant(units = uAstro;
    c_0 = CODATA2018.c_0,
    G = CODATA2018.G,
    h = CODATA2018.h,
    e = CODATA2018.e,
    m_e = CODATA2018.m_e,
    m_n = CODATA2018.m_n,
    m_p = CODATA2018.m_p,
    σ = CODATA2018.σ,
    H = HubbleConstant,
    k_B = CODATA2018.k_B,
    ε_0 = CODATA2018.ε_0,
    μ_0 = CODATA2018.μ_0,
    ACC0 = ACC0,
)
    if isnothing(units)
        error(
        """
        Cannot determine unitless constants. Please construct unitful constants and then strip the units.
        For example, `Constant(nothing, uAstro)` or `Constant(nothing, Constant(uAstro))`
        """)
    end
    
    return Constant(
        uconvert(getuVel(units), c_0),
        uconvert(units[1]^3 / units[6] / units[2]^2, G),
        uconvert(units[6] * units[1]^2 / units[2], h),
        uconvert(units[3] * units[2], e),
        uconvert(getuMass(units), m_e),
        uconvert(getuMass(units), m_n),
        uconvert(getuMass(units), m_p),
        uconvert(units[6] / units[4]^4 / units[2]^3, σ),
        uconvert(units[2]^-1, H),
        uconvert(units[1]^2 * units[6] / units[2]^2 / units[4], k_B),
        uconvert(units[1]^-3 * units[6]^-1 * units[2]^4 * units[3]^2, ε_0),
        uconvert(units[6] * units[1] / units[2]^2 / units[3]^2, μ_0),
        uconvert(getuAcc(units), ACC0),
    )
end

function Constant(::Nothing, c::Constant)
   return Constant([ustrip(getfield(c, n)) for n in fieldnames(Constant)]...)
end

function Constant(::Nothing, units)
    return Constant(nothing, Constant(units))
end

"""
$(TYPEDSIGNATURES)
Construct an immutable struct storing basic physical constants in `BigFloat` corresponding to `units` (default is `uAstro`).
"""
function Constant(::Type{BigFloat}, units::Vector{Unitful.FreeUnits{N, D, nothing} where D where N})
    return Constant(
        uconvert(getuVel(units), BigFloat(CODATA2018.c_0)),
        uconvert(units[1]^3 / units[6] / units[2]^2, BigFloat(CODATA2018.G)),
        uconvert(units[6] * units[1]^2 / units[2], BigFloat(CODATA2018.h)),
        uconvert(units[3] * units[2], BigFloat(CODATA2018.e)),
        uconvert(getuMass(units), BigFloat(CODATA2018.m_e)),
        uconvert(getuMass(units), BigFloat(CODATA2018.m_n)),
        uconvert(getuMass(units), BigFloat(CODATA2018.m_p)),
        uconvert(units[6] / units[4]^4 / units[2]^3, BigFloat(CODATA2018.σ)),
        uconvert(units[2]^-1, BigFloat("2.399148907975663e-18")u"s^-1"),
        uconvert(units[1]^2 * units[6] / units[2]^2 / units[4], BigFloat(CODATA2018.k_B)),
        uconvert(units[1]^-3 * units[6]^-1 * units[2]^4 * units[3]^2, BigFloat(CODATA2018.ε_0)),
        uconvert(units[6] * units[1] / units[2]^2 / units[3]^2, BigFloat(CODATA2018.μ_0)),
        uconvert(getuAcc(units), BigFloat("1.2e-8")u"cm/s^2"),
    )
end

"""
$(TYPEDSIGNATURES)
Construct an immutable struct storing basic physical constants in `Measurement` corresponding to `units` (default is `uAstro`).
"""
function Constant(::Type{Measurement}, units::Vector{Unitful.FreeUnits{N, D, nothing} where D where N})
    return Constant(
        uconvert(getuVel(units), measurement(CODATA2018.c_0)),
        uconvert(units[1]^3 / units[6] / units[2]^2, measurement(CODATA2018.G)),
        uconvert(units[6] * units[1]^2 / units[2], measurement(CODATA2018.h)),
        uconvert(units[3] * units[2], measurement(CODATA2018.e)),
        uconvert(getuMass(units), measurement(CODATA2018.m_e)),
        uconvert(getuMass(units), measurement(CODATA2018.m_n)),
        uconvert(getuMass(units), measurement(CODATA2018.m_p)),
        uconvert(units[6] / units[4]^4 / units[2]^3, measurement(CODATA2018.σ)),
        uconvert(units[2]^-1, measurement(HubbleConstant, 1.42/74.03*HubbleConstant)),
        uconvert(units[1]^2 * units[6] / units[2]^2 / units[4], measurement(CODATA2018.k_B)),
        uconvert(units[1]^-3 * units[6]^-1 * units[2]^4 * units[3]^2, measurement(CODATA2018.ε_0)),
        uconvert(units[6] * units[1] / units[2]^2 / units[3]^2, measurement(CODATA2018.μ_0)),
        uconvert(getuAcc(units), measurement(ACC0, 0.0*ACC0)),
    )
end

"""
$(TYPEDSIGNATURES)
"""
function Constant(::Type{T}, units::Vector{Unitful.FreeUnits{N, D, nothing} where D where N};
    ACC0 = ACC0,
    H = HubbleConstant,
) where T<:Real
    return Constant(
        T(uconvert(getuVel(units), CODATA2018.c_0)),
        T(uconvert(units[1]^3 / units[6] / units[2]^2, CODATA2018.G)),
        T(uconvert(units[6] * units[1]^2 / units[2], CODATA2018.h)),
        T(uconvert(units[3] * units[2], CODATA2018.e)),
        T(uconvert(getuMass(units), CODATA2018.m_e)),
        T(uconvert(getuMass(units), CODATA2018.m_n)),
        T(uconvert(getuMass(units), CODATA2018.m_p)),
        T(uconvert(units[6] / units[4]^4 / units[2]^3, CODATA2018.σ)),
        T(uconvert(units[2]^-1, H)),
        T(uconvert(units[1]^2 * units[6] / units[2]^2 / units[4], CODATA2018.k_B)),
        T(uconvert(units[1]^-3 * units[6]^-1 * units[2]^4 * units[3]^2, CODATA2018.ε_0)),
        T(uconvert(units[6] * units[1] / units[2]^2 / units[3]^2, CODATA2018.μ_0)),
        T(uconvert(getuAcc(units), ACC0)),
    )
end

function ustrip(c::Constant)
    return Constant([ustrip(getfield(c, n)) for n in fieldnames(Constant)]...)
end

function Base.show(io::IO, c::Constant)
    print(io,
        """
        Converted Constants:
               c = $(c.c) (light speed)
               G = $(c.G) (Newtonian constant of gravitation)
               h = $(c.h) (Planck constant)
               e = $(c.e) (Elementary charge)
             m_e = $(c.m_e) (Electron mass)
             m_n = $(c.m_n) (Neutron mass)
             m_p = $(c.m_p) (Protron mass)
               σ = $(c.σ) (Stefan-Boltzmann constant)
               H = $(c.H) (Hubble constant)
             k_B = $(c.k_B) (Kelvin-Boltzmann constant)
             ε_0 = $(c.ε_0) (Vacuum electric permittivity)
             μ_0 = $(c.μ_0) (Vacuum magnetic permeability)
            ACC0 = $(c.ACC0) (Modified gravitational acceleration constant)
        """
    )
end