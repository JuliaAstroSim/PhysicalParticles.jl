"""
Main module for `PhysicalParticles.jl` -- Physical vector and particle types for Julia.

# Exports
$(EXPORTS)
"""
module PhysicalParticles

__precompile__(true)

using DocStringExtensions
using Unitful, UnitfulAstro, PhysicalConstants

## Explicitly overload functions and import types
import Unitful: Units, AbstractQuantity

import Base: +,-,*,/,zero,length,iterate,real,to_index, rand, show, ==, getproperty

import LinearAlgebra: norm, normalize, dot, cross

import Statistics: mean, std, var

import PhysicalConstants: CODATA2018, @constant

export
    AbstractPoint,
        AbstractPoint2D, AbstractPoint3D,

    PVector, PVector2D,


    AbstractParticle,
        AbstractParticle2D, AbstractParticle3D,

    Massless, Massless2D,
    Ball, Ball2D,
    Star, Star2D,
    SPHGas, SPHGas2D,


    AbstractExtent,
        AbstractExtent2D, AbstractExtent3D,

    Extent, Extent2D,
    mass_center, extent,

    # Base functions
    +, -, *, /, zero, length, iterate, real,

    show, display,
    ==,
    getproperty,

    # LinearAlgebra
    norm, normalize, dot, cross,

    rotate, rotate_x, rotate_y, rotate_z,

    mean, distance,

    # Center
    min_x, min_y, min_z,
    max_x, max_y, max_z,
    center_x, center_y, center_z, center,

    # Conversion
    pconvert,

    # Peano
    peanokey, hilbertsort!, mssort!,

    # Random
    rand_pvector, rand_pvector2d,
    randn_pvector, randn_pvector2d,

    assign_points

    # Trait functions
    


## Include files

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

### Enable Symbol indexing of Dict
Base.getproperty(d::Dict, s::Symbol) = s ∈ fieldnames(Dict) ? getfield(d, s) : getindex(d, s)

### Main files

include("PVector.jl")
include("PhysicalParticle.jl")

### Numerics
"""
Basic mathematical algorithms should be implemented in type definition files,
in the following order:
    - get, set
    - +, -, *

Other operations would be implemented in seperate files:
    - Conversion.jl ==> Conversions from and to array, conversions between inner types
    - Random.jl ==> Generate random points and assign to particles
    - LinearAlgebra.jl ==> General linear algebra methods
    - Center.jl ==> Compute maximum, minimum, center
    - Extent.jl ==> Compute extent for array of points and particles
    - Neighbours.jl ==> Nearest neighbour searching
    - Clustering.jl ==> Cluster center and clustering patterns, use kdtree methods in Neighbours
"""

include("Conversion.jl")
include("Random.jl")
include("LinearAlgebra.jl")
include("Center.jl")
include("Extent.jl")
include("Neighbors.jl")
include("Clustering.jl")
include("PrettyPrinting.jl")
include("Peano.jl")

end  # module PhysicalParticles
