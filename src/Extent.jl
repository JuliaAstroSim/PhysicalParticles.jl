mutable struct Extent2D{T<:Number} <: AbstractExtent2D{T}
    xMin::T
    xMax::T
    yMin::T
    yMax::T
    SideLength::T
    Center::PVector2D{T}
    Corner::PVector2D{T}
end

mutable struct Extent{T<:Number} <: AbstractExtent3D{T}
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
$(SIGNATURES)

Get `Extent` of an array of mathical vectors or particles, or by comparing two `Extent`s and even array of `Extent`s

## Examples

```julia
julia> p = [Ball(PVector(-1.0u"m", 1.0u"m", 1.0u"m"), PVector(u"m"), 1.0u"kg", 1),
            Ball(PVector(1.0u"m", -1.0u"m", -1.0u"m"), PVector(u"m"), 1000.0u"g", 2)]
julia> extent(p)
Extent{Quantity{Float64,𝐋,Unitful.FreeUnits{(m,),𝐋,nothing}}}(-1.0 m, 1.0 m, -1.0 m, 1.0 m, -1.0 m, 1.0 m, 2.0 m, 
  PVector{Quantity{Float64,𝐋,Unitful.FreeUnits{(m,),𝐋,nothing}}}(0.0 m, 0.0 m, 0.0 m), 
  PVector{Quantity{Float64,𝐋,Unitful.FreeUnits{(m,),𝐋,nothing}}}(-1.0 m, -1.0 m, -1.0 m))
```
"""
extent(a::Array{T, N}) where T<:Union{PVector2D, AbstractParticle2D} where N = (xMin=minimum_x(a); xMax=maximum_x(a); yMin=minimum_y(a); yMax=maximum_y(a);
                                                            len=max(xMax-xMin, yMax-yMin);
                                                            Center=PVector2D(0.5(xMax+xMin), 0.5(yMax+yMin));
                                                            Corner=PVector2D(xMin, yMin);
                                                            return Extent2D(xMin,xMax,yMin,yMax,len,Center,Corner))

extent(a::Array{T, N}) where T<:Union{PVector, AbstractParticle3D} where N = (xMin=minimum_x(a); xMax=maximum_x(a); yMin=minimum_y(a); yMax=maximum_y(a); zMin=minimum_z(a); zMax=maximum_z(a);
                                                            len=max(xMax-xMin, yMax-yMin, zMax-zMin);
                                                            Center=PVector(0.5(xMax+xMin), 0.5(yMax+yMin), 0.5(zMax+zMin));
                                                            Corner=PVector(xMin,yMin,zMin);
                                                            return Extent(xMin,xMax,yMin,yMax,zMin,zMax,len,Center,Corner))

extent(a::Extent2D, b::Extent2D) = (xMin = min(a.xMin, b.xMin); xMax = max(a.xMax, b.xMax);
                                    yMin = min(a.yMin, b.yMin); yMax = max(a.yMax, b.yMax);
                                    len=max(xMax-xMin, yMax-yMin);
                                    Center=PVector2D(0.5(xMax+xMin), 0.5(yMax+yMin));
                                    Corner=PVector2D(xMin,yMin);
                                    return Extent2D(xMin,xMax,yMin,yMax,len,Center,Corner))

extent(a::Extent, b::Extent) = (xMin = min(a.xMin, b.xMin); xMax = max(a.xMax, b.xMax);
                                    yMin = min(a.yMin, b.yMin); yMax = max(a.yMax, b.yMax);
                                    zMin = min(a.zMin, b.zMin); zMax = max(a.zMax, b.zMax);
                                    len=max(xMax-xMin, yMax-yMin, zMax-zMin);
                                    Center=PVector(0.5(xMax+xMin), 0.5(yMax+yMin), 0.5(zMax+zMin));
                                    Corner=PVector(xMin,yMin,zMin);
                                    return Extent(xMin,xMax,yMin,yMax,zMin,zMax,len,Center,Corner))


function extent(a::Array{T}) where T <: AbstractExtent
    e = a[1]
    for i in a[2:end]
        @inbounds e = extent(e, i)
    end
    return e
end