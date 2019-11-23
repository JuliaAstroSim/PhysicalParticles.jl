# PhysicalVector
#     Types and functions in this file are self-documented

## Physical Vector 2D

struct PhysicalVector2D{T<:AbstractQuantity} <: AbstractPoint2D{T}
    x::T
    y::T
end

PhysicalVector(x::Quantity, y::Quantity) = PhysicalVector2D(x, y)
PhysicalVector(x::AbstractFloat, y::AbstractFloat) = Point2D(x, y)
PhysicalVector2D(x::AbstractFloat, y::AbstractFloat) = Point2D(x, y)

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

PhysicalVector(x::Quantity, y::Quantity, z::Quantity) = PhysicalVector3D(x, y, z)
PhysicalVector(x::AbstractFloat, y::AbstractFloat, z::AbstractFloat) = Point3D(x, y, z)
PhysicalVector3D(x::AbstractFloat, y::AbstractFloat, z::AbstractFloat) = Point3D(x, y, z)

abstractpoint(::Type{<:Quantity}, ::Type{<:Quantity}, ::Type{<:Quantity}) = PhysicalVector3D{Quantity}

@inline +(a::PhysicalVector3D, b::PhysicalVector3D) = PhysicalVector3D(a.x + b.x, a.y + b.y, a.z + b.z)

@inline -(a::PhysicalVector3D, b::PhysicalVector3D) = PhysicalVector3D(a.x - b.x, a.y - b.y, a.z - b.z)

@inline *(a::PhysicalVector3D, b::PhysicalVector3D) = a.x * b.x + a.y * b.y + a.z * b.z
@inline *(p::PhysicalVector3D, h::Real) = PhysicalVector3D(p.x * h, p.y * h, p.z * h)
@inline *(h::Real, p::PhysicalVector3D) = PhysicalVector3D(p.x * h, p.y * h, p.z * h)

@inline /(p::PhysicalVector3D, h::Real) = PhysicalVector3D(p.x / h, p.y / h, p.z / h)

### Support Quantity multiplication and division
@inline *(p::PhysicalVector3D, h::Quantity) = PhysicalVector3D(p.x * h, p.y * h, p.z * h)
@inline *(h::Quantity, p::PhysicalVector3D) = PhysicalVector3D(p.x * h, p.y * h, p.z * h)

@inline /(p::PhysicalVector3D, h::Quantity) = PhysicalVector3D(p.x / h, p.y / h, p.z / h)