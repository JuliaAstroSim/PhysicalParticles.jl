"""
    struct Extent2D{T<:Number} <: AbstractExtent2D{T}

Could be constructed by function [`extent`](@ref)

## Fields
- xMin::T
- xMax::T
- yMin::T
- yMax::T
- SideLength::T
- Center::PVector2D{T}
- Corner::PVector2D{T} : PVector2D(xMin, yMin)
"""
struct Extent2D{T<:Number} <: AbstractExtent2D{T}
    xMin::T
    xMax::T
    yMin::T
    yMax::T
    SideLength::T
    Center::PVector2D{T}
    Corner::PVector2D{T}
end

"""
    struct Extent{T<:Number} <: AbstractExtent3D{T}

Could be constructed by function [`extent`](@ref)

## Fields
- xMin::T
- xMax::T
- yMin::T
- yMax::T
- zMin::T
- zMax::T
- SideLength::T
- Center::PVector{T}
- Corner::PVector{T} :  PVector(xMin, yMin, zMin)
"""
struct Extent{T<:Number} <: AbstractExtent3D{T}
    xMin::T
    xMax::T
    yMin::T
    yMax::T
    zMin::T
    zMax::T
    SideLength::T
    Center::PVector{T}
    Corner::PVector{T}
end

"""
    extent(a::Array{T, N})
    extent(data::Dict)
    extent(a::Extent2D, b::Extent2D)
    extent(a::Extent, b::Extent)

Get `Extent` of an array of mathical vectors or particles, or by comparing two `Extent`s and even array of `Extent`s

## Examples

```jl
julia> extent([Ball(PVector(-1.0u"m", 1.0u"m", 1.0u"m"), PVector(u"m/s"), PVector(u"m/s^2"), 1.0u"kg", 1),
               Ball(PVector(1.0u"m", -1.0u"m", -1.0u"m"), PVector(u"m/s"), PVector(u"m/s^2"), 1000.0u"g", 2)])
Extent: xMin = -1.0 m, xMax = 1.0 m, yMin = -1.0 m, yMax = 1.0 m, zMin = -1.0 m, zMax = 1.0 m, SideLength = 2.0 m, Center = PVector(0.0 m, 0.0 m, 0.0 m)
```
"""
function extent(a::Union{Array{T, N}, StructArray{T,N,NT,Tu}}) where T<:Union{PVector2D, AbstractParticle2D} where N where NT where Tu
    if isempty(a)
        return nothing
    end

    xMin=minimum_x(a); xMax=maximum_x(a); yMin=minimum_y(a); yMax=maximum_y(a);
    len=max(xMax-xMin, yMax-yMin);
    Center=PVector2D((xMax+xMin)/2, (yMax+yMin)/2);
    Corner=PVector2D(xMin, yMin);

    return Extent2D(xMin,xMax,yMin,yMax,len,Center,Corner)
end

function extent(a::Union{Array{T, N}, StructArray{T,N,NT,Tu}}) where T<:Union{PVector, AbstractParticle3D} where N where NT where Tu
    if isempty(a)
        return nothing
    end

    xMin=minimum_x(a); xMax=maximum_x(a); yMin=minimum_y(a); yMax=maximum_y(a); zMin=minimum_z(a); zMax=maximum_z(a);
    len=max(xMax-xMin, yMax-yMin, zMax-zMin);
    Center=PVector((xMax+xMin)/2, (yMax+yMin)/2, (zMax+zMin)/2);
    Corner=PVector(xMin,yMin,zMin);

    return Extent(xMin,xMax,yMin,yMax,zMin,zMax,len,Center,Corner)
end

function extent(a::Extent2D, b::Extent2D)
    xMin = min(a.xMin, b.xMin); xMax = max(a.xMax, b.xMax);
    yMin = min(a.yMin, b.yMin); yMax = max(a.yMax, b.yMax);
    len=max(xMax-xMin, yMax-yMin);
    Center=PVector2D((xMax+xMin)/2, (yMax+yMin))/2;
    Corner=PVector2D(xMin,yMin);
    return Extent2D(xMin,xMax,yMin,yMax,len,Center,Corner)
end

function extent(a::Extent, b::Extent)
    xMin = min(a.xMin, b.xMin); xMax = max(a.xMax, b.xMax);
    yMin = min(a.yMin, b.yMin); yMax = max(a.yMax, b.yMax);
    zMin = min(a.zMin, b.zMin); zMax = max(a.zMax, b.zMax);
    len=max(xMax-xMin, yMax-yMin, zMax-zMin);
    Center=PVector((xMax+xMin)/2, (yMax+yMin)/2, (zMax+zMin))/2;
    Corner=PVector(xMin,yMin,zMin);
    return Extent(xMin,xMax,yMin,yMax,zMin,zMax,len,Center,Corner)
end

function extent(a::Array{T,2}) where T<:Number
    if size(a)[2] == 2
        xMax, yMax = maximum(a, dims = 1)
        xMin, yMin = minimum(a, dims = 1)
        len=max(xMax-xMin, yMax-yMin);
        Center=PVector2D((xMax+xMin)/2, (yMax+yMin))/2;
        Corner=PVector2D(xMin,yMin);
        return Extent2D(xMin,xMax,yMin,yMax,len,Center,Corner)
    elseif size(a)[2] == 3
        xMax, yMax, zMax = maximum(a, dims = 1)
        xMin, yMin, zMin = minimum(a, dims = 1)
        len=max(xMax-xMin, yMax-yMin, zMax-zMin);
        Center=PVector((xMax+xMin)/2, (yMax+yMin)/2, (zMax+zMin))/2;
        Corner=PVector(xMin,yMin,zMin);
        return Extent(xMin,xMax,yMin,yMax,zMin,zMax,len,Center,Corner)
    else
        error("Only 2D or 3D packed position array is supported")
    end
end

extent(e::AbstractExtent, ::Nothing) = e
extent(::Nothing, e::AbstractExtent) = e
extent(::Nothing, ::Nothing) = nothing

*(e::Extent2D, x::Real) = Extent2D(e.xMin*x,e.xMax*x,e.yMin*x,e.yMax*x,e.SideLength*x,e.Center*x,e.Corner*x)
*(e::Extent, x::Real) = Extent(e.xMin*x,e.xMax*x,e.yMin*x,e.yMax*x,e.zMin*x,e.zMax*x,e.SideLength*x,e.Center*x,e.Corner*x)
*(x::Real, e::AbstractExtent) = *(e, x)

function extent(a::Array{T}) where T <: AbstractExtent
    e = a[1]
    for i in a[2:end]
        @inbounds e = extent(e, i)
    end
    return e
end

"""
    function volume(e::Extent)

Compute the volume of `Extent` box:
V = (e.xMax - e.xMin) * (e.yMax - e.yMin) * (e.zMax - e.zMin)
"""
function volume(e::Extent)
    return (e.xMax - e.xMin) * (e.yMax - e.yMin) * (e.zMax - e.zMin)
end

"""
    function area(e::Extent2D)

Compute area of `Extent2D`:
A = (e.xMax - e.xMin) * (e.yMax - e.yMin)
"""
function area(e::Extent2D)
    return (e.xMax - e.xMin) * (e.yMax - e.yMin)
end