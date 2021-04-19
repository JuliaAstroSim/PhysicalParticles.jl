include("StructArrays.jl")

using Makie
using Unitful, UnitfulAstro

using PhysicalParticles

function benchmark(funcs::Array, data;
        title = "",
        resolution = (1600, 900),
    kw...)
    scene, layout = layoutscene(;resolution)
    ax = layout[1,1] = Axis(
        scene; title
    )

    legend = layout[1,2] = Legend(scene, p, string.(funcs))

    return scene, layout
end