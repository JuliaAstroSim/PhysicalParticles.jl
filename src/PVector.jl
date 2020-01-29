struct PVector2D{T<:Number} <: AbstractPoint2D{T}
    x::T
    y::T
end

@inline +(a::PVector2D, b::PVector2D) = PVector2D(a.x + b.x, a.y + b.y)

@inline -(a::PVector2D, b::PVector2D) = PVector2D(a.x - b.x, a.y - b.y)

@inline *(a::PVector2D, b::PVector2D) = a.x * b.x + a.y * b.y

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

PVector2D(u::Units) = PVector2D(0.0 * u, 0.0 * u)

PVector2D(x::Number, y::Number, u::Units) = PVector2D(x * u, y * u)



PVector() = PVector(0.0, 0.0, 0.0)

PVector(u::Units) = PVector(0.0 * u, 0.0 * u, 0.0 * u)

PVector(x::Number, y::Number, z::Number, u::Units) = PVector(x * u, y * u, z * u)



PVector(x::T, y::T) where T<:Number = PVector2D(x, y)

PVector(x::Number, y::Number, u::Units) = PVector2D(x * u, y * u)

uconvert(u::Units, p::PVector2D) = PVector(uconvert(u, p.x), uconvert(u, p.y))
uconvert(u::Units, p::PVector) = PVector(uconvert(u, p.x), uconvert(u, p.y), uconvert(u, p.z))