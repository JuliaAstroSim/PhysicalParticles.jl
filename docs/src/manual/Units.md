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

## Constants

Physical constants are imported from `CODATA2018` supported by [PhysicalConstants.jl](https://github.com/JuliaPhysics/PhysicalConstants.jl). However, constants in `PhysicalConstants` may cause type error if they are not converted to default units.

To prevent this problem, construct an immutable struct `Constant` corresponding to the provided `units`:
```@repl
using PhysicalParticles
Constant()
Constant(uSI)
Constant(uCGS)
using Unitful
ustrip(Constant())
```

## Zerovalues

`ZeroValue` is useful for accumulated summation, array initialization, etc. Examples:
```@repl
using PhysicalParticles
ZeroValue(nothing)
ZeroValue()
ZeroValue(uSI)
ZeroValue(uCGS)
```