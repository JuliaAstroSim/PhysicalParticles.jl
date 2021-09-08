#####  Points and vectors  #####

"""
    min_x(a::AbstractPoint, b::AbstractPoint)
    min_x(a::AbstractParticle, b::AbstractParticle)

Return the smaller `:x` field of `a` and `b`
"""
min_x(a::AbstractPoint, b::AbstractPoint) = ifelse(isless(a.x, b.x), a, b)
min_x(a::AbstractParticle, b::AbstractParticle) = ifelse(isless(a.Pos.x, b.Pos.x), a, b)

"""
    min_y(a::AbstractPoint, b::AbstractPoint)
    min_y(a::AbstractParticle, b::AbstractParticle)

Return the smaller `:y` field of `a` and `b`
"""
min_y(a::AbstractPoint, b::AbstractPoint) = ifelse(isless(a.y, b.y), a, b)
min_y(a::AbstractParticle, b::AbstractParticle) = ifelse(isless(a.Pos.y, b.Pos.y), a, b)

"""
    min_z(a::AbstractPoint, b::AbstractPoint)
    min_z(a::AbstractParticle, b::AbstractParticle)

Return the smaller `:z` field of `a` and `b`
"""
min_z(a::AbstractPoint3D, b::AbstractPoint3D) = ifelse(isless(a.z, b.z), a, b)
min_z(a::AbstractParticle3D, b::AbstractParticle3D) = ifelse(isless(a.Pos.z, b.Pos.z), a, b)

"""
    max_x(a::AbstractPoint, b::AbstractPoint)
    max_x(a::AbstractParticle, b::AbstractParticle)

Return the larger `:x` field of `a` and `b`
"""
max_x(a::AbstractPoint, b::AbstractPoint) = ifelse(isless(a.x, b.x), b, a)
max_x(a::AbstractParticle, b::AbstractParticle) = ifelse(isless(a.Pos.x, b.Pos.x), b, a)

"""
    max_y(a::AbstractPoint, b::AbstractPoint)
    max_y(a::AbstractParticle, b::AbstractParticle)

Return the larger `:y` field of `a` and `b`
"""
max_y(a::AbstractPoint, b::AbstractPoint) = ifelse(isless(a.y, b.y), b, a)
max_y(a::AbstractParticle, b::AbstractParticle) = ifelse(isless(a.Pos.y, b.Pos.y), b, a)

"""
    max_z(a::AbstractPoint, b::AbstractPoint)
    max_z(a::AbstractParticle, b::AbstractParticle)

Return the larger `:z` field of `a` and `b`
"""
max_z(a::AbstractPoint, b::AbstractPoint) = ifelse(isless(a.z, b.z), b, a)
max_z(a::AbstractParticle, b::AbstractParticle) = ifelse(isless(a.Pos.z, b.Pos.z), b, a)

"""
    function minimum_x(a::Array{T,N}) where T <: AbstractPoint where N
    function minimum_x(a::Array{T,N}) where T <: AbstractParticle where N
    function minimum_x(a::StructArray)

Return the minimum `:x` field of points in array `a`
Return the minimum `Pos.x` of particles in array `a`
"""
function minimum_x(a::Array{T,N}) where T <: AbstractPoint where N
    m = mapreduce(identity, min_x, a)
    return m.x
end

function minimum_x(a::Array{T,N}) where T <: AbstractParticle where N
    m = mapreduce(identity, min_x, a)
    return m.Pos.x
end

minimum_x(a::StructArray) = minimum_x(a.Pos)

"""
    function minimum_y(a::Array{T,N}) where T <: AbstractPoint where N
    function minimum_y(a::Array{T,N}) where T <: AbstractParticle where N
    function minimum_y(a::StructArray)

Return the minimum `:y` field of points in array `a`
Return the minimum `Pos.y` of particles in array `a`
"""
function minimum_y(a::Array{T,N}) where T <: AbstractPoint where N
    m = mapreduce(identity, min_y, a)
    return m.y
end

function minimum_y(a::Array{T,N}) where T <: AbstractParticle where N
    m = mapreduce(identity, min_y, a)
    return m.Pos.y
end

minimum_y(a::StructArray) = minimum_y(a.Pos)

"""
    function minimum_z(a::Array{T,N}) where T <: AbstractPoint where N
    function minimum_z(a::Array{T,N}) where T <: AbstractParticle where N
    function minimum_z(a::StructArray)

Return the minimum `:z` field of points in array `a`
Return the minimum `Pos.z` of particles in array `a`
"""
function minimum_z(a::Array{T,N}) where T <: AbstractPoint where N
    m = mapreduce(identity, min_z, a)
    return m.z
