## Special treatment with Quantity

@inline norm(p::PVector2D) = sqrt(upreferred(p * p))
@inline normalize(p::PVector2D) = (n = ustrip(norm(p)); return PVector2D(upreferred(p.x/n), upreferred(p.y/n)))

@inline norm(p::PVector) = sqrt(upreferred(p * p))
@inline normalize(p::PVector) = (n = ustrip(norm(p)); return PVector(upreferred(p.x/n), upreferred(p.y/n), upreferred(p.z/n)))


## PVector2D

@inline rotate_z(p::PVector2D, theta::T) where T<:Union{Number, Quantity} = PVector2D(p.x*cos(theta)-p.y*sin(theta), p.x*sin(theta)+p.y*cos(theta))
@inline rotate(p::PVector2D, theta::T) where T<:Union{Number, Quantity} = rotate_z(p, theta)

### Cross product of 2D vectors (which is a number) is not supported here


## PVector

@inline rotate_x(p::PVector, theta::T) where T<:Union{Number, Quantity} = PVector(p.x, p.y*cos(theta)-p.z*sin(theta), p.y*sin(theta)+p.z*cos(theta))
@inline rotate_y(p::PVector, theta::T) where T<:Union{Number, Quantity} = PVector(p.x*cos(theta)+p.z*sin(theta), p.y, -p.x*sin(theta)+p.z*cos(theta))
@inline rotate_z(p::PVector, theta::T) where T<:Union{Number, Quantity} = PVector(p.x*cos(theta)-p.y*sin(theta), p.x*sin(theta)+p.y*cos(theta), p.z)

cross(a::PVector, b::PVector) = PVector(a.y * b.z - a.z * b.y, 
                                        a.z * b.x - a.x * b.z, 
                                        a.x * b.y - a.y * b.x)


## Generic functions

@inline norm(p::AbstractPoint) = sqrt(p * p)
# This is same with the following expression on the compiled level:
# @inline norm(p::PVector2D) = sqrt(p.x * p.x + p.y * p.y)

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

@inline distance(a::AbstractPoint, b::AbstractPoint) = norm(a - b)
@inline distance(a::AbstractParticle, b::AbstractParticle) = norm(a.Pos - b.Pos)