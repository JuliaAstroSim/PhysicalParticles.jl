#####  Points and vectors  #####

min_x(a::AbstractPoint, b::AbstractPoint) = ifelse(isless(a.x, b.x), a, b)
min_x(a::AbstractParticle, b::AbstractParticle) = ifelse(isless(a.Pos.x, b.Pos.x), a, b)

min_y(a::AbstractPoint, b::AbstractPoint) = ifelse(isless(a.y, b.y), a, b)
min_y(a::AbstractParticle, b::AbstractParticle) = ifelse(isless(a.Pos.y, b.Pos.y), a, b)

min_z(a::AbstractPoint3D, b::AbstractPoint3D) = ifelse(isless(a.z, b.z), a, b)
min_z(a::AbstractParticle3D, b::AbstractParticle3D) = ifelse(isless(a.Pos.z, b.Pos.z), a, b)

max_x(a::AbstractPoint, b::AbstractPoint) = ifelse(isless(a.x, b.x), b, a)
max_x(a::AbstractParticle, b::AbstractParticle) = ifelse(isless(a.Pos.x, b.Pos.x), b, a)

max_y(a::AbstractPoint, b::AbstractPoint) = ifelse(isless(a.y, b.y), b, a)
max_y(a::AbstractParticle, b::AbstractParticle) = ifelse(isless(a.Pos.y, b.Pos.y), b, a)

max_z(a::AbstractPoint, b::AbstractPoint) = ifelse(isless(a.z, b.z), b, a)
max_z(a::AbstractParticle, b::AbstractParticle) = ifelse(isless(a.Pos.z, b.Pos.z), b, a)

function minimum_x(a::Array{T,N}) where T <: AbstractPoint where N
    m = mapreduce(identity, min_x, a)
    return m.x
end

function minimum_x(a::Array{T,N}) where T <: AbstractParticle where N
    m = mapreduce(identity, min_x, a)
    return m.Pos.x
end

function minimum_y(a::Array{T,N}) where T <: AbstractPoint where N
    m = mapreduce(identity, min_y, a)
    return m.y
end

function minimum_y(a::Array{T,N}) where T <: AbstractParticle where N
    m = mapreduce(identity, min_y, a)
    return m.Pos.y
end

function minimum_z(a::Array{T,N}) where T <: AbstractPoint where N
    m = mapreduce(identity, min_z, a)
    return m.z
end

function minimum_z(a::Array{T,N}) where T <: AbstractParticle where N
    m = mapreduce(identity, min_z, a)
    return m.Pos.z
end

function maximum_x(a::Array{T,N}) where T <: AbstractPoint where N
    m = mapreduce(identity, max_x, a)
    return m.x
end

function maximum_x(a::Array{T,N}) where T <: AbstractParticle where N
    m = mapreduce(identity, max_x, a)
    return m.Pos.x
end

function maximum_y(a::Array{T,N}) where T <: AbstractPoint where N
    m = mapreduce(identity, max_y, a)
    return m.y
end

function maximum_y(a::Array{T,N}) where T <: AbstractParticle where N
    m = mapreduce(identity, max_y, a)
    return m.Pos.y
end

function maximum_z(a::Array{T,N}) where T <: AbstractPoint where N
    m = mapreduce(identity, max_z, a)
    return m.z
end

function maximum_z(a::Array{T,N}) where T <: AbstractParticle where N
    m = mapreduce(identity, max_z, a)
    return m.Pos.z
end

"""
$(SIGNATURES)

Compute center of x direction of points or particles
"""
function center_x(a::Array{T,N}) where T <: Union{AbstractPoint, AbstractParticle} where N
    left = minimum_x(a)
    right = maximum_x(a)
    return (left + right) / 2.0
end

"""
$(SIGNATURES)

Compute center of y direction of points or particles
"""
function center_y(a::Array{T,N}) where T <: Union{AbstractPoint, AbstractParticle} where N
    left = minimum_y(a)
    right = maximum_y(a)
    return (left + right) / 2.0
end

"""
$(SIGNATURES)

Compute center of z direction of points or particles
"""
function center_z(a::Array{T,N}) where T <: Union{AbstractPoint3D, AbstractParticle3D} where N
    left = minimum_z(a)
    right = maximum_z(a)
    return (left + right) / 2.0
end

"""
$(SIGNATURES)

Compute center of points or particles
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


pos_center(a::Array{T}) where T <: AbstractParticle = average(a, :Pos)

mass_center(a::Array{T}) where T <: AbstractParticle = averagebymass(a, :Pos)