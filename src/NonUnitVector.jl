struct Point2D <: AbstractPoint2D
    x::Float64
    y::Float64
    Point2D(x::Float64,y::Float64) = new(x, y)
end

struct Point3D <: AbstractPoint3D
    x::Float64
    y::Float64
    z::Float64
    Point3D(x::Float64,y::Float64,z::Float64) = new(x, y, z)
end