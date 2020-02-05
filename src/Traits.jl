abstract type AbstractParticleType end

abstract type AbstractGasType <: AbstractParticleType end

struct GAS <: AbstractGasType end

abstract type AbstractStarType <: AbstractParticleType end

struct HALO <: AbstractStarType end
struct DISK <: AbstractStarType end
struct BULGE <: AbstractStarType end
struct STAR <: AbstractStarType end
struct BLACKHOLE <: AbstractStarType end