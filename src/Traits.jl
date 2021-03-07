@enum Collection begin
    GAS       = 1
    HALO      = 2
    DISK      = 3
    BULGE     = 4
    STAR      = 5
    BLACKHOLE = 6
end

abstract type AbstractDataDimension end
struct Physical2D <: AbstractDataDimension end
struct Physical3D <: AbstractDataDimension end
struct Unitless2D <: AbstractDataDimension end
struct Unitless3D <: AbstractDataDimension end

datadimension(p::AbstractParticle) = datadimension(p.Pos, p.Pos.x)
datadimension(p::AbstractPoint) = datadimension(p, p.x)

datadimension(::AbstractPoint2D, ::Number) = Unitless2D()
datadimension(::AbstractPoint3D, ::Number) = Unitless3D()
datadimension(::AbstractPoint2D, ::Quantity) = Physical2D()
datadimension(::AbstractPoint3D, ::Quantity) = Physical3D()

datadimension(a::Array) = datadimension(a[1])
datadimension(a::Dict) = datadimension(first(Iterators.flatten(values(a))))