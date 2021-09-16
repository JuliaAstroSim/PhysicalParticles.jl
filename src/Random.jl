"""
    rand_pvector2d(n::Integer, T::DataType = Float64)
    rand_pvector2d(n::Integer, u::Units, T::DataType = Float64)
    rand_pvector(n::Integer, T::DataType = Float64)
    rand_pvector(n::Integer, u::Units, T::DataType = Float64)

Generate uniformly distributed PVectors

## Examples

```julia
julia> p = rand_pvector(5)
julia> pu = rand_pvector2d(5, u"m")
```
"""
rand_pvector2d, rand_pvector

function rand_pvector2d(n::Integer, T::DataType = Float64)
    return [pconvert(rand(T,2)) for i=1:n]
end

function rand_pvector(n::Integer, T::DataType = Float64)
    return [pconvert(rand(T,3)) for i=1:n]
end

function rand_pvector2d(n::Integer, u::Units, T::DataType = Float64)
    return [pconvert(rand(T,2) * u) for i=1:n]
end

function rand_pvector(n::Integer, u::Units, T::DataType = Float64)
    return [pconvert(rand(T,3) * u) for i=1:n]
end

#Random.rand(rng::Random.AbstractRNG, ::Random.SamplerType{PVector2D{T}}) where T = PVector2D(rand(rng, T))

"""
    randn_pvector2d(n::Integer, T::DataType = Float64)
    randn_pvector2d(n::Integer, u::Units, T::DataType = Float64)
    randn_pvector(n::Integer, T::DataType = Float64)
    randn_pvector(n::Integer, u::Units, T::DataType = Float64)

Generate uniformly distributed PVectors

## Examples

```julia
julia> p = randn_pvector(5)
julia> pu = randn_pvector2d(5, u"m")
```
"""
randn_pvector2d, randn_pvector

function randn_pvector2d(n::Integer, T::DataType = Float64)
    return [pconvert(randn(T,2)) for i=1:n]
end

function randn_pvector(n::Integer, T::DataType = Float64)
    return [pconvert(randn(T,3)) for i=1:n]
end

function randn_pvector2d(n::Integer, u::Units, T::DataType = Float64)
    return [pconvert(randn(T,2) * u) for i=1:n]
end

function randn_pvector(n::Integer, u::Units, T::DataType = Float64)
    return [pconvert(randn(T,3) * u) for i=1:n]
end