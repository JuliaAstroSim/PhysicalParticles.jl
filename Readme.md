# PhysicalParticles.jl

[![codecov](https://codecov.io/gh/JuliaAstroSim/PhysicalParticles.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/JuliaAstroSim/PhysicalParticles.jl)
[![][docs-dev-img]][docs-dev-url]

*Physical particle types for scientific simulation. Manipulate vectors as simple as numbers!*

## Installation

```julia
]add PhysicalParticles
```

or

```julia
using Pkg; Pkg.add("PhysicalParticles")
```

or

```julia
using Pkg; Pkg.add("https://github.com/JuliaAstroSim/PhysicalParticles.jl")
```

To test the Package:
```julia
]test PhysicalParticles
```

## Documentation

- [**Dev**][docs-dev-url] &mdash; *documentation of the in-development version.*



[docs-dev-img]: https://img.shields.io/badge/docs-dev-blue.svg
[docs-dev-url]: https://juliaastrosim.github.io/PhysicalParticles.jl/dev

## Basic Usage

### Vectors

```julia
julia> using PhysicalParticles, Unitful, UnitfulAstro

julia> a = PVector()
PVector{Float64}(0.0, 0.0, 0.0)

julia> b = PVector(1.0u"m", 2.0u"m", 3.0u"m")
PVector(1.0 m, 2.0 m, 3.0 m)

julia> c = PVector2D(u"m/s")
PVector2D(0.0 m s^-1, 0.0 m s^-1)



julia> PVector(1.0, 1.0) * im
PVector2D{Complex{Float64}}(0.0 + 1.0im, 0.0 + 1.0im)

julia> b * 2.0u"s"
PVector(2.0 m s, 4.0 m s, 6.0 m s)

julia> b + PVector(2.0, 2.0, 2.0, u"m") / 2
PVector(2.0 m, 3.0 m, 4.0 m)

julia> norm(PVector2D(3.0f0,4.0f0))
5.0f0

julia> normalize(PVector(3.0, 4.0))
PVector2D{Float64}(0.6, 0.8)

julia> d = PVector(3u"kpc", 4u"kpc")
PVector2D(3 kpc, 4 kpc)

julia> norm(d)
1.5428387907456837e20 m



julia> distance(PVector2D(0.0, 0.0), PVector2D(3.0, 4.0))
5.0

julia> rotate(PVector(1.0, 0.0), 0.5pi)
PVector2D{Float64}(6.123233995736766e-17, 1.0)
```

### Particles

We provide 2D version for each type below, for example, the 2D version of `Ball` is `Ball2D`:
```julia
julia> Massless()
Massless 0: Pos = PVector{Float64}(0.0, 0.0, 0.0), Vel = PVector{Float64}(0.0, 0.0, 0.0)

julia> Massless(PVector(0.0, 0.0, 0.0), PVector(), 1)
Massless 1: Pos = PVector{Float64}(0.0, 0.0, 0.0), Vel = PVector{Float64}(0.0, 0.0, 0.0)

julia> Massless2D(uCGS)
Massless 0: Pos = PVector2D(0.0 cm, 0.0 cm), Vel = PVector2D(0.0 cm s^-1, 0.0 cm s^-1)

julia> Ball()
Ball 0: Pos = PVector{Float64}(0.0, 0.0, 0.0), Vel = PVector{Float64}(0.0, 0.0, 0.0), Acc = PVector{Float64}(0.0, 0.0, 0.0), Mass = 0.0

julia> Ball(PVector(0.0u"m", 0.0u"m", 0.0u"m"), PVector(u"m/s"), PVector(u"m/s^2"), 0.0u"kg", 1)
Ball 1: Pos = PVector(0.0 m, 0.0 m, 0.0 m), Vel = PVector(0.0 m s^-1, 0.0 m s^-1, 0.0 m s^-1), Acc = PVector(0.0 m s^-2, 0.0 m s^-2, 0.0 m s^-2), Mass = 0.0 kg

julia> Star()
Star 0 STAR: Pos = PVector{Float64}(0.0, 0.0, 0.0), Vel = PVector{Float64}(0.0, 0.0, 0.0), Acc = PVector{Float64}(0.0, 0.0, 0.0), Mass = 0.0, Ti_endstep = 0, Ti_begstep = 0, Potential = 0.0, OldAcc = 0.0

julia> SPHGas()
SPHGas 0 GAS: Pos = PVector{Float64}(0.0, 0.0, 0.0), Vel = PVector{Float64}(0.0, 0.0, 0.0), Acc = PVector{Float64}(0.0, 0.0, 0.0), Mass = 0.0, Ti_endstep = 0, Ti_begstep = 0, Potential = 0.0, OldAcc = 0.0, Entropy = 0.0, Density = 0.0, Hsml = 0.0, Left = 0.0, Right = 0.0, NumNgbFound = 0, RotVel = PVector{Float64}(0.0, 0.0, 0.0), DivVel = 0.0, CurlVel = 0.0, dHsmlRho = 0.0, Pressure = 0.0, DtEntropy = 0.0, MaxSignalVel = 0.0

julia> a = Star(uAstro)
Star 0 STAR: Pos = PVector(0.0 kpc, 0.0 kpc, 0.0 kpc), Vel = PVector(0.0 kpc Gyr^-1, 0.0 kpc Gyr^-1, 0.0 kpc Gyr^-1), Acc = PVector(0.0 kpc Gyr^-2, 0.0 kpc Gyr^-2, 0.0 kpc Gyr^-2), Mass = 0.0 M⊙, Ti_endstep = 0, Ti_begstep = 0, Potential = 0.0 kpc^2 M⊙ Gyr^-2, OldAcc = 0.0 kpc Gyr^-2

julia> b = SPHGas(uAstro)
SPHGas 0 GAS: Pos = PVector(0.0 kpc, 0.0 kpc, 0.0 kpc), Vel = PVector(0.0 kpc Gyr^-1, 0.0 kpc Gyr^-1, 0.0 kpc Gyr^-1), Acc = PVector(0.0 kpc Gyr^-2, 0.0 kpc Gyr^-2, 0.0 kpc Gyr^-2), Mass = 0.0 M⊙, Ti_endstep = 0, Ti_begstep = 0, Potential = 0.0 kpc^2 M⊙ Gyr^-2, OldAcc = 0.0 kpc Gyr^-2, Entropy = 0.0 kpc^2 M⊙ Gyr^-2 K^-1, Density = 0.0 M⊙ kpc^-3, Hsml = 0.0 kpc, Left = 0.0, Right = 0.0, NumNgbFound = 0, RotVel = PVector(0.0 kpc Gyr^-1, 0.0 kpc Gyr^-1, 0.0 kpc Gyr^-1), DivVel = 0.0 Gyr^-1, CurlVel = 0.0 Gyr^-1, dHsmlRho = 0.0 kpc, Pressure = 0.0 M⊙ Gyr^-2 kpc^-1, DtEntropy = 0.0 kpc^2 M⊙ Gyr^-3 K^-1, MaxSignalVel = 0.0 kpc Gyr^-1

julia> distance(a,b)
0.0 m
```

### Random and Conversion

```julia
julia> p = rand_pvector(3)
3-element Array{PVector{Float64},1}:
 PVector{Float64}(0.899541890819791, 0.49609709458549345, 0.22817220536717397)
 PVector{Float64}(0.21907343513386301, 0.39110699072427035, 0.3502946880565312)
 PVector{Float64}(0.8107782153679699, 0.20218167820102884, 0.94236923352867)

julia> pu = rand_pvector(3, u"m")
3-element Array{PVector{Quantity{Float64,𝐋,Unitful.FreeUnits{(m,),𝐋,nothing}}},1}:
 PVector(0.5346672699901402 m, 0.6988269071898365 m, 0.8120077168096169 m)  
 PVector(0.46886820909936744 m, 0.9575982422487646 m, 0.10413358701332642 m)
 PVector(0.0219005354136228 m, 0.327612194392396 m, 0.2837471711064179 m)

julia> p_Ball = [Ball(uSI) for i=1:3]
3-element Array{Ball{Int64},1}:
 Ball 0: Pos = PVector(0.0 m, 0.0 m, 0.0 m), Vel = PVector(0.0 m s^-1, 0.0 m s^-1, 0.0 m s^-1), Acc = PVector(0.0 m s^-2, 0.0 m s^-2, 0.0 m s^-2), Mass = 0.0 kg
 Ball 0: Pos = PVector(0.0 m, 0.0 m, 0.0 m), Vel = PVector(0.0 m s^-1, 0.0 m s^-1, 0.0 m s^-1), Acc = PVector(0.0 m s^-2, 0.0 m s^-2, 0.0 m s^-2), Mass = 0.0 kg
 Ball 0: Pos = PVector(0.0 m, 0.0 m, 0.0 m), Vel = PVector(0.0 m s^-1, 0.0 m s^-1, 0.0 m s^-1), Acc = PVector(0.0 m s^-2, 0.0 m s^-2, 0.0 m s^-2), Mass = 0.0 kg

julia> assign_points(p_Ball, :Pos, pu)

julia> p_Ball
3-element Array{Ball{Int64},1}:
 Ball 0: Pos = PVector(0.5346672699901402 m, 0.6988269071898365 m, 0.8120077168096169 m), Vel = PVector(0.0 m s^-1, 0.0 m s^-1, 0.0 m s^-1), Acc = PVector(0.0 m s^-2, 0.0 m s^-2, 0.0 m s^-2), Mass = 0.0 kg
 Ball 0: Pos = PVector(0.46886820909936744 m, 0.9575982422487646 m, 0.10413358701332642 m), Vel = PVector(0.0 m s^-1, 0.0 m 
s^-1, 0.0 m s^-1), Acc = PVector(0.0 m s^-2, 0.0 m s^-2, 0.0 m s^-2), Mass = 0.0 kg
 Ball 0: Pos = PVector(0.0219005354136228 m, 0.327612194392396 m, 0.2837471711064179 m), Vel = PVector(0.0 m s^-1, 0.0 m s^-1, 0.0 m s^-1), Acc = PVector(0.0 m s^-2, 0.0 m s^-2, 0.0 m s^-2), Mass = 0.0 kg


julia> pconvert([1.0, 2.0, 3.0])
PVector{Float64}(1.0, 2.0, 3.0)

julia> pconvert([1.0u"m" 4.0u"m";
                 2.0u"m" 5.0u"m";
                 3.0u"m" 6.0u"m"])
2-element Array{PVector,1}:
 PVector(1.0 m, 2.0 m, 3.0 m)
 PVector(4.0 m, 5.0 m, 6.0 m)
```

### Extent

```julia
julia> p = [Ball(PVector(-1.0u"m", 1.0u"m", 1.0u"m"), PVector(u"m/s"), PVector(u"m/s^2"), 1.0u"kg", 1),
            Ball(PVector(1.0u"m", -1.0u"m", -1.0u"m"), PVector(u"m/s"), PVector(u"m/s^2"), 1000.0u"g", 2)]
2-element Array{Ball{Int64},1}:
 Ball 1: Pos = PVector(-1.0 m, 1.0 m, 1.0 m), Vel = PVector(0.0 m s^-1, 0.0 m s^-1, 0.0 m s^-1), Acc = PVector(0.0 m s^-2, 0.0 m s^-2, 0.0 m s^-2), Mass = 1.0 kg
 Ball 2: Pos = PVector(1.0 m, -1.0 m, -1.0 m), Vel = PVector(0.0 m s^-1, 0.0 m s^-1, 0.0 m s^-1), Acc = PVector(0.0 m s^-2, 0.0 m s^-2, 0.0 m s^-2), Mass = 1000.0 g

julia> min_x(p)
-1.0 m

julia> max_z(p)
1.0 m

julia> center(p)
PVector(0.0 m, 0.0 m, 0.0 m)

julia> mass_center(p)
PVector(0.0 m, 0.0 m, 0.0 m)

julia> extent(p)
Extent: , xMin = -1.0 m, xMax = 1.0 m, yMin = -1.0 m, yMax = 1.0 m, zMin = -1.0 m, zMax = 1.0 m, SideLength = 2.0 m, Center 
= PVector(0.0 m, 0.0 m, 0.0 m), Corner = PVector(-1.0 m, -1.0 m, -1.0 m)
```

### Default Unit

Units are supported by [Unitful.jl](https://github.com/PainterQubits/Unitful.jl) and [UnitfulAstro.jl](https://github.com/JuliaAstro/UnitfulAstro.jl)

Set default units by
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

## References

- [GeometicalPredicates.jl](https://github.com/JuliaGeometry/GeometricalPredicates.jl)