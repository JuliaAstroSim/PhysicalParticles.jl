using PhysicalParticles

using Test, Unitful, UnitfulAstro
using Setfield

include("testUnits.jl")

si()

include("testNonUnitVectors.jl")
include("testPhysicalParticles.jl")
include("testPhysicalVectors.jl")
include("testAbstractTypes.jl")
include("testPrinting.jl")