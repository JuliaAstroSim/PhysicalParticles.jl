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

_common_keyword_rotate_vel = """
- `vel::Bool = false`: Rotate velocity around origin at the same time.
"""

"""
    rotate_x(p::PVector, roll::Number)

Rotate `p` around x-axis by `roll` in radian angle.
The rotation direction is right-handed, which is counter-clockwise in y-z plane.
Angles can have units, for example, u"°" (\\degree).

The rotation matrix:
```
           | 1      0          0      |
Rx(roll) = | 0  cos(roll)  -sin(roll) |
           | 0  sin(roll)   cos(roll) |
```
"""
@inline rotate_x(p::PVector, roll::Number) = PVector(p.x, p.y*cos(roll)-p.z*sin(roll), p.y*sin(roll)+p.z*cos(roll))

"""
    rotate_x(data, roll::Number)

Rotate all particles in data around x-axis by `roll` in radian angle.
"""
function rotate_x(data::Array, roll::Number)
    for i in eachindex(data)
        data[i] = setproperties!!(data[i], Pos = rotate_x(data[i].Pos, roll))
    end
    data
end

function rotate_x(data::Dict, roll::Number)
    for k in keys(data)
        rotate_x(data[k], roll)
    end
    data
end

"""
    rotate_x(p::PVector, roll::Number, center::PVector)

Rotate `p` around the x-axis of `center` point by `roll` in radian angle.
"""
rotate_x(p::PVector, roll::Number, center::PVector) = rotate_x(p - center, roll) + center

"""
    rotate_x(data, roll::Number, center::PVector)

Rotate all particles in data around the x-axis of `center` point by `roll` in radian angle.
"""
function rotate_x(data::Array, roll::Number, center::PVector)
    for i in eachindex(data)
        data[i] = setproperties!!(data[i], Pos = rotate_x(data[i].Pos, roll, center))
    end
    data
end

function rotate_x(data::Dict, roll::Number, center::PVector)
    for k in keys(data)
        rotate_x(data[k], roll, center)
    end
    data
end



"""
    rotate_y(p::PVector, pitch::Number)

Rotate `p` around y-axis by `pitch` in radian angle.
The rotation direction is right-handed, which is counter-clockwise in y-z plane.
Angles can have units, for example, u"°" (\\degree).

The rotation matrix:
```
            |  cos(pitch)   0   sin(pitch) |
Ry(pitch) = |       0       1        0     |
            | -sin(pitch)   0   cos(pitch) |
```
"""
@inline rotate_y(p::PVector, pitch::Number) = PVector(p.x*cos(pitch)+p.z*sin(pitch), p.y, -p.x*sin(pitch)+p.z*cos(pitch))

"""
    rotate_y(data, pitch::Number)

Rotate all particles in data around y-axis by `pitch` in radian angle.
"""
function rotate_y(data::Array, pitch::Number)
    for i in eachindex(data)
        data[i] = setproperties!!(data[i], Pos = rotate_y(data[i].Pos, pitch))
    end
    data
end

function rotate_y(data::Dict, pitch::Number)
    for k in keys(data)
        rotate_y(data[k], pitch)
    end
    data
end

"""
    rotate_y(p::PVector, pitch::Number, center::PVector)

Rotate `p` around the y-axis of `center` point by `pitch` in radian angle.
"""
rotate_y(p::PVector, pitch::Number, center::PVector) = rotate_y(p - center, pitch) + center

"""
    rotate_y(data, pitch::Number, center::PVector)

Rotate all particles in data around the y-axis of `center` point by `pitch` in radian angle.
"""
function rotate_y(data::Array, pitch::Number, center::PVector)
    for i in eachindex(data)
        data[i] = setproperties!!(data[i], Pos = rotate_y(data[i].Pos, pitch, center))
    end
    data
end

function rotate_y(data::Dict, pitch::Number, center::PVector)
    for k in keys(data)
        rotate_y(data[k], pitch, center)
    end
    data
end



"""
    rotate_z(p::PVector, yaw::Number)

Rotate `p` around z-axis by `yaw` in radian angle.
The rotation direction is right-handed, which is counter-clockwise in y-z plane.
Angles can have units, for example, u"°" (\\degree).

The rotation matrix:
```
          | cos(yaw)  -sin(yaw)  0 |
Rz(yaw) = | sin(yaw)   cos(yaw)  0 |
          |    0          0      1 |
```
"""
@inline rotate_z(p::PVector, theta::Number) = PVector(p.x*cos(theta)-p.y*sin(theta), p.x*sin(theta)+p.y*cos(theta), p.z)

"""
    rotate_z(data, yaw::Number)

Rotate all particles in data around z-axis by `yaw` in radian angle.
"""
function rotate_z(data::Array, yaw::Number)
    for i in eachindex(data)
        data[i] = setproperties!!(data[i], Pos = rotate_z(data[i].Pos, yaw))
    end
    data
