mutable struct Extent2D <: AbstractExtent2D
    xMin::Float64
    xMax::Float64
    yMin::Float64
    yMax::Float64
    SideLength::Float64
    Center::Point2D
    Corner::Point2D
end

mutable struct Extent3D <: AbstractExtent3D
    xMin::Float64
    xMax::Float64
    yMin::Float64
    yMax::Float64
    zMin::Float64
    zMax::Float64
    SideLength::Float64
    Center::Point3D
    Corner::Point3D
end

Extent(a::Array{Point2D}) = (xMin=min_x(a); xMax=max_x(a); yMin=min_y(a); yMax=max_y(a);
                              len=max(xMax-xMin, yMax-yMin);
                              Center=Point2D(0.5(xMax+xMin), 0.5(yMax+yMin));
                              Corner=Point2D(xMin, yMin);
                              return Extent2D(xMin,xMax,yMin,yMax,len,Center,Corner))

Extent(a::Array{Point3D}) = (xMin=min_x(a); xMax=max_x(a); yMin=min_y(a); yMax=max_y(a); zMin=min_z(a); zMax=max_z(a);
                              len=max(xMax-xMin, yMax-yMin, zMax-zMin);
                              Center=Point3D(0.5(xMax+xMin), 0.5(yMax+yMin), 0.5(zMax+zMin));
                              Corner=Point3D(xMin,yMin,zMin);
                              return Extent3D(xMin,xMax,yMin,yMax,zMin,zMax,len,Center,Corner))

mutable struct PhysicalExtent2D <: AbstractExtent2D
    xMin::Quantity
    xMax::Quantity
    yMin::Quantity
    yMax::Quantity
    SideLength::Quantity
    Center::PhysicalVector2D
    Corner::PhysicalVector2D
end

mutable struct PhysicalExtent3D <: AbstractExtent3D
    xMin::Quantity
    xMax::Quantity
    yMin::Quantity
    yMax::Quantity
    zMin::Quantity
    zMax::Quantity
    SideLength::Quantity
    Center::PhysicalVector3D
    Corner::PhysicalVector3D
end

PhysicalExtent(a::Array{PhysicalVector2D}) = (xMin=min_x(a); xMax=max_x(a); yMin=min_y(a); yMax=max_y(a);
                                              len=max(xMax-xMin, yMax-yMin);
                                              Center=PhysicalVector2D(0.5(xMax+xMin), 0.5(yMax+yMin));
                                              Corner=PhysicalVector2D(xMin,yMin);
                                              return PhysicalExtent2D(xMin,xMax,yMin,yMax,len,Center,Corner))

PhysicalExtent(a::Array{PhysicalVector3D}) = (xMin=min_x(a); xMax=max_x(a); yMin=min_y(a); yMax=max_y(a); zMin=min_z(a); zMax=max_z(a);
                                              len=max(xMax-xMin, yMax-yMin, zMax-zMin);
                                              Center=PhysicalVector3D(0.5(xMax+xMin), 0.5(yMax+yMin), 0.5(zMax+zMin));
                                              Corner=PhysicalVector3D(xMin,yMin,zMin);
                                              return PhysicalExtent3D(xMin,xMax,yMin,yMax,zMin,zMax,len,Center,Corner))


Extent(a::Extent2D, b::Extent2D) = (xMin = min(a.xMin, b.xMin); xMax = max(a.xMax, b.xMax);
                                    yMin = min(a.yMin, b.yMin); yMax = max(a.yMax, b.yMax);
                                    len=max(xMax-xMin, yMax-yMin);
                                    Center=Point2D(0.5(xMax+xMin), 0.5(yMax+yMin));
                                    Corner=Point2D(xMin,yMin);
                                    return Extent2D(xMin,xMax,yMin,yMax,len,Center,Corner))

