using PhysicalParticles

using Test, Unitful, UnitfulAstro

include("testUnitConstants.jl")

si()

include("testNonUnitVectors.jl")
include("testPhysicalParticles.jl")
include("testPhysicalVectors.jl")
include("testAbstractTypes.jl")
include("testPrinting.jl")