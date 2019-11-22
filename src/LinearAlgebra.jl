# Generic functions

@inline norm(p::AbstractPoint) = sqrt(p * p)
# This is same with the following expression on the compiled level:
# @inline norm(p::Point2D) = sqrt(p.x * p.x + p.y * p.y)

@inline normalize(p::AbstractPoint) = p / norm(p)

dot(a::AbstractPoint, b::AbstractPoint) = *(a,b)

function mean(a::Array{AbstractPoint})
    len = length(a)
    p = a[1]
    for i in 2:len
        @inbounds p += a[i]
    end
    return p/len
end

## Point2D

@inline rotate_z(p::Point2D, theta::AbstractFloat) = Point2D(p.x*cos(theta)-p.y*sin(theta), p.x*sin(theta)+p.y*cos(theta))
@inline rotate(p::Point2D, theta::AbstractFloat) = rotate_z(p, theta)

### Cross product of 2D vectors (which is a number) is not supported here

## PhysicalVector2D

## Point3D

@inline rotate_x(p::Point3D, theta::AbstractFloat) = Point3D(p.x, p.y*cos(theta)-p.z*sin(theta), p.y*sin(theta)+p.z*cos(theta))
@inline rotate_y(p::Point3D, theta::AbstractFloat) = Point3D(p.x*cos(theta)+p.z*sin(theta), p.y, -p.x*sin(theta)+p.z*cos(theta))
@inline rotate_z(p::Point3D, theta::AbstractFloat) = Point3D(p.x*cos(theta)-p.y*sin(theta), p.x*sin(theta)+p.y*cos(theta), p.z)

cross(a::Point3D, b::Point3D) = Point3D(a.y * b.z - a.z * b.y, 
                                        a.z * b.x - a.x * b.z, 
                                        a.x * b.y - a.y * b.x)

## PhysicalVector3D

