"""
    struct PVector2D{T<:Number} <: AbstractPoint2D{T}

## Fields
- x::T
- y::T

## Examples

```jl
julia> PVector2D()
PVector2D{Float64}(0.0, 0.0)

julia> PVector2D(u"m")
PVector2D(0.0 m, 0.0 m)

julia> PVector(1.0im, 2.0 + 3.0im)
PVector2D{ComplexF64}(0.0 + 1.0im, 2.0 + 3.0im)
```
"""
struct PVector2D{T<:Number} <: AbstractPoint2D{T}
    x::T
    y::T
end

@inline +(a::PVector2D, b::PVector2D) = PVector2D(a.x + b.x, a.y + b.y)

@inline -(a::PVector2D, b::PVector2D) = PVector2D(a.x - b.x, a.y - b.y)

@inline *(a::PVector2D, b::PVector2D) = a.x * b.x + a.y * b.y

@inline -(p::PVector2D) = PVector2D(-p.x, -p.y)

"""
    struct PVector{T<:Number} <: AbstractPoint3D{T}

## Fields
- x::T
- y::T
- z::T

## Examples

```jl
julia> PVector()
PVector{Float64}(0.0, 0.0, 0.0)

julia> PVector(u"m")
PVector(0.0 m, 0.0 m, 0.0 m)

julia> PVector() * im
PVector{ComplexF64}(0.0 + 0.0im, 0.0 + 0.0im, 0.0 + 0.0im)
```
"""
struct PVector{T<:Number} <: AbstractPoint3D{T}
    x::T
    y::T
    z::T
end

@inline +(a::PVector, b::PVector) = PVector(a.x + b.x, a.y + b.y, a.z + b.z)

@inline -(a::PVector, b::PVector) = PVector(a.x - b.x, a.y - b.y, a.z - b.z)

@inline *(a::PVector, b::PVector) = a.x * b.x + a.y * b.y + a.z * b.z

@inline -(p::PVector) = PVector(-p.x, -p.y, -p.z)


# Interact with Number and Quantity

@inline *(p::PVector2D{T}, h::Number) where T<:Number = PVector2D(p.x * h, p.y * h)
@inline *(h::Number, p::PVector2D{T}) where T<:Number = PVector2D(p.x * h, p.y * h)

@inline *(p::PVector2D{T}, u::Units) where T<:Number = PVector2D(p.x * u, p.y * u)
@inline *(u::Units, p::PVector2D{T}) where T<:Number = PVector2D(p.x * u, p.y * u)

@inline /(p::PVector2D{T}, h::Number) where T<:Number = PVector2D(p.x / h, p.y / h)

@inline *(p::PVector{T}, h::Number) where T<:Number = PVector(p.x * h, p.y * h, p.z * h)
@inline *(h::Number, p::PVector{T}) where T<:Number = PVector(p.x * h, p.y * h, p.z * h)

@inline *(p::PVector{T}, u::Units) where T<:Number = PVector(p.x * u, p.y * u, p.z * u)
@inline *(u::Units, p::PVector{T}) where T<:Number = PVector(p.x * u, p.y * u, p.z * u)

@inline /(p::PVector{T}, h::Number) where T<:Number = PVector(p.x / h, p.y / h, p.z / h)


# Generic functions

PVector2D() = PVector2D(0.0, 0.0)

PVector2D(::Nothing) = PVector2D(0.0, 0.0)

PVector2D(u::Units) = PVector2D(0.0 * u, 0.0 * u)

PVector2D(x::Number, y::Number, u::Units) = PVector2D(x * u, y * u)

PVector2D(x::Number, y::Number, ::Nothing) = PVector2D(x, y)

PVector2D(::Type{T}) where T<:Number = PVector2D(zero(T), zero(T))

PVector2D(::Type{T}, u::Units) where T<:Number = PVector2D(zero(T)*u, zero(T)*u)


PVector() = PVector(0.0, 0.0, 0.0)

