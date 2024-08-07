"""
Main module for `PhysicalParticles.jl` -- Physical vector and particle types for Julia.

# Exports
$(EXPORTS)
"""
module PhysicalParticles

using DocStringExtensions
using Unitful, UnitfulAstro
using BangBang
using Measurements
using Random
using Reexport
using StaticArrays
@reexport using StructArrays

## Explicitly overload functions and import types
import Unitful: Units, Quantity, AbstractQuantity, uconvert, ustrip, @u_str
import PhysicalConstants: PhysicalConstant, CODATA2018, @constant
import Measurements: Measurement, measurement, value
import Core: Symbol
import Base: +, -, *, /, zero, length, iterate, real, show, ==, #getproperty,
             convert,
             Array, Vector,
             one, zero, isone, iszero, isnan, isinf, oneunit, isapprox, parse
import Random: rand, randn
import LinearAlgebra: norm, normalize, dot, cross, ×

import Statistics: mean, std, var, median, middle
import StaticArrays: SVector, SArray, MVector, MArray

export NumericalIntegration
export
    AbstractPoint,
        AbstractPoint2D, AbstractPoint3D,

    getx, gety, getz,

    PVector, PVector2D,

    numeric_type,


    AbstractParticle,
        AbstractParticle2D, AbstractParticle3D,

    Massless, Massless2D,
    Ball, Ball2D,
    Star, Star2D,

    split_block,
    split_data,

    AbstractExtent,
        AbstractExtent2D, AbstractExtent3D,

    Extent, Extent2D,
        extent,
        #volume, area,

    # Traits
    Collection,
        GAS, HALO, DISK, BULGE, STAR, BLACKHOLE,

    # Constants
    Constant,

    # Measurements
    value,

    # AbstractDataDimension,
    datadimension,
        AbstractDataDimension,
        Physical2D, Physical3D,
        Unitless2D, Unitless3D,

    hasnan, hasinf,

    # LinearAlgebra
    norm, normalize, dot, cross, ×,

    rotate, rotate_x, rotate_y, rotate_z,

    distance,

    average, averagebymass,

    # Coordinates
    cylinderial2cartesian,
    spherical2cartesian,
    cartesian2cylinderial,
    cartesian2spherical,

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
    pack_xy, pack_xyz,

    # Unit setting
    uAstro, uSI, uCGS, uGadget2, uDefaults,
    astro, si, cgs, ugadget2,
    Gadget2Mass,
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
        getuEnergyUnit,
        getuEntropy,
        getuDensity,
        getuDensity2D,
        getuPressure,
        getuMomentum,
        getuMomentumAngular,

    axisunit,
    ZeroValue,

    @u_str,
    Measurement, measurement,
    ismeasurement,

    # Random
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

#Base.getproperty(d::Dict,s::Symbol) = s ∈ fieldnames(Dict) ? getfield(d,s) : getindex(d,s)

_center_doc = """
There are differences among `center`, `pos_center`, `mass_center` and `median`:
- `center`: box center of particles
- `pos_center`: average position of particles
- `mass_center`: mass weighted average position of particles
- `median`: middle value of positions of particles
"""

### Main files

include("Traits.jl")
include("Unit.jl")
include("Constants.jl")

include("PVector.jl")
include("Coordinates.jl")
include("parse.jl")
include("PhysicalParticle.jl")

include("Conversion.jl")
include("Random.jl")
include("LinearAlgebra.jl")
include("Center.jl")
include("Extent.jl")
include("PrettyPrinting.jl")

include("NumericalIntegration.jl")

function __init__()
    Unitful.register(PhysicalParticles)
end

end  # module PhysicalParticles
