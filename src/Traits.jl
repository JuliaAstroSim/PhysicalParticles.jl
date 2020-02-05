abstract type AbstractParticleType end

abstract type GadgetParticleType <: AbstractParticleType end
struct GadgetGasType <: GadgetParticleType end
struct GadgetHaloType <: GadgetParticleType end
struct GadgetDiskType <: GadgetParticleType end
struct GadgetBulgeType <: GadgetParticleType end
struct GadgetStarType <: GadgetParticleType end
struct GadgetBlackholeType <: GadgetParticleType end