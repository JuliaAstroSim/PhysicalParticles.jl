# PhysicalParticles.jl

![](https://github.com/JuliaAstroSim/PhysicalParticles.jl/workflows/.github/workflows/CI.yml/badge.svg)
![](https://github.com/JuliaAstroSim/PhysicalParticles.jl/workflows/.github/workflows/doc.yml/badge.svg)
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
PVector{Quantity{Float64,𝐋,Unitful.FreeUnits{(m,),𝐋,nothing}}}(1.0 m, 2.0 m, 3.0 m)

julia> c = PVector2D(u"m/s")
PVector2D{Quantity{Float64,𝐋*𝐓^-1,Unitful.FreeUnits{(m, s^-1),𝐋*𝐓^-1,nothing}}}(0.0 m s^-1, 0.0 m s^-1)



julia> PVector(1.0, 1.0) * im
PVector2D{Complex{Float64}}(0.0 + 1.0im, 0.0 + 1.0im)

julia> b * 2.0u"s"
PVector{Quantity{Float64,𝐋*𝐓,Unitful.FreeUnits{(m, s),𝐋*𝐓,nothing}}}(2.0 m s, 4.0 m s, 6.0 m s)

julia> b + PVector(2.0, 2.0, 2.0, u"m") / 2
PVector{Quantity{Float64,𝐋,Unitful.FreeUnits{(m,),𝐋,nothing}}}(2.0 m, 3.0 m, 4.0 m)

julia> norm(PVector2D(3.0f0,4.0f0))
5.0f0

julia> normalize(PVector(3.0, 4.0))
PVector2D{Float64}(0.6, 0.8)

julia> d = PVector(3u"kpc", 4u"kpc")
PVector2D{Quantity{Int64,𝐋,Unitful.FreeUnits{(kpc,),𝐋,nothing}}}(3 kpc, 4 kpc)

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
julia> Massless(PVector(0.0, 0.0, 0.0), PVector(), 1)
Massless{Float64,Int64}(PVector{Float64}(0.0, 0.0, 0.0), PVector{Float64}(0.0, 0.0, 0.0), 1)

julia> Ball(PVector(0.0u"m", 0.0u"m", 0.0u"m"), PVector(u"m"), 0.0u"kg", 1)
Ball{Int64}(PVector{Quantity{Float64,𝐋,Unitful.FreeUnits{(m,),𝐋,nothing}}}(0.0 m, 0.0 m, 0.0 m), PVector{Quantity{Float64,𝐋,Unitful.FreeUnits{(m,),𝐋,nothing}}}(0.0 m, 0.0 m, 0.0 m), 0.0 kg, 1)

julia> a = Star()
Star{Float64,Int64}(PVector{Quantity{Float64,𝐋,Unitful.FreeUnits{(kpc,),𝐋,nothing}}}(0.0 kpc, 0.0 kpc, 0.0 kpc), PVector{Quantity{Float64,𝐋*𝐓^-1,Unitful.FreeUnits{(Gyr^-1, kpc),𝐋*𝐓^-1,nothing}}}(0.0 kpc Gyr^-1, 0.0 kpc Gyr^-1, 0.0 kpc Gyr^-1), PVector{Quantity{Float64,𝐋*𝐓^-2,Unitful.FreeUnits{(Gyr^-2, kpc),𝐋*𝐓^-2,nothing}}}(0.0 kpc Gyr^-2, 0.0 kpc Gyr^-2, 0.0 kpc Gyr^-2), 0.0 M⊙, 0, 0, 0, 0.0, 0.0 J, 0.0 kpc Gyr^-2)

julia> b = SPHGas()
SPHGas{Float64,Int64}(PVector{Quantity{Float64,𝐋,Unitful.FreeUnits{(kpc,),𝐋,nothing}}}(0.0 kpc, 0.0 kpc, 0.0 kpc), PVector{Quantity{Float64,𝐋*𝐓^-1,Unitful.FreeUnits{(Gyr^-1, kpc),𝐋*𝐓^-1,nothing}}}(0.0 kpc Gyr^-1, 0.0 kpc Gyr^-1, 0.0 kpc Gyr^-1), PVector{Quantity{Float64,𝐋*𝐓^-2,Unitful.FreeUnits{(Gyr^-2, kpc),𝐋*𝐓^-2,nothing}}}(0.0 kpc Gyr^-2, 0.0 kpc Gyr^-2, 0.0 kpc Gyr^-2), 0.0 M⊙, 0, 0, 0, 0.0, 0.0 J, 0.0 kpc Gyr^-2, 0.0 J K^-1, 0.0 M⊙ kpc^-3, 0.0 kpc, 0.0, 0.0, 0, PVector{Quantity{Float64,𝐋*𝐓^-1,Unitful.FreeUnits{(Gyr^-1, kpc),𝐋*𝐓^-1,nothing}}}(0.0 kpc Gyr^-1, 0.0 kpc Gyr^-1, 0.0 kpc Gyr^-1), 0.0 Gyr^-1, 0.0 Gyr^-1, 0.0, 0.0 N m^-1, 0.0 J K^-1 s^-1, 0.0 kpc Gyr^-1)

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
 PVector{Quantity{Float64,𝐋,Unitful.FreeUnits{(m,),𝐋,nothing}}}(0.6477898102542425 m, 0.4373299903072585 m, 0.7049677138795583 m)
 PVector{Quantity{Float64,𝐋,Unitful.FreeUnits{(m,),𝐋,nothing}}}(0.8651944634833202 m, 0.5480460857713867 m, 0.5620548650425954 m)
 PVector{Quantity{Float64,𝐋,Unitful.FreeUnits{(m,),𝐋,nothing}}}(0.28164175368241895 m, 0.1673360850328498 m, 0.31321825771349987 m)

julia> p_Ball = [Ball() for i=1:3]
3-element Array{Ball{Int64},1}:
 Ball{Int64}(PVector{Quantity{Float64,𝐋,Unitful.FreeUnits{(m,),𝐋,nothing}}}(0.0 m, 0.0 m, 0.0 m), PVector{Quantity{Float64,𝐋*𝐓^-1,Unitful.FreeUnits{(m, s^-1),𝐋*𝐓^-1,nothing}}}(0.0 m s^-1, 0.0 m s^-1, 0.0 m s^-1), 0.0 kg, 0)
 Ball{Int64}(PVector{Quantity{Float64,𝐋,Unitful.FreeUnits{(m,),𝐋,nothing}}}(0.0 m, 0.0 m, 0.0 m), PVector{Quantity{Float64,𝐋*𝐓^-1,Unitful.FreeUnits{(m, s^-1),𝐋*𝐓^-1,nothing}}}(0.0 m s^-1, 0.0 m s^-1, 0.0 m s^-1), 0.0 kg, 0)
 Ball{Int64}(PVector{Quantity{Float64,𝐋,Unitful.FreeUnits{(m,),𝐋,nothing}}}(0.0 m, 0.0 m, 0.0 m), PVector{Quantity{Float64,𝐋*𝐓^-1,Unitful.FreeUnits{(m, s^-1),𝐋*𝐓^-1,nothing}}}(0.0 m s^-1, 0.0 m s^-1, 0.0 m s^-1), 0.0 kg, 0)

julia> assign_points(p_Ball, :Pos, pu)

julia> p_Ball
3-element Array{Ball{Int64},1}:
 Ball{Int64}(PVector{Quantity{Float64,𝐋,Unitful.FreeUnits{(m,),𝐋,nothing}}}(0.6477898102542425 m, 0.4373299903072585 m, 0.7049677138795583 m), PVector{Quantity{Float64,𝐋*𝐓^-1,Unitful.FreeUnits{(m, s^-1),𝐋*𝐓^-1,nothing}}}(0.0 m s^-1, 0.0 m s^-1, 0.0 m s^-1), 0.0 kg, 0)
 Ball{Int64}(PVector{Quantity{Float64,𝐋,Unitful.FreeUnits{(m,),𝐋,nothing}}}(0.8651944634833202 m, 0.5480460857713867 m, 0.5620548650425954 m), PVector{Quantity{Float64,𝐋*𝐓^-1,Unitful.FreeUnits{(m, s^-1),𝐋*𝐓^-1,nothing}}}(0.0 m s^-1, 0.0 m s^-1, 0.0 m s^-1), 0.0 kg, 0)
 Ball{Int64}(PVector{Quantity{Float64,𝐋,Unitful.FreeUnits{(m,),𝐋,nothing}}}(0.28164175368241895 m, 0.1673360850328498 m, 0.31321825771349987 m), PVector{Quantity{Float64,𝐋*𝐓^-1,Unitful.FreeUnits{(m, s^-1),𝐋*𝐓^-1,nothing}}}(0.0 m s^-1, 0.0 m s^-1, 0.0 m s^-1), 0.0 kg, 0)


julia> npconvert([1.0, 2.0, 3.0])
PVector{Float64}(1.0, 2.0, 3.0)

julia> npconvert([1.0u"m" 4.0u"m";
                  2.0u"m" 5.0u"m";
                  3.0u"m" 6.0u"m"])
2-element Array{PVector,1}:
 PVector{Quantity{Float64,𝐋,Unitful.FreeUnits{(m,),𝐋,nothing}}}(1.0 m, 2.0 m, 3.0 m)
 PVector{Quantity{Float64,𝐋,Unitful.FreeUnits{(m,),𝐋,nothing}}}(4.0 m, 5.0 m, 6.0 m)
```

### Extent

```julia
julia> p = [Ball(PVector(-1.0u"m", 1.0u"m", 1.0u"m"), PVector(u"m"), 1.0u"kg", 1),
            Ball(PVector(1.0u"m", -1.0u"m", -1.0u"m"), PVector(u"m"), 1000.0u"g", 2)]
2-element Array{Ball{Int64},1}:
 Ball{Int64}(PVector{Quantity{Float64,𝐋,Unitful.FreeUnits{(m,),𝐋,nothing}}}(-1.0 m, 1.0 m, 1.0 m), PVector{Quantity{Float64,𝐋,Unitful.FreeUnits{(m,),𝐋,nothing}}}(0.0 m, 0.0 m, 0.0 m), 1.0 kg, 1)
 Ball{Int64}(PVector{Quantity{Float64,𝐋,Unitful.FreeUnits{(m,),𝐋,nothing}}}(1.0 m, -1.0 m, -1.0 m), PVector{Quantity{Float64,𝐋,Unitful.FreeUnits{(m,),𝐋,nothing}}}(0.0 m, 0.0 m, 0.0 m), 1000.0 g, 2)

julia> min_x(p)
-1.0 m

julia> max_z(p)
1.0 m

julia> center(p)
PVector{Quantity{Float64,𝐋,Unitful.FreeUnits{(m,),𝐋,nothing}}}(0.0 m, 0.0 m, 0.0 m)

julia> mass_center(p)
PVector{Quantity{Float64,𝐋,Unitful.FreeUnits{(m,),𝐋,nothing}}}(0.0 m, 0.0 m, 0.0 m)

julia> extent(p)
Extent{Quantity{Float64,𝐋,Unitful.FreeUnits{(m,),𝐋,nothing}}}(-1.0 m, 1.0 m, -1.0 m, 1.0 m, -1.0 m, 1.0 m, 2.0 m, PVector{Quantity{Float64,𝐋,Unitful.FreeUnits{(m,),𝐋,nothing}}}(0.0 m, 0.0 m, 0.0 m), PVector{Quantity{Float64,𝐋,Unitful.FreeUnits{(m,),𝐋,nothing}}}(-1.0 m, -1.0 m, -1.0 m))
```

## References

- [GeometicalPredicates.jl](https://github.com/JuliaGeometry/GeometricalPredicates.jl)