PVector(::Nothing) = PVector(0.0, 0.0, 0.0)

PVector(u::Units) = PVector(0.0 * u, 0.0 * u, 0.0 * u)

PVector(x::Number, y::Number, z::Number, u::Units) = PVector(x * u, y * u, z * u)

PVector(x::Number, y::Number, z::Number, ::Nothing) = PVector(x, y, z)


PVector(x::T, y::T) where T<:Number = PVector2D(x, y)

PVector(x::Number, y::Number, u::Units) = PVector2D(x * u, y * u)

PVector(x::Number, y::Number, ::Nothing) = PVector2D(x, y)

PVector(::Type{T}) where T<:Number = PVector(zero(T), zero(T), zero(T))

PVector(::Type{T}, u::Units) where T<:Number = PVector(zero(T)*u, zero(T)*u, zero(T)*u)

# numeric type conversion
convert(::Type{PVector2D{T}}, p::PVector2D{U}) where {T,U} = PVector2D{T}(T(p.x), T(p.y))
convert(::Type{PVector{T}}, p::PVector{U}) where {T,U} = PVector{T}(T(p.x), T(p.y), T(p.z))
convert(::Type{T}, p::PVector2D{U}) where {T<:Real,U} = PVector2D(T(p.x), T(p.y))
convert(::Type{T}, p::PVector{U}) where {T<:Real,U} = PVector(T(p.x), T(p.y), T(p.z))

# 1D point, simply return the number
PVector(x::Number) = x
PVector(x::Number, ::Nothing) = x
PVector(x::Number, u::Units) = x * u


# Tuple
PVector2D(t::Tuple{T,T}) where T = PVector2D(t...)
PVector(t::Tuple{T,T}) where T = PVector2D(t...)

PVector(t::Tuple{T,T,T}) where T = PVector(t...)

# Convert to Array
Vector(p::AbstractPoint3D) = [p.x, p.y, p.z]
Vector(p::AbstractPoint2D) = [p.x, p.y]
Array(p::AbstractPoint) = Vector(p)

# Convert to SArray
SVector(p::AbstractPoint3D) = SVector(p.x, p.y, p.z)
SVector(p::AbstractPoint2D) = SVector(p.x, p.y)
SArray(p::AbstractPoint) = SVector(p)

# Convert to MArray
MVector(p::AbstractPoint3D) = MVector(p.x, p.y, p.z)
MVector(p::AbstractPoint2D) = MVector(p.x, p.y)
MArray(p::AbstractPoint) = MVector(p)

# Units

uconvert(u::Units, p::PVector2D) = PVector2D(uconvert(u, p.x), uconvert(u, p.y))
uconvert(u::Units, p::PVector) = PVector(uconvert(u, p.x), uconvert(u, p.y), uconvert(u, p.z))
uconvert(::Nothing, p::PVector2D{T}) where T<:Real = p
uconvert(::Nothing, p::PVector{T}) where T<:Real = p

ustrip(::Nothing, p::PVector2D) = p
ustrip(::Nothing, p::PVector) = p
ustrip(u::Units, p::PVector2D) = PVector2D(ustrip(u, p.x), ustrip(u, p.y))
ustrip(u::Units, p::PVector) = PVector(ustrip(u, p.x), ustrip(u, p.y), ustrip(u, p.z))
ustrip(p::PVector2D) = PVector2D(ustrip(p.x), ustrip(p.y))
ustrip(p::PVector) = PVector(ustrip(p.x), ustrip(p.y), ustrip(p.z))

one(u::Units, p::PVector2D) = PVector2D(one(p.x) * u, one(p.y) * u)
one(u::Units, p::PVector) = PVector(one(p.x) * u, one(p.y) * u, one(p.z) * u)
one(p::PVector2D) = PVector2D(one(p.x), one(p.y))
one(p::PVector) = PVector(one(p.x), one(p.y), one(p.z))