Extent(a::Extent3D, b::Extent3D) = (xMin = min(a.xMin, b.xMin); xMax = max(a.xMax, b.xMax);
                                    yMin = min(a.yMin, b.yMin); yMax = max(a.yMax, b.yMax);
                                    zMin = min(a.zMin, b.zMin); zMax = max(a.zMax, b.zMax);
                                    len=max(xMax-xMin, yMax-yMin, zMax-zMin);
                                    Center=Point3D(0.5(xMax+xMin), 0.5(yMax+yMin), 0.5(zMax+zMin));
                                    Corner=Point3D(xMin,yMin,zMin);
                                    return Extent3D(xMin,xMax,yMin,yMax,zMin,zMax,len,Center))

PhysicalExtent(a::PhysicalExtent2D, b::PhysicalExtent2D) = (xMin = min(a.xMin, b.xMin); xMax = max(a.xMax, b.xMax);
                                                            yMin = min(a.yMin, b.yMin); yMax = max(a.yMax, b.yMax);
                                                            len=max(xMax-xMin, yMax-yMin);
                                                            Center=PhysicalVector2D(0.5(xMax+xMin), 0.5(yMax+yMin));
                                                            Corner=PhysicalVector2D(xMin,yMin);
                                                            return PhysicalExtent2D(xMin,xMax,yMin,yMax,len,Center,Corner))

PhysicalExtent(a::PhysicalExtent3D, b::PhysicalExtent3D) = (xMin = min(a.xMin, b.xMin); xMax = max(a.xMax, b.xMax);
                                                            yMin = min(a.yMin, b.yMin); yMax = max(a.yMax, b.yMax);
                                                            zMin = min(a.zMin, b.zMin); zMax = max(a.zMax, b.zMax);
                                                            len=max(xMax-xMin, yMax-yMin, zMax-zMin);
                                                            Center=PhysicalVector3D(0.5(xMax+xMin), 0.5(yMax+yMin), 0.5(zMax+zMin));
                                                            Corner=PhysicalVector3D(xMin,yMin,zMin);
                                                            return PhysicalExtent3D(xMin,xMax,yMin,yMax,zMin,zMax,len,Center,Corner))

Extent(a::PhysicalExtent2D, b::PhysicalExtent2D) = (xMin = min(a.xMin, b.xMin); xMax = max(a.xMax, b.xMax);
                                                    yMin = min(a.yMin, b.yMin); yMax = max(a.yMax, b.yMax);
                                                    len=max(xMax-xMin, yMax-yMin);
                                                    Center=PhysicalVector2D(0.5(xMax+xMin), 0.5(yMax+yMin));
                                                    Corner=PhysicalVector2D(xMin,yMin);
                                                    return PhysicalExtent2D(xMin,xMax,yMin,yMax,len,Center,Corner))

Extent(a::PhysicalExtent3D, b::PhysicalExtent3D) = (xMin = min(a.xMin, b.xMin); xMax = max(a.xMax, b.xMax);
                                                    yMin = min(a.yMin, b.yMin); yMax = max(a.yMax, b.yMax);
                                                    zMin = min(a.zMin, b.zMin); zMax = max(a.zMax, b.zMax);
                                                    len=max(xMax-xMin, yMax-yMin, zMax-zMin);
                                                    Center=PhysicalVector3D(0.5(xMax+xMin), 0.5(yMax+yMin), 0.5(zMax+zMin));
                                                    Corner=PhysicalVector3D(xMin,yMin,zMin);
                                                    return PhysicalExtent3D(xMin,xMax,yMin,yMax,zMin,zMax,len,Center,Corner))

function Extent(a::Array{T}) where T <: AbstractExtent
    extent = a[1]
    for i in 2:length(a)
        @inbounds extent = Extent(extent, a[i])
    end
    return extent
end

function PhysicalExtent(a::Array{T}) where T <: AbstractExtent
    extent = a[1]
    for i in 2:length(a)
        @inbounds extent = Extent(extent, a[i])
    end
    return extent
end
#####  Mass center  #####

function mass_center(a::Array{T}) where T <: AbstractParticle
    if length(a) == 1
        return a.Pos
    end
    sum_mass = a[1].Mass
    sum_center = a[1].Pos * a[1].Mass
    for i in 2:length(a)
        sum_mass += a[i].Mass
        sum_center += a[i].Pos * a[i].Mass
    end

    return sum_center/sum_mass
end