end

function rotate_z(data::Dict, yaw::Number)
    for k in keys(data)
        rotate_z(data[k], yaw)
    end
    data
end

"""
    rotate_z(p::PVector, yaw::Number, center::PVector)

Rotate `p` around the z-axis of `center` point by `yaw` in radian angle.
"""
rotate_z(p::PVector, yaw::Number, center::PVector) = rotate_z(p - center, yaw) + center

"""
    rotate_z(data, yaw::Number, center::PVector)

Rotate all particles in data around the z-axis of `center` point by `yaw` in radian angle.
"""
function rotate_z(data::Array, yaw::Number, center::PVector)
    for i in eachindex(data)
        data[i] = setproperties!!(data[i], Pos = rotate_z(data[i].Pos, yaw, center))
    end
    data
end

function rotate_z(data::Dict, yaw::Number, center::PVector)
    for k in keys(data)
        rotate_z(data[k], yaw, center)
    end
    data
end



"""
    rotate(p::PVector, α::Number, β::Number, γ::Number)

Rotate `p` in radian Euler angles (α, β, γ) = (roll, pitch, yaw).
Angles can have units, for example, u"°" (\\degree).
"""
rotate(p::PVector, α::Number, β::Number, γ::Number) = rotate_z(rotate_y(rotate_x(p, α), β), γ)

"""
    rotate(p::PVector, α::Number, β::Number, γ::Number, center::PVector)

Rotate `p` in radian Euler angles (α, β, γ) = (roll, pitch, yaw) around `center` point
"""
rotate(p::PVector, α::Number, β::Number, γ::Number, center::PVector) = rotate(p - center, α, β, γ) + center

"""
rotate(p::PVector, vec::PVector, θ::Number)

Rotate `p` around direction vector `vec` by angle `θ`.

For normalized `vec = (x, y, z)`, the rotation matrix:
```
            |  cos(θ) + (1-cos(θ))*x^2   (1-cos(θ))*x*y - sin(θ)*z  (1-cos(θ))*x*z + sin(θ)*y |
M(vec, θ) = | (1-cos(θ))*y*x + sin(θ)*z   cos(θ) + (1-cos(θ))*y^2   (1-cos(θ))*y*z - sin(θ)*x |
            | (1-cos(θ))*z*x - sin(θ)*y  (1-cos(θ))*z*y + sin(θ)*x   cos(θ) + (1-cos(θ))*z^2  |
```
"""
function rotate(p::PVector, vec::PVector, θ::Number)
    vn = normalize(ustrip(vec))
    return PVector(
        p.x * (cos(θ) + (1-cos(θ))*vn.x^2)         + p.y * ((1-cos(θ))*vn.x*vn.y - sin(θ)*vn.z) + p.z * ((1-cos(θ))*vn.x*vn.z + sin(θ)*vn.y),
        p.x * ((1-cos(θ))*vn.y*vn.x + sin(θ)*vn.z) + p.y * (cos(θ) + (1-cos(θ))*vn.y^2)         + p.z * ((1-cos(θ))*vn.y*vn.z - sin(θ)*vn.x),
        p.x * ((1-cos(θ))*vn.z*vn.x - sin(θ)*vn.y) + p.y * ((1-cos(θ))*vn.z*vn.y + sin(θ)*vn.x) + p.z * (cos(θ) + (1-cos(θ))*vn.z^2)
    )
end

"""
    rotate(data::Array, vec::PVector, θ::Number)

Rotate all particles in data around direction vector `vec` by angle `θ`.
"""
function rotate(data::Array, vec::PVector, θ::Number)
    for i in eachindex(data)
        data[i] = setproperties!!(data[i], Pos = rotate(data[i].Pos, vec, θ))
    end
    data
end

function rotate(data::Dict, vec::PVector, θ::Number)
    for k in keys(data)
        rotate(data[k], vec, θ)
    end
    data
end

"""
    rotate(p::PVector, vec::PVector, θ::Number, center::PVector)

Rotate `p` around direction vector `vec` at `center` point by angle `θ`.
"""
rotate(p::PVector, vec::PVector, θ::Number, center::PVector) = rotate(p - center, vec, θ) + center

"""
    rotate(data, vec::PVector, θ::Number, center::PVector)

Rotate all particles in data around direction vector `vec` at `center` point by angle `θ`.
"""
function rotate(data::Array, vec::PVector, θ::Number, center::PVector)
    for i in eachindex(data)
        data[i] = setproperties!!(data[i], Pos = rotate(data[i].Pos, vec, θ, center))
    end
    data
end

function rotate(data::Dict, vec::PVector, θ::Number, center::PVector)
    for k in keys(data)
        rotate(data[k], vec, θ, center)
    end
    data
end


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