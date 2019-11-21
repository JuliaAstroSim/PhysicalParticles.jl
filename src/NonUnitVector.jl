struct Point2D{T<:AbstractFloat} <: AbstractPoint2D{T}
    x::T
    y::T
end

abstractpoint2d(::Type{<:AbstractFloat}, ::Type{<:AbstractFloat}) = Point2D()

struct Point3D{T<:AbstractFloat} <: AbstractPoint3D{T}
    x::T
    y::T
    z::T
end

abstractpoint3d(::Type{<:AbstractFloat}, ::Type{<:AbstractFloat}, ::Type{<:AbstractFloat}) = Point3D()