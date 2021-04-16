## Special treatment with Quantity

@inline norm(p::PVector2D) = sqrt(p * p)
@inline normalize(p::PVector2D) = (n = ustrip(norm(p)); return PVector2D(p.x/n, p.y/n))

@inline norm(p::PVector) = sqrt(p * p)
@inline normalize(p::PVector) = (n = ustrip(norm(p)); return PVector(p.x/n, p.y/n, p.z/n))


## PVector2D

@inline rotate_z(p::PVector2D, theta::Number) = PVector2D(p.x*cos(theta)-p.y*sin(theta), p.x*sin(theta)+p.y*cos(theta))
@inline rotate(p::PVector2D, theta::Number) = rotate_z(p, theta)

### Cross product of 2D vectors (which is a number) is not supported here


## PVector

"""
$(SIGNATURES)

Rotate p around x-axis for angle `theta` in radian
"""
@inline rotate_x(p::PVector, theta::Number) = PVector(p.x, p.y*cos(theta)-p.z*sin(theta), p.y*sin(theta)+p.z*cos(theta))

"""
$(SIGNATURES)

Rotate p around y-axis for angle `theta` in radian
"""
@inline rotate_y(p::PVector, theta::Number) = PVector(p.x*cos(theta)+p.z*sin(theta), p.y, -p.x*sin(theta)+p.z*cos(theta))

"""
$(SIGNATURES)

Rotate p around z-axis for angle `theta` in radian
"""
@inline rotate_z(p::PVector, theta::Number) = PVector(p.x*cos(theta)-p.y*sin(theta), p.x*sin(theta)+p.y*cos(theta), p.z)

"""
    function cross(a::PVector, b::PVector)

Cross product of vector `a` and `b`. Return a new `PVector`
"""
cross(a::PVector, b::PVector) = PVector(a.y * b.z - a.z * b.y, 
                                        a.z * b.x - a.x * b.z, 
                                        a.x * b.y - a.y * b.x)


## Generic functions
"""
$(SIGNATURES)

Dot product or scalar product of vector `a` and `b`.
"""
dot(a::AbstractPoint, b::AbstractPoint) = *(a,b)

"""
    function distance(a::AbstractPoint, b::AbstractPoint)
    distance(a::AbstractParticle, b::AbstractParticle)

Euclidean distance between two points or two particles.
"""
@inline distance(a::AbstractPoint, b::AbstractPoint) = norm(a - b)
@inline distance(a::AbstractParticle, b::AbstractParticle) = norm(a.Pos - b.Pos)

"""
    function average(data, symbol::Symbol)

Average on field `symbol` of elements in an array or dict of arrays

## Examples
```jl
a = rand_pvector(5)
average(a, :x)
```
"""
function average(data, symbol::Symbol)
    a = [getfield(p, symbol) for p in Iterators.flatten(values(data))]
    return sum(a) / length(a)
end

"""
    function averagebymass(data, symbol::Symbol)
    function averagebymass(data::StructArray, symbol::Symbol)

Average on field `symbol` weighted by `:Mass` of elements in an array of dict of arrays

## Examples
```jl
averagebymass(data, :Pos)
```
"""
function averagebymass(data, symbol::Symbol)
    a = [getfield(p, symbol) for p in Iterators.flatten(values(data))]
    m = [getfield(p, :Mass) for p in Iterators.flatten(values(data))]
    msum = sum(m)
    if iszero(msum)
        return mean(a)
    end
    return sum(a .* m) / msum
end

averagebymass(a::Array{T}, symbol::Symbol) where T <: Union{Massless, Massless2D} = average(a, symbol)

function averagebymass(data::StructArray, symbol::Symbol)
    msum = sum(data.Mass)
    if iszero(msum)
        return mean(getproperty(data, symbol))
    end
    return sum(getproperty(data, symbol) .* data.Mass) / msum
end

middle(x::Quantity) = x
middle(x::Quantity, y::Quantity) = x/2 + y/2

"""
    function median(a::Array{T}) where T <: AbstractPoint2D
    function median(a::Array{T}) where T <: AbstractPoint3D

Return the midian value in array of points.
"""
function median(a::Array{T}) where T <: AbstractPoint2D
    return PVector2D(
        median([p.x for p in a]),
        median([p.y for p in a])
    )
end

function median(a::Array{T}) where T <: AbstractPoint3D
    return PVector(
        median([p.x for p in a]),
        median([p.y for p in a]),
        median([p.z for p in a])
    )
end

"""
    function median(a::Array{T}, symbol::Symbol) where T <: AbstractParticle
    function median(d::Dict, symbol::Symbol)

Return the midian value of field `symbol` in array of particles or dict of arrays of particles.

$_center_doc
"""
function median(a::Array{T}, symbol::Symbol) where T <: AbstractParticle
    return median([getfield(p, symbol) for p in a])
end

function median(d::Dict{S, Array{T, N}}) where S where T<:AbstractPoint2D where N
    return PVector2D(
        median([p.x for p in Iterators.flatten(values(d))]),
        median([p.y for p in Iterators.flatten(values(d))])
    )
end

function median(d::Dict{S, Array{T, N}}) where S where T<:AbstractPoint3D where N
    return PVector(
        median([p.x for p in Iterators.flatten(values(d))]),
        median([p.y for p in Iterators.flatten(values(d))]),
        median([p.z for p in Iterators.flatten(values(d))])
    )
end

function median(d::Dict, symbol::Symbol)
    return median([getfield(p, symbol) for p in Iterators.flatten(values(d))])
end