# NonUnitVector
#     Types and functions in this file are self-documented

## Point 2D

struct Point2D{T<:AbstractFloat} <: AbstractPoint2D{T}
    x::T
    y::T
end

abstractpoint2d(::Type{<:Float16}, ::Type{<:Float16}) = Point2D{Float16}
abstractpoint2d(::Type{<:Float32}, ::Type{<:Float32}) = Point2D{Float32}
abstractpoint2d(::Type{<:Float64}, ::Type{<:Float64}) = Point2D{Float64}
abstractpoint2d(::Type{<:BigFloat}, ::Type{<:BigFloat}) = Point2D{BigFloat}

@inline +(a::Point2D, b::Point2D) = Point2D(a.x + b.x, a.y + b.y)

@inline -(a::Point2D, b::Point2D) = Point2D(a.x - b.x, a.y - b.y)

@inline *(a::Point2D, b::Point2D) = a.x * b.x + a.y * b.y
@inline *(p::Point2D, h::Real) = Point2D(p.x * h, p.y * h)
@inline *(h::Real, p::Point2D) = Point2D(p.x * h, p.y * h)

@inline /(p::Point2D, h::Real) = Point2D(p.x / h, p.y / h)



## Point 3D

struct Point3D{T<:AbstractFloat} <: AbstractPoint3D{T}
    x::T
    y::T
    z::T
end

abstractpoint3d(::Type{<:Float16}, ::Type{<:Float16}, ::Type{<:Float16}) = Point3D{Float16}
abstractpoint3d(::Type{<:Float32}, ::Type{<:Float32}, ::Type{<:Float32}) = Point3D{Float32}
abstractpoint3d(::Type{<:Float64}, ::Type{<:Float64}, ::Type{<:Float64}) = Point3D{Float64}
abstractpoint3d(::Type{<:BigFloat}, ::Type{<:BigFloat}, ::Type{<:BigFloat}) = Point3D{BigFloat}

@inline +(a::Point3D, b::Point3D) = Point3D(a.x + b.x, a.y + b.y, a.z + b.z)

@inline -(a::Point3D, b::Point3D) = Point3D(a.x - b.x, a.y - b.y, a.z - b.z)

@inline *(a::Point3D, b::Point3D) = a.x * b.x + a.y * b.y + a.z * b.z
@inline *(p::Point3D, h::Real) = Point3D(p.x * h, p.y * h, p.z * h)
@inline *(h::Real, p::Point3D) = Point3D(p.x * h, p.y * h, p.z * h)

@inline /(p::Point3D, h::Real) = Point3D(p.x / h, p.y / h, p.z / h)



## General Point constructor

Point(x::AbstractFloat, y::AbstractFloat) = Point2D(x, y)
Point(x::AbstractFloat, y::AbstractFloat, z::AbstractFloat) = Point3D(x, y, z)