# Units

Units are supported by [Unitful.jl](https://github.com/PainterQubits/Unitful.jl) and [UnitfulAstro.jl](https://github.com/JuliaAstro/UnitfulAstro.jl)

## Default Units

You could set preferred units by
```julia
const uSI = u"m,s,A,K,cd,kg,mol"
preferunits(uSI)
```
or simply call `si()`. `astro()` and `cgs()` are implemented in the same way.

This would affect unit promotions in `Unitful` package and default outputs in related packages, by setting `Unitful.promotion` and `PhysicalParticles.uDefaults` respectively.

Interfaces to get basic units:
```
julia> getunits()
(m, s, A, K, cd, kg, mol)

julia> getunits(uAstro)
(kpc, Gyr, A, K, cd, M⊙, mol)

julia> getunits(nothing)
(nothing, nothing, nothing, nothing, nothing, nothing, nothing)

julia> getuLength()
m

julia> getuTime(uSI)
s

julia> getuCurrent(uCGS)
A

julia> getuTemperature(nothing)

julia> getuLuminosity()
cd

julia> getuMass()
kg

julia> getuAmount()
mol
```