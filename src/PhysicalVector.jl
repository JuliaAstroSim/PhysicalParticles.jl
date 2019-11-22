# PhysicalVector
#     Types and functions in this file are self-documented

## Physical Vector 2D

struct PhysicalVector2D{T<:AbstractQuantity} <: AbstractPoint2D{T}
    x::T
    y::T
end

## Physical Vector 3D

struct PhysicalVector3D{T<:AbstractQuantity} <: AbstractPoint3D{T}
    x::T
    y::T
    z::T
end

## Generic PhysicalVector constructor

PhysicalVector(x::Quantity, y::Quantity) = PhysicalVector2D(x, y)
PhysicalVector(x::Quantity, y::Quantity, z::Quantity) = PhysicalVector3D(x, y, z)