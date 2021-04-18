# Package Guide

PhysicalParticles.jl is useful for particle based scientific simulations

## Installation

From the Julia REPL, type `]` to enter the Pkg REPL mode and run
```julia
pkg> add PhysicalParticles
```
or add from git repository
```julia
pkg> add https://github.com/JuliaAstroSim/PhysicalParticles.jl
```

Test the package by
```julia
pkg> test PhysicalParticles
```

## Basic Usage

### Vectors

```@repl guide
using PhysicalParticles, UnitfulAstro
a = PVector()
b = PVector(1.0u"m", 2.0u"m", 3.0u"m")
c = PVector2D(u"m/s")
uconvert(u"m", PVector(1.0, 1.0, 1.0, u"km"))
PVector(1.0, 1.0) * im
b * 2.0u"s"
b + PVector(2.0, 2.0, 2.0, u"m") / 2
norm(PVector2D(3.0f0,4.0f0))
normalize(PVector(3.0, 4.0))
d = PVector(3u"kpc", 4u"kpc")
norm(d)
distance(PVector2D(0.0, 0.0), PVector2D(3.0, 4.0))
rotate(PVector(1.0, 0.0), 0.5pi)
rotate(PVector(1.0, 0.0, 0.0), 0.0, 0.0, 0.5pi)
rotate_z(PVector(1.0, 0.0, 0.0), 90.0u"°")
rotate(PVector(1.0, 0.0, 0.0), 0.0, 0.0, 90.0u"°", PVector(-1.0, 0.0, 0.0))
rotate(PVector(0.0, 1.0, 0.0), PVector(0.0, 1.0, 1.0), pi)
cylinderial(PVector(sqrt(2), sqrt(2), 1.0, u"m"))
cylinderial2xyz(2.0u"m", pi/4, 1.0u"m")
spherical(PVector(sqrt(0.5), sqrt(0.5), 1.0, u"m"))
spherical2xyz(sqrt(2)u"m", pi/4, pi/4)
zero(PVector{Float64})
iszero(PVector(u"m"))
isnan(PVector(NaN, NaN))
PVector2D(1.0, 1.0) ≈ PVector2D(1.0 + 1.0e-8, 1.0 + 1.0e-8)
ustrip(PVector(1.0, 1.0, 1.0, u"km"))
ustrip(u"m", PVector(1.0, 1.0, 1.0, u"km"))
```

### Particles

We provide 2D version for each type below, for example, the 2D version of `Ball` is `Ball2D`:
```@repl guide
Massless()
Massless(PVector(0.0, 0.0, 0.0), PVector(), 1)
Massless2D(uCGS)
Ball()
Ball(PVector(0.0u"m", 0.0u"m", 0.0u"m"), PVector(u"m/s"), PVector(u"m/s^2"), 0.0u"kg", 1)
Star()
SPHGas()
a = Star(uAstro)
b = SPHGas(uAstro)
distance(a,b)
```

#### Mutate array of immutable particles

To simulate particle dynamics on GPU (bit types), and for better performance, particle data are stored in immutable sturcts.
One of the shortcomings is that you have to allocate a new object when changing member data,
however, memory operation is optimized when doing this in array:

```@repl guide
using BangBang
p = Star()
p = setproperties!!(p, Mass = 321.0)

a = [Star()]
a[1] = setproperties!!(a[1], Mass = 321.0) # In general, `Mass` is mutated right at its original memory address.
```

### Random and Conversion

```@repl guide
p = rand_pvector(3)
pu = rand_pvector(3, u"m")
p_Ball = [Ball(uSI) for i=1:3]
assign_particles(p_Ball, :Pos, pu)
p_Ball
pconvert([1.0, 2.0, 3.0])
pconvert([1.0u"m" 4.0u"m";
          2.0u"m" 5.0u"m";
          3.0u"m" 6.0u"m"])
```

### Extent

```@repl guide
p = [Ball(PVector(-1.0u"m", 1.0u"m", 1.0u"m"), PVector(u"m/s"), PVector(u"m/s^2"), 1.0u"kg", 1),
     Ball(PVector(3.0u"m", -3.0u"m", -3.0u"m"), PVector(u"m/s"), PVector(u"m/s^2"), 3000.0u"g", 2)]
minimum_x(p)
maximum_x(p)
center(p)
pos_center(p)
mass_center(p)
median(p)
extent(p)
```