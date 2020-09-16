# Random

Usage of random point generators is straightforward:
```@repl
using PhysicalParticles
p = rand_pvector(3)
pu = rand_pvector(3, u"m")
```

Here is the list of supported generators:
```julia
rand_pvector(n::Integer)
rand_pvector(n::Integer, T::DataType)
rand_pvector(n::Integer, u::Unitful.Units)
rand_pvector(n::Integer, u::Unitful.Units, T::DataType)

rand_pvector2d(n::Integer)
rand_pvector2d(n::Integer, T::DataType)
rand_pvector2d(n::Integer, u::Unitful.Units)
rand_pvector2d(n::Integer, u::Unitful.Units, T::DataType)
```