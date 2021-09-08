"""
    Enum Collection

Particle types defined in Gadget2. However, in julia, it is better to start from 1:

```jl
GAS::Collection       = 1
HALO::Collection      = 2
DISK::Collection      = 3
BULGE::Collection     = 4
STAR::Collection      = 5
BLACKHOLE::Collection = 6
```
"""
@enum Collection begin
    GAS       = 1
    HALO      = 2
    DISK      = 3
    BULGE     = 4
    STAR      = 5
    BLACKHOLE = 6
end

"""
abstract type AbstractDataDimension

Abstract type for traits. see [`datadimension`](@ref) for more info.

## Subtypes
```jl
Physical2D
Physical3D
Unitless2D
Unitless3D
```
"""
abstract type AbstractDataDimension end
struct Physical2D <: AbstractDataDimension end
struct Physical3D <: AbstractDataDimension end
struct Unitless2D <: AbstractDataDimension end
struct Unitless3D <: AbstractDataDimension end

"""
    function datadimension

Traits function to specify whether the data is unitful/unitless and 2D/3D.

## Examples

```jl
julia> datadimension(PVector2D())
Unitless2D()

julia> datadimension(PVector())
Unitless3D()

julia> datadimension(Star2D(uAstro))
Physical2D()

julia> datadimension(Star(uAstro))
Physical3D()

julia> datadimension([PVector2D()])
Unitless2D()

julia> datadimension([PVector()])
Unitless3D()

julia> datadimension([Star2D(uAstro)])
Physical2D()

julia> datadimension([Star(uAstro)])
Physical3D()
```
"""
datadimension(p::AbstractParticle) = datadimension(p.Pos, p.Pos.x)
datadimension(p::AbstractPoint) = datadimension(p, p.x)

datadimension(::AbstractPoint2D, ::Number) = Unitless2D()
datadimension(::AbstractPoint3D, ::Number) = Unitless3D()
datadimension(::AbstractPoint2D, ::Quantity) = Physical2D()
datadimension(::AbstractPoint3D, ::Quantity) = Physical3D()

datadimension(a::Array) = datadimension(first(a))