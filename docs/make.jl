"""
Compile with:
julia --project=docs/ --color=yes docs/make.jl

Generate key:
DocumenterTools.genkeys(user="JuliaAstroSim", repo="git@github.com:JuliaAstroSim/PhysicalParticles.jl.git")
"""

using Documenter

using PhysicalParticles

# The DOCSARGS environment variable can be used to pass additional arguments to make.jl.
# This is useful on CI, if you need to change the behavior of the build slightly but you
# can not change the .travis.yml or make.jl scripts any more (e.g. for a tag build).
if haskey(ENV, "DOCSARGS")
    for arg in split(ENV["DOCSARGS"])
        (arg in ARGS) || push!(ARGS, arg)
    end
end

makedocs(
    modules = [PhysicalParticles],
    format = Documenter.HTML(
        # Use clean URLs, unless built as a "local" build
        prettyurls = !("local" in ARGS),
        canonical = "https://juliaastrosims.github.io/PhysicalParticles.jl/dev/",
        assets = ["assets/alpha_small.ico"],
        analytics = "UA-153693590-1",
        highlights = ["llvm", "yaml"],
    ),
    clean = false,
    sitename = "PhysicalParticles.jl",
    authors = "islent",
    linkcheck = !("skiplinks" in ARGS),
    pages = [
        "Home" => "index.md",
        "Manual" => Any[
            "manual/guide.md",
            "manual/PVector.md",
            "manual/Conversion.md",
            "manual/Units.md",
            "manual/Random.md",
            "manual/Extent.md",
            "manual/Neighbors.md",
            "manual/Clustering.md",
        ],
        "Library" => Any[
            "lib/Types.md",
            "lib/Methods.md",
        ],
        #"contributing.md",
    ],
    #strict = !("strict=false" in ARGS),
    #doctest = ("doctest=only" in ARGS) ? :only : true,
)

deploydocs(
    repo = "github.com/JuliaAstroSim/PhysicalParticles.jl.git",
    target = "build",
)