"""
$(SIGNATURES)

Generate uniformly distributed PVectors

## Examples

```julia
julia> p = rand_pvector(5)
julia> pu = rand_pvector2d(5, u"m")
```
"""
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


"""
$(SIGNATURES)

Generate uniformly distributed PVectors

## Examples

```julia
julia> p = randn_pvector(5)
julia> pu = randn_pvector2d(5, u"m")
```
"""
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