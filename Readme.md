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

julia> uconvert(u"m", PVector(1.0, 1.0, 1.0, u"km"))
PVector(1000.0 m, 1000.0 m, 1000.0 m)

julia> PVector(BigFloat)
PVector{BigFloat}(0.0, 0.0, 0.0)

julia> PVector2D(BigInt, u"m")
PVector2D(0 m, 0 m)


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

julia> rotate(PVector(1.0, 0.0, 0.0), 0.0, 0.0, 0.5pi)
PVector{Float64}(6.123233995736766e-17, 1.0, 0.0)

julia> rotate_z(PVector(1.0, 0.0, 0.0), 90.0u"°")
PVector{Float64}(0.0, 1.0, 0.0)

julia> rotate(PVector(1.0, 0.0, 0.0), 0.0, 0.0, 90.0u"°", PVector(-1.0, 0.0, 0.0))
PVector{Float64}(-1.0, 2.0, 0.0)

julia> rotate(PVector(0.0, 1.0, 0.0), PVector(0.0, 1.0, 1.0), pi)
PVector{Float64}(-8.659560562354932e-17, -2.220446049250313e-16, 0.9999999999999998)

# Coordinate Transformations
julia> cylinderial(PVector(sqrt(2), sqrt(2), 1.0, u"m"))
(2.0 m, 0.7853981633974484, 1.0 m)

julia> cylinderial2xyz(2.0u"m", pi/4, 1.0u"m")
PVector(1.4142135623730951 m, 1.414213562373095 m, 1.0 m)

julia> spherical(PVector(sqrt(0.5), sqrt(0.5), 1.0, u"m"))
(1.4142135623730951 m, 0.7853981633974484, 0.7853981633974483)

julia> spherical2xyz(sqrt(2)u"m", pi/4, pi/4)
PVector(0.7071067811865476 m, 0.7071067811865475 m, 1.0000000000000002 m)

julia> zero(PVector{Float64})
PVector{Float64}(0.0, 0.0, 0.0)

julia> iszero(PVector(u"m"))
true

julia> isnan(PVector(NaN, NaN))
true

julia> PVector2D(1.0, 1.0) ≈ PVector2D(1.0 + 1.0e-8, 1.0 + 1.0e-8)
true


julia> ustrip(PVector(1.0, 1.0, 1.0, u"km"))
PVector{Float64}(1.0, 1.0, 1.0)

julia> ustrip(u"m", PVector(1.0, 1.0, 1.0, u"km"))
PVector{Float64}(1000.0, 1000.0, 1000.0)
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

### StructArrays.jl support

`StructArray` provides a more efficient way to iterate on a field of particles:
```julia
sArray = [Star() for i in 1:5]
sStruct = StructArray(sArray)

# Easier to set properties, and even faster!
sStruct.Mass[1] = 1000.0

assign_particles(sStruct, :Pos, randn_pvector(5))

mean(sStruct.Pos)
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
            Ball(PVector(3.0u"m", -3.0u"m", -3.0u"m"), PVector(u"m/s"), PVector(u"m/s^2"), 3000.0u"g", 2)]
2-element Array{Ball{Int64},1}:
 Ball 1: Pos = PVector(-1.0 m, 1.0 m, 1.0 m), Vel = PVector(0.0 m s^-1, 0.0 m s^-1, 0.0 m s^-1), Acc = PVector(0.0 m s^-2, 0.0 m s^-2, 0.0 m s^-2), Mass = 1.0 kg
 Ball 2: Pos = PVector(3.0 m, -3.0 m, -3.0 m), Vel = PVector(0.0 m s^-1, 0.0 m s^-1, 0.0 m s^-1), Acc = PVector(0.0 m s^-2, 0.0 m s^-2, 0.0 m s^-2), Mass = 1000.0 g

julia> minimum_x(p)
-1.0 m

julia> maximum_x(p)
3.0 m

julia> center(p)
PVector(1.0 m, -1.0 m, -1.0 m)

julia> pos_center(p)
PVector(1.0 m, -1.0 m, -1.0 m)

julia> mass_center(p)
PVector(2.0 m, -2.0 m, -2.0 m)

julia> median(p, :Pos)
PVector(1.0 m, -1.0 m, -1.0 m)

julia> extent(p)
Extent: xMin = -1.0 m, xMax = 3.0 m, yMin = -3.0 m, yMax = 1.0 m, zMin = -3.0 m, zMax = 1.0 m, SideLength = 4.0 m, Center = PVector(1.0 m, -1.0 m, -1.0 m)
```

