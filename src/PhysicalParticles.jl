"""
Main module for `PhysicalParticles.jl` -- Physical vector and particle types for Julia.

# Exports
$(EXPORTS)
"""
module PhysicalParticles

using DocStringExtensions
using Unitful, UnitfulAstro
using Setfield
using BangBang

## Explicitly overload functions and import types
import Unitful: Units, Quantity, AbstractQuantity, uconvert, ustrip, @u_str
import Core: Symbol
import Base: +, -, *, /, zero, length, iterate, real, rand, show, ==, getproperty,
             one, zero, isone, iszero, isnan, isinf, oneunit, push!

import LinearAlgebra: norm, normalize, dot, cross

import Statistics: mean, std, var, median, middle

export
    AbstractPoint,
        AbstractPoint2D, AbstractPoint3D,

    getx, gety, getz,

    PVector, PVector2D,


    AbstractParticle,
        AbstractParticle2D, AbstractParticle3D,

    Massless, Massless2D,
    Ball, Ball2D,
    Star, Star2D,
    SPHGas, SPHGas2D,

    countdata,
    split_data,

    AbstractExtent,
        AbstractExtent2D, AbstractExtent3D,

    Extent, Extent2D,
        extent,

    # Traits
    AbstractParticleCollection,
        AbstractGasCollection,
            GAS,

        AbstractStarCollection,
            HALO, DISK, BULGE, STAR, BLACKHOLE,

    # AbstractDataDimension,
    datadimension,
        Physical2D, Physical3D,
        Unitless2D, Unitless3D,

    hasnan, hasinf,

    # LinearAlgebra
    norm, normalize, dot, cross,

    rotate, rotate_x, rotate_y, rotate_z,

    distance,

    average, averagebymass,

    # Statistics
    mean, std, var, median, middle,

    # Center
    min_x, min_y, min_z,
    max_x, max_y, max_z,
    minimum_x, minimum_y, minimum_z,
    maximum_x, maximum_y, maximum_z,
    center_x, center_y, center_z, center,
    pos_center, mass_center,


    # Conversion
    pconvert,

    # Unit setting
    uAstro, uSI, uCGS, uDefaults,
    astro, si, cgs,
    preferunits,
    getunits,
        getuLength,
        getuTime,
        getuCurrent,
        getuTemperature,
        getuLuminosity,
        getuMass,
        getuAmount,

        getuVel,
        getuAcc,
        getuEnergy,
        getuEntropy,
        getuDensity,
        getuDensity2D,
        getuPressure,

    axisunit,

    @u_str,

    # Random
    rand_pvector, rand_pvector2d,
    randn_pvector, randn_pvector2d,

    assign_particles



### Top level data structure

"""
AbstractPoint

Top level mathematical vector type defined in PhysicalParticles.jl
It is named to distinguish from the built-in type `AbstractVector`
"""
abstract type AbstractPoint{T} end
abstract type AbstractPoint2D{T} <: AbstractPoint{T} end
abstract type AbstractPoint3D{T} <: AbstractPoint{T} end

@inline length(p::T) where T <: AbstractPoint = 1
@inline iterate(p::T) where T <: AbstractPoint = (p,nothing)
@inline iterate(p::T,st) where T <: AbstractPoint = nothing
@inline real(p::T) where T <: AbstractPoint = p

getx(p::AbstractPoint) = p.x
gety(p::AbstractPoint) = p.y
getz(p::AbstractPoint3D) = p.z


abstract type AbstractParticle end
abstract type AbstractParticle2D <: AbstractParticle end
abstract type AbstractParticle3D <: AbstractParticle end

@inline length(p::T) where T <: AbstractParticle = 1
@inline iterate(p::T) where T <: AbstractParticle = (p,nothing)
@inline iterate(p::T,st) where T <: AbstractParticle = nothing
@inline real(p::T) where T <: AbstractParticle = p



abstract type AbstractExtent{T} end
abstract type AbstractExtent2D{T} <: AbstractExtent{T} end
abstract type AbstractExtent3D{T} <: AbstractExtent{T} end

@inline length(p::T) where T <: AbstractExtent = 1
@inline iterate(p::T) where T <: AbstractExtent = (p,nothing)
@inline iterate(p::T,st) where T <: AbstractExtent = nothing
@inline real(p::T) where T <: AbstractExtent = p

### overload Base.:(==)

function Base.:(==)(x::T, y::T) where T<:Union{AbstractPoint, AbstractParticle, AbstractExtent}
    for field in fieldnames(T)
        if getfield(x, field) != getfield(y, field)
            return false
        end
    end
    return true
end

Base.getproperty(d::Dict,s::Symbol) = s ∈ fieldnames(Dict) ? getfield(d,s) : getindex(d,s)

### Main files

include("Traits.jl")
include("Unit.jl")

include("PVector.jl")
include("PhysicalParticle.jl")

include("Conversion.jl")
include("Random.jl")
include("LinearAlgebra.jl")
include("Center.jl")
include("Extent.jl")
include("Neighbors.jl")
include("Clustering.jl")
include("PrettyPrinting.jl")

end  # module PhysicalParticles
