module PhysicalParticles

using Unitful, UnitfulAstro, PhysicalConstants

## Explicitly overload functions and import types
import Unitful: Units

import Base: +,-,*,/,zero,length,iterate,to_index, rand

import LinearAlgebra: norm, normalize, dot, cross

import Statistics: mean, std, var

import PhysicalConstants: CODATA2018, @constant

export
    AbstractNonUnitVector,
        AbstractNonUnitVector2D, AbstractNonUnitVector3D,

    Point, Point2D, Point3D,

    # Base functions
    +, -, *, /, zero, length, iterate,

    # LinearAlgebra
    norm, normalize, dot, cross,

    rotate, rotate_x, rotate_y, rotate_z


## Include files

### Top level data structure

"""
    AbstractPoint

It is named to distinguish from the built-in type `AbstractVector`
"""
abstract type AbstractPoint{T} end
abstract type AbstractPoint2D{T} <: AbstractPoint{T} end
abstract type AbstractPoint3D{T} <: AbstractPoint{T} end

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
    - Conversion.jl ==> Conversion from and to array, conversion between inner types
    - LinearAlgebra.jl ==> General linear algebra methods
    - Neighbours.jl ==> Nearest neighbour searching
    - Clustering.jl ==> Cluster center and clustering patterns, use kdtree methods in Neighbours
"""

include("Conversion.jl")
include("LinearAlgebra.jl")
include("Neighbours.jl")
include("Clustering.jl")

end  # module PhysicalParticles