There are differences among `center`, `pos_center`, `mass_center` and `median`:
- `center`: box center of particles
- `pos_center`: average position of particles
- `mass_center`: mass weighted average position of particles
- `median`: middle value of positions of particles

### Units

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

`axisunit` provides a convenient way to print units in the axis of plots:
```jl
julia> axisunit(nothing)
""

julia> axisunit(u"m")
" [m]"

julia> axisunit("Time", u"Gyr")
"TIme [Gyr]"
```

### Constants

Physical constants are imported from `CODATA2018` supported by [PhysicalConstants.jl](https://github.com/JuliaPhysics/PhysicalConstants.jl). However, constants in `PhysicalConstants` may cause type error if they are not converted to default units.

To prevent this problem, construct an immutable struct `Constant` corresponding to the provided `units`:
```jl
julia> Constant()
Converted Constants:
    G = 4.498502151469553e-6 kpc^3 M⊙^-1 Gyr^-2
    m_e = 4.581240435253955e-61 M⊙
    m_n = 8.423451938769546e-58 M⊙
    m_p = 8.411856872862986e-58 M⊙
    k_B = 7.2624677363918e-60 kpc^2 M⊙ K^-1 Gyr^-2
    ACC0 = 3872.920970357523 kpc Gyr^-2

julia> Constant(uSI)
Converted Constants:
    G = 6.6743e-11 m^3 kg^-1 s^-2
    m_e = 9.1093837015e-31 kg
    m_n = 1.67492749804e-27 kg
    m_p = 1.67262192369e-27 kg
    k_B = 1.380649e-23 kg m^2 K^-1 s^-2
    ACC0 = 1.2e-10 m s^-2

julia> Constant(uCGS)
Converted Constants:
    G = 6.674299999999999e-8 cm^3 g^-1 s^-2
    m_e = 9.1093837015e-28 g
    m_n = 1.67492749804e-24 g
    m_p = 1.67262192369e-24 g
    k_B = 1.380649e-16 g cm^2 K^-1 s^-2
    ACC0 = 1.2e-8 cm s^-2

julia> using Unitful

julia> ustrip(Constant())
Converted Constants:
    G = 4.498502151469553e-6
    m_e = 4.581240435253955e-61
    m_n = 8.423451938769546e-58
    m_p = 8.411856872862986e-58
    k_B = 7.2624677363918e-60
    ACC0 = 3872.920970357523
```

### Zerovalues

`ZeroValue` is useful for accumulated summation, array initialization, etc. Examples:
```jl
ZeroValue(nothing)
ZeroValue()
ZeroValue(uSI)
ZeroValue(uCGS)
```

## References

- [GeometicalPredicates.jl](https://github.com/JuliaGeometry/GeometricalPredicates.jl)

## Package ecosystem

- Basic data structure: [PhysicalParticles.jl](https://github.com/JuliaAstroSim/PhysicalParticles.jl)
- File I/O: [AstroIO.jl](https://github.com/JuliaAstroSim/AstroIO.jl)
- Initial Condition: [AstroIC.jl](https://github.com/JuliaAstroSim/AstroIC.jl)
- Parallelism: [ParallelOperations.jl](https://github.com/JuliaAstroSim/ParallelOperations.jl)
- Trees: [PhysicalTrees.jl](https://github.com/JuliaAstroSim/PhysicalTrees.jl)
- Meshes: [PhysicalMeshes.jl](https://github.com/JuliaAstroSim/PhysicalMeshes.jl)
- Plotting: [AstroPlot.jl](https://github.com/JuliaAstroSim/AstroPlot.jl)
- Simulation: [ISLENT](https://github.com/JuliaAstroSim/ISLENT)