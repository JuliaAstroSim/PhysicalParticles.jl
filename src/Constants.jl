#@constant(HubbleConstant, H, "Hubble constant", 74.03, BigFloat(74.03),
#            u"km/s/Mpc", 1.42, BigFloat(1.42), "Hubble Space Telescope 2019-03-18")

#@constant(MONDianGravitationalConstant, ACC0, "Modified gravitational acceleration", 1.2e-8, BigFloat(1.2e-8),
#            u"cm/s^2", 0.0, BigFloat(0.0), "Milgrom 1983")
const ACC0 = 1.2e-8u"cm/s^2"

struct Constant{GC, ACC0, MASS, K_B}
    #c::cC     # light speed
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

function Constant(units = uAstro;
    #c_0 = CODATA2018.c_0,
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
        #uconvert(getuVel(units), c),
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

function Base.show(io::IO, c::Constant)
    print(io,
        "Converted Constants:",
        "\n    G = ", c.G,
        "\n    m_e = ", c.m_e,
        "\n    m_n = ", c.m_n,
        "\n    m_p = ", c.m_p,
        "\n    k_B = ", c.k_B,
        "\n    ACC0 = ", c.ACC0,
    )
end