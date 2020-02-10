abstract type AbstractParticleCollection end

abstract type AbstractGasCollection <: AbstractParticleCollection end

struct GAS <: AbstractGasCollection end

abstract type AbstractStarCollection <: AbstractParticleCollection end

struct HALO <: AbstractStarCollection end
struct DISK <: AbstractStarCollection end
struct BULGE <: AbstractStarCollection end
struct STAR <: AbstractStarCollection end
struct BLACKHOLE <: AbstractStarCollection end



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