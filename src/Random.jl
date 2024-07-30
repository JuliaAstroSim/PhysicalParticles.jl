Random.rand(rng::AbstractRNG, ::Random.SamplerType{PVector2D{T}}) where T = PVector2D(rand(rng,T), rand(rng,T))
Random.rand(rng::AbstractRNG, ::Random.SamplerType{PVector{T}}) where T = PVector(rand(rng,T), rand(rng,T), rand(rng,T))
Random.randn(rng::AbstractRNG, ::Type{PVector2D{T}}) where T = PVector2D(randn(rng,T), randn(rng,T))
Random.randn(rng::AbstractRNG, ::Type{PVector{T}}) where T = PVector(randn(rng,T), randn(rng,T), randn(rng,T))

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