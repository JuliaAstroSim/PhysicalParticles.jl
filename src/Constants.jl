#@constant(HubbleConstant, H, "Hubble constant", 74.03, BigFloat(74.03),
#            u"km/s/Mpc", 1.42, BigFloat(1.42), "Hubble Space Telescope 2019-03-18")

#@constant(MONDianGravitationalConstant, ACC0, "Modified gravitational acceleration", 1.2e-8, BigFloat(1.2e-8),
#            u"cm/s^2", 0.0, BigFloat(0.0), "Milgrom 1983")
const ACC0 = 1.2e-8u"cm/s^2"

struct Constant{CC, GC, ACC0, MASS, K_B}
    c::CC     # light speed
    G::GC     # Newtonian constant of gravitation
    #h::AbstractQuantity     # Planck constant
    #e::AbstractQuantity     # Elementary charge
    m_e::MASS   # Electron mass
    m_n::MASS   # Neutron mass
    m_p::MASS   # Protron mass
    #σ::AbstractQuantity     # Stefan-Boltzmann constant
    #H::HC     # Hubble constant
    k_B::K_B    # Kelvin-Boltzmann constant

    ACC0::ACC0  # Modified gravitational acceleration constant
end

"""
    function Constant(units = uAstro; kw...)

    Construct an immutable struct storing basic physical constants corresponding to `units` (default is `uAstro`).

# Keywords

- c:    Speed of light
- G:    Newtonian constant of gravitation
- m_e:  Electron mass
- m_n:  Neutron mass
- m_p:  Protron mass
- k_B:  Kelvin-Boltzmann constant
- ACC0: Modified gravitational acceleration constant

# Examples

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
    #h = CODATA2018.h,
    #e = CODATA2018.e,
    m_e = CODATA2018.m_e,
    m_n = CODATA2018.m_n,
    m_p = CODATA2018.m_p,
    #σ = CODATA2018.σ,
    #H = H,
    k_B = CODATA2018.k_B,
    ACC0 = ACC0,
)
    return Constant(
        uconvert(getuVel(units), c_0),
        uconvert(units[1]^3 / units[6] / units[2]^2, G),
        #uconvert(units[6] * units[1]^2 / units[2], h),
        #uconvert(units[3] * units[2], e),
        uconvert(getuMass(units), m_e),
        uconvert(getuMass(units), m_n),
        uconvert(getuMass(units), m_p),
        #uconvert(units[6] / units[4]^4 / units[2]^3, σ),
        #uconvert(units[2]^-1, H),
        uconvert(units[1]^2 * units[6] / units[2]^2 / units[4], k_B),
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
    Constant(::Type{BigFloat}, units::Vector{Unitful.FreeUnits{N, D, nothing} where D where N})

Construct an immutable struct storing basic physical constants in `BigFloat` corresponding to `units` (default is `uAstro`).
"""
function Constant(::Type{BigFloat}, units::Vector{Unitful.FreeUnits{N, D, nothing} where D where N})
    println("Constructing BigFloat constants")
    return Constant(
        uconvert(getuVel(units), BigFloat("299792458")u"m/s"),
        uconvert(units[1]^3 / units[6] / units[2]^2, BigFloat("6.67430e-11")u"m^3/kg/s^2"),
        #uconvert(units[6] * units[1]^2 / units[2], BigFloat("6.62607015e-34")u"J*s"),
        #uconvert(units[3] * units[2], BigFloat("1.602176634e-19")u"C"),
        uconvert(getuMass(units), BigFloat("9.1093837015e-31")u"kg"),
        uconvert(getuMass(units), BigFloat("1.67492749804e-27")u"kg"),
        uconvert(getuMass(units), BigFloat("1.67262192369e-27")u"kg"),
        #uconvert(units[6] / units[4]^4 / units[2]^3, BigFloat("5.6703744191844294e-8")u"W/K^4/m^2"),
        #uconvert(units[2]^-1, BigFloat("")),
        uconvert(units[1]^2 * units[6] / units[2]^2 / units[4], BigFloat("1.380649e-23")u"J/K"),
        uconvert(getuAcc(units), BigFloat("1.2e-8")u"cm/s^2"),
    )
end

"""
    Constant(::Type{Measurement}, units::Vector{Unitful.FreeUnits{N, D, nothing} where D where N})

Construct an immutable struct storing basic physical constants in `Measurement` corresponding to `units` (default is `uAstro`).
"""
function Constant(::Type{Measurement}, units::Vector{Unitful.FreeUnits{N, D, nothing} where D where N})
    println("Constructing Unitless Measurement constants")
    return Constant(
        uconvert(getuVel(units), measurement(CODATA2018.c_0)),
        uconvert(units[1]^3 / units[6] / units[2]^2, measurement(CODATA2018.G)),
        #uconvert(units[6] * units[1]^2 / units[2], measurement(CODATA2018.h)),
        #uconvert(units[3] * units[2], measurement(CODATA2018.e)),
        uconvert(getuMass(units), measurement(CODATA2018.m_e)),
        uconvert(getuMass(units), measurement(CODATA2018.m_n)),
        uconvert(getuMass(units), measurement(CODATA2018.m_p)),
        #uconvert(units[6] / units[4]^4 / units[2]^3, measurement(CODATA2018.σ)),
        #uconvert(units[2]^-1, measurement(CODATA2018.H)),
        uconvert(units[1]^2 * units[6] / units[2]^2 / units[4], measurement(CODATA2018.k_B)),
        uconvert(getuAcc(units), measurement(ACC0, 0.0*ACC0)),
    )
end

function ustrip(c::Constant)
    return Constant([ustrip(getfield(c, n)) for n in fieldnames(Constant)]...)
end

function Base.show(io::IO, c::Constant)
    print(io,
        "Converted Constants:",
        "\n    c = ", c.c,
        "\n    G = ", c.G,
        "\n    m_e = ", c.m_e,
        "\n    m_n = ", c.m_n,
        "\n    m_p = ", c.m_p,
        "\n    k_B = ", c.k_B,
        "\n    ACC0 = ", c.ACC0,
    )
end