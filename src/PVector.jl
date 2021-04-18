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



# Interact with Number and Quantity

@inline *(p::PVector2D{T}, h::Number) where T<:Number = PVector2D(p.x * h, p.y * h)
@inline *(h::Number, p::PVector2D{T}) where T<:Number = PVector2D(p.x * h, p.y * h)

@inline /(p::PVector2D{T}, h::Number) where T<:Number = PVector2D(p.x / h, p.y / h)

@inline *(p::PVector{T}, h::Number) where T<:Number = PVector(p.x * h, p.y * h, p.z * h)
@inline *(h::Number, p::PVector{T}) where T<:Number = PVector(p.x * h, p.y * h, p.z * h)

@inline /(p::PVector{T}, h::Number) where T<:Number = PVector(p.x / h, p.y / h, p.z / h)


# Generic functions

PVector2D() = PVector2D(0.0, 0.0)

PVector2D(::Nothing) = PVector2D(0.0, 0.0)

PVector2D(u::Units) = PVector2D(0.0 * u, 0.0 * u)

PVector2D(x::Number, y::Number, u::Units) = PVector2D(x * u, y * u)

PVector2D(x::Number, y::Number, ::Nothing) = PVector2D(x, y)


PVector() = PVector(0.0, 0.0, 0.0)

PVector(::Nothing) = PVector(0.0, 0.0, 0.0)

PVector(u::Units) = PVector(0.0 * u, 0.0 * u, 0.0 * u)

PVector(x::Number, y::Number, z::Number, u::Units) = PVector(x * u, y * u, z * u)

PVector(x::Number, y::Number, z::Number, ::Nothing) = PVector(x, y, z)


PVector(x::T, y::T) where T<:Number = PVector2D(x, y)

PVector(x::Number, y::Number, u::Units) = PVector2D(x * u, y * u)

PVector(x::Number, y::Number, ::Nothing) = PVector2D(x, y)


# Units

uconvert(u::Units, p::PVector2D) = PVector2D(uconvert(u, p.x), uconvert(u, p.y))
uconvert(u::Units, p::PVector) = PVector(uconvert(u, p.x), uconvert(u, p.y), uconvert(u, p.z))

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



# Coordinate Transformations
"""
    cylinderial2xyz(r::Number, θ::Number)

Convert Cylinderial Coordinates to `PVector2D`
"""
cylinderial2xyz(r::Number, θ::Number) = PVector2D(r * cos(θ), r * sin(θ))

"""
    cylinderial2xyz(r::Number, θ::Number, z::Number)

Convert Cylinderial Coordinates to `PVector`
"""
cylinderial2xyz(r::Number, θ::Number, z::Number) = PVector(r * cos(θ), r * sin(θ), z)

"""
    spherical2xyz(r::Number, θ::Number, ϕ::Number)

Convert Spherical Coordinates to `PVector`
"""
spherical2xyz(r::Number, θ::Number, ϕ::Number) = PVector(r * sin(θ) * cos(ϕ), r * sin(θ) * sin(ϕ), r * cos(θ))

"""
cylinderial(p::PVector2D)

Convert `PVector2D` to Cylinderial Coordinates. Returns Tuple(r, θ)
"""
function cylinderial(p::PVector2D)
    r = norm(p)
    if iszero(r)
        return (r, 0.0)
    elseif ustrip(p.x) >= 0
        theta = asin(p.y / r)
    elseif ustrip(p.x) < 0
        theta = -asin(p.y / r) + pi
    end
    return (r, theta)
end

"""
    cylinderial(p::PVector)

Convert `PVector` to Cylinderial Coordinates. Returns Tuple(r, θ, z)
"""
function cylinderial(p::PVector)
    r = sqrt(p.x^2 + p.y^2)
    if iszero(r)
        return (r, 0.0, p.z)
    elseif ustrip(p.x) >= 0
        theta = asin(p.y / r)
    elseif ustrip(p.x) < 0
        theta = -asin(p.y / r) + pi
    end
    return (r, theta, p.z)
end

"""
    spherical(p::PVector)

Convert `PVector` to Spherical Coordinates. Returns Tuple(r, θ, ϕ)
"""
function spherical(p::PVector)
    r = norm(p)
    θ = acos(p.z / r)
    ϕ = atan(p.y / p.x)
    return r, θ, ϕ
end