# PVector

All of the sub-types of `Number` and `Quantity` are supported. In general it works as we expected whereas there are too many possibilities to foresee. Mathematically vector operations, linear algebra, array conversions, neighbor searching, etc. are well documented in coreesponding sections.

The vector types are unmutable out of performance reason. 

!!! note

    Coordinate components must be identical types:
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

## PVector and PVector2D

### Constructor

It is assumed that 3D vectors are used more often, so we choose `PVector` to represent 3D vectors and provide user-friendly functions to avoid errors in case you missed suffix `2D`:
```julia
julia> PVector(1.0, 2.0)
PVector2D{Float64}(1.0, 2.0)

julia> PVector(2.0, 3.0, u"m")
PVector2D{Quantity{Float64,𝐋,Unitful.FreeUnits{(m,),𝐋,nothing}}}(2.0 m, 3.0 m)
```

The default constructors of `PVector` are still 3d-version:
```julia
julia> PVector()
PVector{Float64}(0.0, 0.0, 0.0)

julia> PVector(u"m")
PVector{Quantity{Float64,𝐋,Unitful.FreeUnits{(m,),𝐋,nothing}}}(0.0 m, 0.0 m, 0.0 m)
```

### Basic Operators

Basic maths are well support by overriding `Base: +, -, *, /`, and array operations are supported by overriding `Base: length, iterate, to_index`

```julia
julia> a = npconvert(ones(3))
PVector{Float64}(1.0, 1.0, 1.0)

julia> b = npconvert(ones(3)) * 2
PVector{Float64}(2.0, 2.0, 2.0)

julia> a + b
PVector{Float64}(3.0, 3.0, 3.0)

julia> a * b
6.0

julia> norm(a)
1.7320508075688772

julia> norm(a) == sqrt(3)
true

julia> normalize(a)
PVector{Float64}(0.5773502691896258, 0.5773502691896258, 0.5773502691896258)

julia> normalize(a) == a / sqrt(3)
true

julia> cross(a, b)
PVector{Float64}(0.0, 0.0, 0.0)

julia> dot(a,b) == *(a,b)
true

julia> c = pconvert(ones(3)) * 1.0u"m"
PVector{Quantity{Float64,𝐋,Unitful.FreeUnits{(m,),𝐋,nothing}}}(1.0 m, 1.0 m, 1.0 m)

julia> c * a
3.0 m
```

### More types, more possibilities

`T<:Union{Number, Quantity}` gives us a whole world to try out new vector operations. As we mentioned above, the build-in type operation and promotion schemes have guaranteed most of operations would be correct:
```julia
julia> a = PVector(1.0, 1.0, 1.0) * im
PVector{Complex{Float64}}(0.0 + 1.0im, 0.0 + 1.0im, 0.0 + 1.0im)

julia> a * PVector(1, 2, 3)
0.0 + 6.0im

julia> norm(a)
0.0 + 1.7320508075688772im


julia> b = PVector(1.0f0, 2.0f0)
PVector2D{Float32}(1.0f0, 2.0f0)

julia> b * 2
PVector2D{Float32}(2.0f0, 4.0f0)

julia> b * 2.0
PVector2D{Float64}(2.0, 4.0)
```

!!! note

    We did not cover all combinations in auto-test, but fortunately everything worked well in daily usage! When it comes to `Quantity`, the computed `Units` may causes some issues, so we handled them in particular as documented in LinearAlgebra section.

### LinearAlgebra

`norm`, `normalize`, `dot`, `cross` from `LinearAlgebra` module are overloaded.

However, when it comes to `Quantity`, some wierd things would happen:
```julia
julia> sqrt(1.0u"km" * 1000.0u"m")
31.622776601683793 m^1/2 km^1/2

julia> sqrt(upreferred(1.0u"km" * 1000.0u"m"))
1000.0 m

julia> 1.0u"km" / sqrt(upreferred(1.0u"km" * 1.0u"km"))
0.001 km m^-1
```

To avoid this, we have to use `upreferred` in both `norm` and `normalize`:
```julia
@inline norm(p::PVector2D) = sqrt(upreferred(p * p))
@inline normalize(p::PVector2D) = (n = ustrip(norm(p)); return PVector2D(upreferred(p.x/n), upreferred(p.y/n)))

@inline norm(p::PVector) = sqrt(upreferred(p * p))
@inline normalize(p::PVector) = (n = ustrip(norm(p)); return PVector(upreferred(p.x/n), upreferred(p.y/n), upreferred(p.z/n)))
```