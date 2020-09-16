# Extent

You can get `Extent` of an array of mathical vectors or particles by calling `extent` functions:
```@repl extent
using PhysicalParticles
p = [Ball(PVector(-1.0u"m", 1.0u"m", 1.0u"m"), PVector(u"m/s"), PVector(u"m/s^2"), 1.0u"kg", 1),
     Ball(PVector(1.0u"m", -1.0u"m", -1.0u"m"), PVector(u"m/s"), PVector(u"m/s^2"), 1000.0u"g", 2)]
extent(p)
```
or by comparing two `Extent`s and even array of `Extent`s:
```julia
# 5 methods for generic function "extent":
  [1] extent(a::Array{T,N}) where {N, T<:Union{AbstractParticle2D, PVector2D}}
  [2] extent(a::Array{T,N}) where {N, T<:Union{AbstractParticle3D, PVector}}
  [3] extent(a::Extent2D, b::Extent2D)
  [4] extent(a::Extent, b::Extent)
  [5] extent(a::Array{T,N} where N) where T<:AbstractExtent

```

For particles with masses, compute the mass center with:
```@repl extent
mass_center(p)
```

## Minimum, maximum and center

The computation of `Extent`s are based on a series of small functions, we use `p` defined in previous section to demonstrate:
```@repl extent
center(p)
```

We have implemented `max_x`, `max_y`, `max_z`, `min_x`, `min_y`, `min_z`, `center`, `center_x`, `center_y`, `center_z` for both points and particles. You could simply infer their functions by name.