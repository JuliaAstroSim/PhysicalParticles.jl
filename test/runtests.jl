using PhysicalParticles

using Test, Unitful, UnitfulAstro
using StructArrays
using StaticArrays
using BangBang
#using Documenter

include("testUnits.jl")

si()

include("testNonUnitVectors.jl")
include("testPhysicalParticles.jl")
include("testPhysicalVectors.jl")
include("testAbstractTypes.jl")
include("testPrinting.jl")

include("NumericalIntegrations.jl")

#@testset "Documentation" begin
#    doctest(PhysicalParticles, manual = false)
#    doctest(PhysicalParticles, manual = true)
#end