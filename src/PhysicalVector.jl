# PhysicalVector
#     Types and functions in this file are self-documented

## Physical Vector 2D

struct PhysicalVector2D{T<:AbstractQuantity} <: AbstractPoint2D{T}
    x::T
    y::T
end

abstractpoint(::Type{<:Quantity}, ::Type{<:Quantity}) = PhysicalVector2D{Quantity}

@inline +(a::PhysicalVector2D, b::PhysicalVector2D) = PhysicalVector2D(a.x + b.x, a.y + b.y)

@inline -(a::PhysicalVector2D, b::PhysicalVector2D) = PhysicalVector2D(a.x - b.x, a.y - b.y)

@inline *(a::PhysicalVector2D, b::PhysicalVector2D) = a.x * b.x + a.y * b.y
@inline *(p::PhysicalVector2D, h::Real) = PhysicalVector2D(p.x * h, p.y * h)
@inline *(h::Real, p::PhysicalVector2D) = PhysicalVector2D(p.x * h, p.y * h)

@inline /(p::PhysicalVector2D, h::Real) = PhysicalVector2D(p.x / h, p.y / h)

### Support Quantity multiplication and division
@inline *(p::PhysicalVector2D, h::Quantity) = PhysicalVector2D(p.x * h, p.y * h)
@inline *(h::Quantity, p::PhysicalVector2D) = PhysicalVector2D(p.x * h, p.y * h)

@inline /(p::PhysicalVector2D, h::Quantity) = PhysicalVector2D(p.x / h, p.y / h)

## Physical Vector 3D

struct PhysicalVector3D{T<:AbstractQuantity} <: AbstractPoint3D{T}
    x::T
    y::T
    z::T
end

abstractpoint(::Type{<:Quantity}, ::Type{<:Quantity}, ::Type{<:Quantity}) = PhysicalVector3D{Quantity}

## Generic PhysicalVector constructor

PhysicalVector(x::Quantity, y::Quantity) = PhysicalVector2D(x, y)
PhysicalVector(x::Quantity, y::Quantity, z::Quantity) = PhysicalVector3D(x, y, z)