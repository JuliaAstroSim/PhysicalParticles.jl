## Special treatment with Quantity

@inline norm(p::PVector2D) = sqrt(upreferred(p * p))
@inline normalize(p::PVector2D) = (n = ustrip(norm(p)); return PVector2D(upreferred(p.x/n), upreferred(p.y/n)))

@inline norm(p::PVector) = sqrt(upreferred(p * p))
@inline normalize(p::PVector) = (n = ustrip(norm(p)); return PVector(upreferred(p.x/n), upreferred(p.y/n), upreferred(p.z/n)))


## PVector2D

@inline rotate_z(p::PVector2D, theta::T) where T<:Number = PVector2D(p.x*cos(theta)-p.y*sin(theta), p.x*sin(theta)+p.y*cos(theta))
@inline rotate(p::PVector2D, theta::T) where T<:Number = rotate_z(p, theta)

### Cross product of 2D vectors (which is a number) is not supported here


## PVector

@inline rotate_x(p::PVector, theta::T) where T<:Number = PVector(p.x, p.y*cos(theta)-p.z*sin(theta), p.y*sin(theta)+p.z*cos(theta))
@inline rotate_y(p::PVector, theta::T) where T<:Number = PVector(p.x*cos(theta)+p.z*sin(theta), p.y, -p.x*sin(theta)+p.z*cos(theta))
@inline rotate_z(p::PVector, theta::T) where T<:Number = PVector(p.x*cos(theta)-p.y*sin(theta), p.x*sin(theta)+p.y*cos(theta), p.z)

cross(a::PVector, b::PVector) = PVector(a.y * b.z - a.z * b.y, 
                                        a.z * b.x - a.x * b.z, 
                                        a.x * b.y - a.y * b.x)


## Generic functions

dot(a::AbstractPoint, b::AbstractPoint) = *(a,b)

@inline distance(a::AbstractPoint, b::AbstractPoint) = norm(a - b)
@inline distance(a::AbstractParticle, b::AbstractParticle) = norm(a.Pos - b.Pos)


function average(a::Array{T}, symbol::Symbol) where T<:AbstractParticle
    if length(a) == 1
        return getfield(a[1], symbol)
    end

    sum = getfield(a[1], symbol)
    for p in a[2:end]
        sum += getfield(p, symbol)
    end

    return sum / length(a)
end

function averagebymass(a::Array{T}, symbol::Symbol) where T<:AbstractParticle
    if length(a) == 1
        return getfield(a[1], symbol)
    end

    sum = getfield(a[1], symbol)
    sum_mass = a[1].Mass
    for p in a[2:end]
        sum += getfield(p, symbol) * p.Mass
        sum_mass += p.Mass
    end

    return sum / sum_mass
end

averagebymass(a::Array{T}, symbol::Symbol) where T <: Union{Massless, Massless2D} = average(a, symbol)