end

function minimum_z(a::Array{T,N}) where T <: AbstractParticle where N
    m = mapreduce(identity, min_z, a)
    return m.Pos.z
end

minimum_z(a::StructArray) = minimum_z(a.Pos)

"""
    function maximum_x(a::Array{T,N}) where T <: AbstractPoint where N
    function maximum_x(a::Array{T,N}) where T <: AbstractParticle where N
    function maximum_x(a::StructArray)

Return the maximum `:x` field of points in array `a`
Return the maximum `Pos.x` of particles in array `a`
"""
function maximum_x(a::Array{T,N}) where T <: AbstractPoint where N
    m = mapreduce(identity, max_x, a)
    return m.x
end

function maximum_x(a::Array{T,N}) where T <: AbstractParticle where N
    m = mapreduce(identity, max_x, a)
    return m.Pos.x
end

maximum_x(a::StructArray) = maximum_x(a.Pos)

"""
    function maximum_y(a::Array{T,N}) where T <: AbstractPoint where N
    function maximum_y(a::Array{T,N}) where T <: AbstractParticle where N
    function maximum_y(a::StructArray)

Return the maximum `:y` field of points in array `a`
Return the maximum `Pos.y` of particles in array `a`
"""
function maximum_y(a::Array{T,N}) where T <: AbstractPoint where N
    m = mapreduce(identity, max_y, a)
    return m.y
end

function maximum_y(a::Array{T,N}) where T <: AbstractParticle where N
    m = mapreduce(identity, max_y, a)
    return m.Pos.y
end

maximum_y(a::StructArray) = maximum_y(a.Pos)

"""
    function maximum_z(a::Array{T,N}) where T <: AbstractPoint where N
    function maximum_z(a::Array{T,N}) where T <: AbstractParticle where N
    function maximum_z(a::StructArray)

Return the maximum `:z` field of points in array `a`
Return the maximum `Pos.z` of particles in array `a`
"""
function maximum_z(a::Array{T,N}) where T <: AbstractPoint where N
    m = mapreduce(identity, max_z, a)
    return m.z
end

function maximum_z(a::Array{T,N}) where T <: AbstractParticle where N
    m = mapreduce(identity, max_z, a)
    return m.Pos.z
end

maximum_z(a::StructArray) = maximum_z(a.Pos)

"""
$(SIGNATURES)

Compute box center of x direction of points or particles
"""
function center_x(a::Array{T,N}) where T <: Union{AbstractPoint, AbstractParticle} where N
    left = minimum_x(a)
    right = maximum_x(a)
    return (left + right) / 2.0
end

center_x(a::StructArray) = center_x(a.Pos)

"""
$(SIGNATURES)

Compute box center of y direction of points or particles
"""
function center_y(a::Array{T,N}) where T <: Union{AbstractPoint, AbstractParticle} where N
    left = minimum_y(a)
    right = maximum_y(a)
    return (left + right) / 2.0
end

center_y(a::StructArray) = center_y(a.Pos)

"""
$(SIGNATURES)

Compute box center of z direction of points or particles
"""
function center_z(a::Array{T,N}) where T <: Union{AbstractPoint3D, AbstractParticle3D} where N
    left = minimum_z(a)
    right = maximum_z(a)
    return (left + right) / 2.0
end

center_z(a::StructArray) = center_z(a.Pos)

"""
$(SIGNATURES)

Compute box center of points or particles

$_center_doc
"""
function center(a::Array{T,N}) where T <: Union{AbstractPoint2D, AbstractParticle2D} where N
    x = center_x(a)
    y = center_y(a)
    return PVector(x,y)
end

function center(a::Array{T,N}) where T <: Union{AbstractPoint3D, AbstractParticle3D} where N
    x = center_x(a)
    y = center_y(a)
    z = center_z(a)
    return PVector(x,y,z)
end

center(a::StructArray) = center(a.Pos)

"""
    pos_center(a::Array{T}) where T <: AbstractParticle
    pos_center(a::StructArray)

Compute averaged position with equal weights. 
It is different from `middle(a, :Pos)` which computes the middle value of a symbol (useful to avoid influences from distant particles).

$_center_doc
"""
pos_center(a::Array{T}) where T <: AbstractParticle = average(a, :Pos)

pos_center(a::StructArray) = mean(a.Pos)

"""
    mass_center(a::Array{T}) where T <: AbstractParticle
    mass_center(a::StructArray)

Compute mass center of particles, which is weighted by mass.

$_center_doc
"""
mass_center(a::Array{T}) where T <: AbstractParticle = averagebymass(a, :Pos)

mass_center(a::StructArray) = averagebymass(a, :Pos)