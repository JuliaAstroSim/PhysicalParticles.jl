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

"""
    AbstractPoint

It is named to distinguish from the built-in type `AbstractVector`
"""
abstract type AbstractPoint end
abstract type AbstractPoint2D <: AbstractPoint end
abstract type AbstractPoint3D <: AbstractPoint end

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
    - Neighbours.jl ==> Nearest neighbour searching
    - Clustering.jl ==> Cluster center and clustering patterns, use kdtree methods in Neighbours
    - Conversion.jl ==> Conversion from and to array, conversion between inner types
    - LinearAlgebra.jl ==> General linear algebra methods
"""

include("Neighbours.jl")
include("Clustering.jl")

end  # module PhysicalParticles
