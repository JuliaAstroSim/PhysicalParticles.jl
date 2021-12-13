# Random

Usage of random point generators is straightforward:
```@repl
using PhysicalParticles
rand(PVector{Float64}, 3, 3)
rand(PVector2D{Int}, 3)
p = randn_pvector(3)
pu = randn_pvector(3, u"m")
```

To generate vectors in normal distribution:
```julia
randn_pvector(n::Integer)
randn_pvector(n::Integer, T::DataType)
randn_pvector(n::Integer, u::Unitful.Units)
randn_pvector(n::Integer, u::Unitful.Units, T::DataType)

randn_pvector2d(n::Integer)
randn_pvector2d(n::Integer, T::DataType)
randn_pvector2d(n::Integer, u::Unitful.Units)
randn_pvector2d(n::Integer, u::Unitful.Units, T::DataType)
```