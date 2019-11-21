# Generic functions
@inline norm(p::AbstractPoint) = sqrt(p * p)
# This is same with the following expression on the compiled level:
# @inline norm(p::Point2D) = sqrt(p.x * p.x + p.y * p.y)

@inline normalize(p::AbstractPoint) = p / norm(p)



# Point2D

@inline rotate_z(p::Point2D, theta::AbstractFloat) = Point2D(p.x*cos(theta)-p.y*sin(theta), p.x*sin(theta)+p.y*cos(theta))
@inline rotate(p::Point2D, theta::AbstractFloat) = rotate_z(p, theta)


# Point3D

@inline rotate_x(p::Point3D, theta::AbstractFloat) = Point3D(p.x, p.y*cos(theta)-p.z*sin(theta), p.y*sin(theta)+p.z*cos(theta))
@inline rotate_y(p::Point3D, theta::AbstractFloat) = Point3D(p.x*cos(theta)+p.z*sin(theta), p.y, -p.x*sin(theta)+p.z*cos(theta))
@inline rotate_z(p::Point3D, theta::AbstractFloat) = Point3D(p.x*cos(theta)-p.y*sin(theta), p.x*sin(theta)+p.y*cos(theta), p.z)
