"""
    Point2D(x::Float64, y::Float64)

Non-unit 2D vector

# Fields

x::Float64
y::Float64

# Examples

```julia
julia> p = Point2D(1.0, 2.0)
Point2D(1.0, 2.0)
```
"""
struct Point2D <: AbstractPoint2D
    x::Float64
    y::Float64
    Point2D(x::Float64,y::Float64) = new(x, y)
end