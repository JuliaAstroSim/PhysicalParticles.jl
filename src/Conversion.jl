# Conversions from and to array, conversions between inner types


"""
function npconvert(a::Array{T,1}) where T<:Union{Number, Quantity}

convert two-element array to PVector2D, and three-element array to PVector

## Examples

```julia
julia> npconvert([1.0, 2.0])
PVector2D{Float64}(1.0, 2.0)

julia> npconvert([1.0, 2.0, 3.0])
PVector{Float64}(1.0, 2.0, 3.0)

julia> npconvert([1.0, 2.0, 3.0, 4.0])
ERROR: Not supported dimension!
```
"""
function npconvert(a::Array{T,1}) where T<:Union{Number, Quantity}
    if length(a) == 3
        return PVector(a[1], a[2], a[3])
    elseif length(a) == 2
        return PVector2D(a[1], a[2])
    else
        error("Not supported dimension!")
    end
end

"""
function npconvert(a::Array{T,2}) where T<:Union{Number, Quantity}

convert 2xN Array to Array{PVector2D,1}, 3xN Array to Array{PVector,1}

## Examples

```julia
julia> a = npconvert([1.0 3.0; 
                      2.0 4.0])
2-element Array{PVector2D,1}:
 PVector2D{Float64}(1.0, 2.0)
 PVector2D{Float64}(3.0, 4.0)

julia> npconvert([1.0 4.0;
                  2.0 5.0;
                  3.0 6.0])
2-element Array{PVector,1}:
 PVector{Float64}(1.0, 2.0, 3.0)
 PVector{Float64}(4.0, 5.0, 6.0)

julia> npconvert([1.0; 2.0; 3.0; 4.0])
ERROR: Not supported dimension!
```
"""
function npconvert(a::Array{T,2}) where T<:Union{Number, Quantity}
    row, col = size(a)
    if row == 3
        p = rand(PVector,0)
        for i in 1:col
            @inbounds append!(p, PVector(a[1,i], a[2,i], a[3,i]))
        end
        return p
    elseif row == 2
        p = rand(PVector2D,0)
        for i in 1:col
            @inbounds append!(p, PVector2D(a[1,i], a[2,i]))
        end
        return p
    else
        error("Not supported dimension!")
    end
end