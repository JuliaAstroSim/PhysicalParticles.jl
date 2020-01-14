@constant(HubbleConstant, H, "Hubble constant", 74.03, BigFloat(74.03),
            u"km/s/Mpc", 1.42, BigFloat(1.42), "Hubble Space Telescope 2019-03-18")
@constant(MONDianGravitationalConstant, ACC0, "Modified gravitational acceleration", 1.2e-8, BigFloat(1.2e-8),
            u"cm/s^2", 0.0, BigFloat(0.0), "Milgrom 1983")
struct Constant
    c::PhysicalConstant # light speed
    G::PhysicalConstant # Newtonian constant of gravitation
    h::PhysicalConstant # Planck constant
    e::PhysicalConstant # Elementary charge
    m_e::PhysicalConstant # Electron mass
    m_n::PhysicalConstant # Neutron mass
    m_p::PhysicalConstant # Protron mass
    stefan_boltzmann::PhysicalConstant # Stefan-Boltzmann constant
    H::PhysicalConstant # Hubble constant

    ACC0::PhysicalConstant # Modified gravitational acceleration constant
end
Constant() = Constant(CODATA2018.c_0,
                      CODATA2018.G,
                      CODATA2018.h,
                      CODATA2018.e,
                      CODATA2018.m_e,
                      CODATA2018.m_n,
                      CODATA2018.m_p,
                      CODATA2018.σ,
                      H,
                      ACC0)

Constants = Constant()