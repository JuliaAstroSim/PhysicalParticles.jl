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

    Point2D


## Include files

### Top level data structure

abstract type AbstractNonUnitVector end
abstract type AbstractNonUnitVector2D <: AbstractNonUnitVector end
abstract type AbstractNonUnitVector3D <: AbstractNonUnitVector end

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
    - Linear Algebra
        - norm, normalize
        - rotate
    - Conversion from and to array

Other operations would be implemented in seperate files:
    - Neighbours.jl ==> Nearest neighbour searching
    - Clustering.jl ==> Cluster center and clustering patterns, use kdtree methods in Neighbours
"""

include("Neighbours.jl")
include("Clustering.jl")

end  # module PhysicalParticles
