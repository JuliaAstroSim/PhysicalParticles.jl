# Conversions from and to array, conversions between inner types


"""
function npconvert(a::Array{T,1}) where T<:AbstractFloat

convert two-element array to Point2D, and three-element array to Point3D

## Examples

```julia
julia> npconvert([1.0, 2.0])
Point2D{Float64}(1.0, 2.0)

julia> npconvert([1.0, 2.0, 3.0])
Point3D{Float64}(1.0, 2.0, 3.0)

julia> npconvert([1.0, 2.0, 3.0, 4.0])
ERROR: Not supported dimension!
```
"""
function npconvert(a::Array{T,1}) where T<:AbstractFloat
    if length(a) == 3
        return Point3D(a[1], a[2], a[3])
    elseif length(a) == 2
        return Point2D(a[1], a[2])
    else
        error("Not supported dimension!")
    end
end

"""
function npconvert(a::Array{T,2}) where T<:AbstractFloat

convert 2xN Array to Array{Point2D,1}, 3xN Array to Array{Point3D,1}

## Examples

```julia
julia> a = npconvert([1.0 3.0; 
                      2.0 4.0])
2-element Array{Point2D,1}:
 Point2D{Float64}(1.0, 2.0)
 Point2D{Float64}(3.0, 4.0)

julia> npconvert([1.0 4.0;
                  2.0 5.0;
                  3.0 6.0])
2-element Array{Point3D,1}:
 Point3D{Float64}(1.0, 2.0, 3.0)
 Point3D{Float64}(4.0, 5.0, 6.0)

julia> npconvert([1.0; 2.0; 3.0; 4.0])
ERROR: Not supported dimension!
```
"""
function npconvert(a::Array{T,2}) where T<:AbstractFloat
    row, col = size(a)
    if row == 3
        p = rand(Point3D,0)
        for i in 1:col
            @inbounds append!(p, Point3D(a[1,i], a[2,i], a[3,i]))
        end
        return p
    elseif row == 2
        p = rand(Point2D,0)
        for i in 1:col
            @inbounds append!(p, Point2D(a[1,i], a[2,i]))
        end
        return p
    else
        error("Not supported dimension!")
    end
end

## Point2D



## Point3D



## PhysicalVector2D



## PhysicalVector3D