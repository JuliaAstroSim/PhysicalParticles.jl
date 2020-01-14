# Units

Units are supported by [Unitful.jl](https://github.com/PainterQubits/Unitful.jl) and [UnitfulAstro.jl](https://github.com/JuliaAstro/UnitfulAstro.jl)

## Default Units

You could set preferred units by
```julia
const uSI = u"m,s,A,K,cd,kg,mol"
preferunits(uSI)
```
or simply call `si()`. `astro()` and `cgs()` are implemented in the same way.

This would affect both unit promotions in `Unitful` package and default outputs in related packages, by setting `Unitful.promotion` and `PhysicalParticles.uDefaults` respectively.

## Constants

Prefered constants in `PhysicalParticles.jl`:
```julia
julia> Constants
PhysicalParticles.Constant(Speed of light in vacuum (c_0)
Value                         = 2.99792458e8 m s^-1
Standard uncertainty          = (exact)
Relative standard uncertainty = (exact)
Reference                     = CODATA 2018, Newtonian constant of gravitation (G)
Value                         = 6.6743e-11 m^3 kg^-1 s^-2
Standard uncertainty          = 1.5e-15 m^3 kg^-1 s^-2
Relative standard uncertainty = 2.2e-5
Reference                     = CODATA 2018, Planck constant (h)
Value                         = 6.62607015e-34 J s
Standard uncertainty          = (exact)
Relative standard uncertainty = (exact)
Reference                     = CODATA 2018, Elementary charge (e)
Value                         = 1.602176634e-19 C
Standard uncertainty          = (exact)
Relative standard uncertainty = (exact)
Reference                     = CODATA 2018, Electron mass (m_e)
Value                         = 9.1093837015e-31 kg
Standard uncertainty          = 2.8e-40 kg
Relative standard uncertainty = 3.1e-10
Reference                     = CODATA 2018, Neutron mass (m_n)
Value                         = 1.67492749804e-27 kg
Standard uncertainty          = 9.5e-37 kg
Relative standard uncertainty = 5.7e-10
Reference                     = CODATA 2018, Proton mass (m_p)
Value                         = 1.67262192369e-27 kg
Standard uncertainty          = 5.1e-37 kg
Relative standard uncertainty = 3.0e-10
Reference                     = CODATA 2018, Stefan-Boltzmann constant (σ)
Value                         = 5.6703744191844294e-8 W K^-4 m^-2
Standard uncertainty          = (exact)
Relative standard uncertainty = (exact)
Reference                     = CODATA 2018, Hubble constant (H)
Value                         = 74.03 km Mpc^-1 s^-1
Standard uncertainty          = 1.42 km Mpc^-1 s^-1
Relative standard uncertainty = 0.019
Reference                     = Hubble Space Telescope 2019-03-18, Modified gravitational acceleration (ACC0)
Value                         = 1.2e-8 cm s^-2
Standard uncertainty          = (exact)
Relative standard uncertainty = (exact)
Reference                     = Milgrom 1983)
```