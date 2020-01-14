# Extent

## Type Hierarchy

```julia
abstract type AbstractExtent{T} end
abstract type AbstractExtent2D{T} <: AbstractExtent{T} end
abstract type AbstractExtent3D{T} <: AbstractExtent{T} end

mutable struct Extent2D{T<:Union{Number, Quantity}} <: AbstractExtent2D{T}
    xMin::T
    xMax::T
    yMin::T
    yMax::T
    SideLength::T
    Center::PVector2D{T}
    Corner::PVector2D{T}
end

mutable struct Extent{T<:Union{Number, Quantity}} <: AbstractExtent3D{T}
    xMin::T
    xMax::T
    yMin::T
    yMax::T
    zMin::T
    zMax::T
    SideLength::T
    Center::PVector{T}
    Corner::PVector{T}
end
```

## Usage

You can get `Extent` of an array of mathical vectors or particles by calling `extent` functions:
```julia
julia> p = [Ball(PVector(-1.0u"m", 1.0u"m", 1.0u"m"), PVector(u"m/s"), PVector(u"m/s^2"), 1.0u"kg", 1),
            Ball(PVector(1.0u"m", -1.0u"m", -1.0u"m"), PVector(u"m/s"), PVector(u"m/s^2"), 1000.0u"g", 2)]
julia> extent(p)
Extent: , xMin = -1.0 m, xMax = 1.0 m, yMin = -1.0 m, yMax = 1.0 m, zMin = -1.0 m, zMax = 1.0 m, SideLength = 2.0 m, Center = PVector(0.0 m, 0.0 m, 0.0 m), Corner = PVector(-1.0 m, -1.0 m, -1.0 m)
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
```julia
julia> mass_center(p)
PVector(0.0 m, 0.0 m, 0.0 m)
```

## Minimum, maximum and center

The computation of `Extent`s are based on a series of small functions, we use `p` defined in previous section to demonstrate:
```julia
julia> min_x(p)
-1.0 m

julia> max_z(p)
1.0 m

julia> center(p)
PVector(0.0 m, 0.0 m, 0.0 m)
```

We have implemented `max_x`, `max_y`, `max_z`, `min_x`, `min_y`, `min_z`, `center`, `center_x`, `center_y`, `center_z` for both points and particles. You could simply infer their functions by name.