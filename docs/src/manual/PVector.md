# PVector

All of the sub-types of `Number` and `Quantity` are supported. In general it works as we expected whereas there are too many possibilities to foresee. Mathematically vector operations, linear algebra, array conversions, neighbor searching, etc. are well documented in coreesponding sections.

The vector types are unmutable out of performance reason, and the coordinate members must be identical types:
```julia
julia> PVector2D(1.0, 1.0f0)
ERROR: MethodError: no method matching PVector2D(::Float64, ::Float32)
Closest candidates are:
  PVector2D(::Number, ::Number, ::Unitful.Units) at C:\Users\islent\.julia\packages\PhysicalParticles\oFZmG\src\PVector.jl:45
  PVector2D(::T, ::T) where T<:Number at C:\Users\islent\.julia\packages\PhysicalParticles\oFZmG\src\PVector.jl:2
Stacktrace:
 [1] top-level scope at REPL[27]:1

julia> PVector2D(1.0u"m", 1.0u"km")
ERROR: MethodError: no method matching PVector2D(::Quantity{Float64,𝐋,Unitful.FreeUnits{(m,),𝐋,nothing}}, ::Quantity{Float64,𝐋,Unitful.FreeUnits{(km,),𝐋,nothing}})
Closest candidates are:
  PVector2D(::Number, ::Number, ::Unitful.Units) at C:\Users\islent\.julia\packages\PhysicalParticles\oFZmG\src\PVector.jl:45
  PVector2D(::T, ::T) where T<:Number at C:\Users\islent\.julia\packages\PhysicalParticles\oFZmG\src\PVector.jl:2
Stacktrace:
 [1] top-level scope at REPL[28]:1
```

## Type Hierarchy

```julia
abstract type AbstractPoint{T} end
abstract type AbstractPoint2D{T} <: AbstractPoint{T} end
abstract type AbstractPoint3D{T} <: AbstractPoint{T} end

struct PVector2D{T<:Union{Number, Quantity}} <: AbstractPoint2D{T}
    x::T
    y::T
end

struct PVector{T<:Union{Number, Quantity}} <: AbstractPoint3D{T}
    x::T
    y::T
    z::T
end
```