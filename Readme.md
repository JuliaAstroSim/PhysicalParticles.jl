# PhysicalParticles.jl

[![codecov](https://codecov.io/gh/JuliaAstroSim/PhysicalParticles.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/JuliaAstroSim/PhysicalParticles.jl)
[![][docs-dev-img]][docs-dev-url]

*Physical particle types for scientific simulation. Manipulate vectors as simple as numbers!*

## Installation

```julia
]add PhysicalParticles
```

or

```julia
using Pkg; Pkg.add("PhysicalParticles")
```

or

```julia
using Pkg; Pkg.add("https://github.com/JuliaAstroSim/PhysicalParticles.jl")
```

To test the Package:
```julia
]test PhysicalParticles
```

## Documentation

- [**Dev**][docs-dev-url] &mdash; *documentation of the in-development version.*

[docs-dev-img]: https://img.shields.io/badge/docs-dev-blue.svg
[docs-dev-url]: https://juliaastrosim.github.io/PhysicalParticles.jl/dev

## Package ecosystem

- Basic data structure: [PhysicalParticles.jl](https://github.com/JuliaAstroSim/PhysicalParticles.jl)
- File I/O: [AstroIO.jl](https://github.com/JuliaAstroSim/AstroIO.jl)
- Initial Condition: [AstroIC.jl](https://github.com/JuliaAstroSim/AstroIC.jl)
- Parallelism: [ParallelOperations.jl](https://github.com/JuliaAstroSim/ParallelOperations.jl)
- Trees: [PhysicalTrees.jl](https://github.com/JuliaAstroSim/PhysicalTrees.jl)
- Meshes: [PhysicalMeshes.jl](https://github.com/JuliaAstroSim/PhysicalMeshes.jl)
- Plotting: [AstroPlot.jl](https://github.com/JuliaAstroSim/AstroPlot.jl)
- Simulation: [ISLENT](https://github.com/JuliaAstroSim/ISLENT)