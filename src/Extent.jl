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
function extent(a::Array{T, N}) where T<:Union{PVector2D, AbstractParticle2D} where N
    if isempty(a)
        return nothing
    end

    xMin=minimum_x(a); xMax=maximum_x(a); yMin=minimum_y(a); yMax=maximum_y(a);
    len=max(xMax-xMin, yMax-yMin);
    Center=PVector2D(0.5(xMax+xMin), 0.5(yMax+yMin));
    Corner=PVector2D(xMin, yMin);

    return Extent2D(xMin,xMax,yMin,yMax,len,Center,Corner)
end

function extent(a::Array{T, N}) where T<:Union{PVector, AbstractParticle3D} where N
    if isempty(a)
        return nothing
    end

    xMin=minimum_x(a); xMax=maximum_x(a); yMin=minimum_y(a); yMax=maximum_y(a); zMin=minimum_z(a); zMax=maximum_z(a);
    len=max(xMax-xMin, yMax-yMin, zMax-zMin);
    Center=PVector(0.5(xMax+xMin), 0.5(yMax+yMin), 0.5(zMax+zMin));
    Corner=PVector(xMin,yMin,zMin);

    return Extent(xMin,xMax,yMin,yMax,zMin,zMax,len,Center,Corner)
end

function extent(a::Extent2D, b::Extent2D)
    xMin = min(a.xMin, b.xMin); xMax = max(a.xMax, b.xMax);
    yMin = min(a.yMin, b.yMin); yMax = max(a.yMax, b.yMax);
    len=max(xMax-xMin, yMax-yMin);
    Center=PVector2D(0.5(xMax+xMin), 0.5(yMax+yMin));
    Corner=PVector2D(xMin,yMin);
    return Extent2D(xMin,xMax,yMin,yMax,len,Center,Corner)
end

function extent(a::Extent, b::Extent)
    xMin = min(a.xMin, b.xMin); xMax = max(a.xMax, b.xMax);
    yMin = min(a.yMin, b.yMin); yMax = max(a.yMax, b.yMax);
    zMin = min(a.zMin, b.zMin); zMax = max(a.zMax, b.zMax);
    len=max(xMax-xMin, yMax-yMin, zMax-zMin);
    Center=PVector(0.5(xMax+xMin), 0.5(yMax+yMin), 0.5(zMax+zMin));
    Corner=PVector(xMin,yMin,zMin);
    return Extent(xMin,xMax,yMin,yMax,zMin,zMax,len,Center,Corner)
end

extent(e::AbstractExtent, ::Nothing) = e
extent(::Nothing, e::AbstractExtent) = e
extent(::Nothing, ::Nothing) = nothing

function extent(a::Array{T}) where T <: AbstractExtent
    e = a[1]
    for i in a[2:end]
        @inbounds e = extent(e, i)
    end
    return e
end

function extent(data::Dict)
    key = collect(keys(data))
    e = extent(data[key[1]])
    for k in key[2:end]
        @inbounds e = extent(e, extent(data[k]))
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