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

Examples to get basic units:
```@repl
using PhysicalParticles
getunits()
getunits(uAstro)
getunits(nothing)
getuLength()
getuTime(uSI)
getuCurrent(uCGS)
getuTemperature(nothing)
getuLuminosity()
getuMass()
getuAmount()
```