oneunit(p::PVector2D) = PVector2D(oneunit(p.x), oneunit(p.y))
oneunit(p::PVector) = PVector(oneunit(p.x), oneunit(p.y), oneunit(p.z))

zero(u::Units, p::PVector2D) = PVector2D(uconvert(u, zero(p.x)), uconvert(u, zero(p.y)))
zero(u::Units, p::PVector) = PVector(uconvert(u, zero(p.x)), uconvert(u, zero(p.y)), uconvert(u, zero(p.z)))
zero(p::PVector2D) = PVector2D(zero(p.x), zero(p.y))
zero(p::PVector) = PVector(zero(p.x), zero(p.y), zero(p.z))

zero(::Type{PVector{T}}) where T = PVector(zero(T), zero(T), zero(T))
zero(::Type{PVector2D{T}}) where T = PVector2D(zero(T), zero(T))
zero(::Type{PVector}) = zero(PVector{Float64})
zero(::Type{PVector2D}) = zero(PVector2D{Float64})

isone(p::AbstractPoint2D) = isone(p.x) && isone(p.y)
isone(p::AbstractPoint3D) = isone(p.x) && isone(p.y) && isone(p.z)

iszero(p::AbstractPoint2D) = iszero(p.x) && iszero(p.y)
iszero(p::AbstractPoint3D) = iszero(p.x) && iszero(p.y) && iszero(p.z)

isnan(p::AbstractPoint2D) = isnan(p.x) && isnan(p.y)
isnan(p::AbstractPoint3D) = isnan(p.x) && isnan(p.y) && isnan(p.z)

hasnan(p::AbstractPoint2D) = isnan(p.x) || isnan(p.y)
hasnan(p::AbstractPoint3D) = isnan(p.x) || isnan(p.y) || isnan(p.z)

isinf(p::AbstractPoint2D) = isinf(p.x) && isinf(p.y)
isinf(p::AbstractPoint3D) = isinf(p.x) && isinf(p.y) && isinf(p.z)

hasinf(p::AbstractPoint2D) = isinf(p.x) || isinf(p.y)
hasinf(p::AbstractPoint3D) = isinf(p.x) || isinf(p.y) || isinf(p.z)

isapprox(a::AbstractPoint2D, b::AbstractPoint2D) = isapprox(a.x, b.x) && isapprox(a.y, b.y)
isapprox(a::AbstractPoint3D, b::AbstractPoint3D) = isapprox(a.x, b.x) && isapprox(a.y, b.y) && isapprox(a.z, b.z)

numeric_type(::AbstractPoint{Quantity{T,D,U}}) where T where D where U = T
numeric_type(::AbstractPoint{T}) where T = T

# Here we have to use concrete PVector type. Is there a better solution?
numeric_type(::AbstractArray{PVector{Quantity{T,D,U}}, N}) where T where D where U where N = T
numeric_type(::AbstractArray{PVector2D{Quantity{T,D,U}}, N}) where T where D where U where N = T
numeric_type(::AbstractArray{PVector{T}, N}) where T where N = T
numeric_type(::AbstractArray{PVector2D{T}, N}) where T where N = T

# Measurements
measurement(q::Quantity) = measurement(q, zero(q))

measurement(p::PVector2D) = PVector2D(measurement(p.x), measurement(p.y))
measurement(p::PVector) = PVector(measurement(p.x), measurement(p.y), measurement(p.z))

measurement(p::PVector2D, e::PVector2D) = PVector2D(measurement(p.x, e.x), measurement(p.y, e.y))
measurement(p::PVector, e::PVector) = PVector(measurement(p.x, e.x), measurement(p.y, e.y), measurement(p.z, e.z))

function ismeasurement(x)
    if x isa Unitful.Quantity
        return x.val isa Measurement
    end

    return x isa Measurement
end

ismeasurement(p::AbstractPoint2D) = ismeasurement(p.x) && ismeasurement(p.y)
ismeasurement(p::AbstractPoint3D) = ismeasurement(p.x) && ismeasurement(p.y) && ismeasurement(p.z)
