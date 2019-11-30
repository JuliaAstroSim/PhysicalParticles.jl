module PhysicalParticles

using Unitful, UnitfulAstro, PhysicalConstants

## Explicitly overload functions and import types
import Unitful: Units, AbstractQuantity

import Base: +,-,*,/,zero,length,iterate,to_index, rand

import LinearAlgebra: norm, normalize, dot, cross

import Statistics: mean, std, var

import PhysicalConstants: CODATA2018, @constant

export
    AbstractPoint,
        AbstractPoint2D, AbstractPoint3D,

    Point, Point2D, Point3D,

    PhysicalVector, PhysicalVector2D, PhysicalVector3D,


    AbstractParticle,
        AbstractParticle2D, AbstractParticle3D,

    Massless, Massless2D,
    Ball, Ball2D,
    Star, Star2D,
    SPHGas, SPHGas2D,

    # Base functions
    +, -, *, /, zero, length, iterate,

    # LinearAlgebra
    norm, normalize, dot, cross,

    rotate, rotate_x, rotate_y, rotate_z,

    mean, distance,

    # Center
    min_x, min_y, min_z,
    max_x, max_y, max_z,
    center_x, center_y, center_z, center,

    # Extent
    Extent, Extent2D,
    mass_center,

    # Conversion
    npconvert,

    # Random
    rand_point2D, rand_point3D,
    randn_point2D, randn_point3D,

    assign_points,

    # Trait functions
    abstractpoint


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


"""
AbstractParticle

Top level particle type defined in PhysicalParticles.jl
"""
abstract type AbstractParticle end
abstract type AbstractParticle2D <: AbstractParticle end
abstract type AbstractParticle3D <: AbstractParticle end

@inline length(p::T) where T <: AbstractParticle = 1
@inline iterate(p::T) where T <: AbstractParticle = (p,nothing)
@inline iterate(p::T,st) where T <: AbstractParticle = nothing
@inline real(p::T) where T <: AbstractParticle = p



abstract type AbstractExtent end
abstract type AbstractExtent2D <: AbstractExtent end
abstract type AbstractExtent3D <: AbstractExtent end

### Main files

include("NonUnitVector.jl")
include("PhysicalVector.jl")
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
include("Neighbours.jl")
include("Clustering.jl")

end  # module PhysicalParticles
