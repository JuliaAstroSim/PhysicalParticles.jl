# Predefined particle types

## Non-unit particles

mutable struct Massless2D <: AbstractParticle2D
    Pos::Point2D
    Vel::Point2D
    ID::Integer
end
Massless2D() = Massless2D(Point2D(), Point2D(), 0)

mutable struct Massless <: AbstractParticle3D
    Pos::Point3D
    Vel::Point3D
    ID::Integer
end
Massless() = Massless(Point3D(), Point3D(), 0)

## Physical particles

mutable struct Ball2D <: AbstractParticle2D
    Pos::PhysicalVector2D
    Vel::PhysicalVector2D
    Mass::Quantity
    ID::Integer
end
Ball2D() = Ball2D(PhysicalVector2D(u"m"), PhysicalVector2D(u"m/s"), 0.0u"kg", 0)

mutable struct Ball <: AbstractParticle3D
    Pos::PhysicalVector3D
    Vel::PhysicalVector3D
    Mass::Quantity
    ID::Integer
end
Ball() = Ball(PhysicalVector3D(u"m"), PhysicalVector3D(u"m/s"), 0.0u"kg", 0)

## Astrophysical particles

mutable struct Star2D <: AbstractParticle2D
    Pos:::PhysicalVector2D
    Vel::PhysicalVector2D
    Acc::PhysicalVector2D
    Mass::Quantity
    ID::Integer

    Ti_endstep::Integer
    Ti_begstep::Integer
    GravCost::AbstractFloat

    Potential::Quantity
    OldAcc::Quantity
end
Star2D() = Star2D(
    PhysicalVector2D(u"kpc"), PhysicalVector2D(u"kpc/Gyr"), PhysicalVector2D(u"kpc/Gyr^2"), 0.0u"Msun", 0,
    0, 0, 0.0,
    0.0u"J", 0.0u"kpc/Gyr^2"
)

mutable struct Star <: AbstractParticle3D
    Pos:::PhysicalVector3D
    Vel::PhysicalVector3D
    Acc::PhysicalVector3D
    Mass::Quantity
    ID::Integer

    Ti_endstep::Integer
    Ti_begstep::Integer
    GravCost::AbstractFloat

    Potential::Quantity
    OldAcc::Quantity
end
Star() = Star(
    PhysicalVector3D(u"kpc"), PhysicalVector3D(u"kpc/Gyr"), PhysicalVector3D(u"kpc/Gyr^2"), 0.0u"Msun", 0,
    0, 0, 0.0,
    0.0u"J", 0.0u"kpc/Gyr^2"
)

mutable struct SPHGas2D <: AbstractParticle2D
    Pos:::PhysicalVector2D
    Vel::PhysicalVector2D
    Acc::PhysicalVector2D
    Mass::Quantity
    ID::Integer

    Ti_endstep::Integer
    Ti_begstep::Integer
    GravCost::AbstractFloat

    Potential::Quantity
    OldAcc::Quantity

    # SPH
    Entropy::Quantity
    Density::Quantity
    Hsml::Quantity

    Left::AbstractFloat
    Right::AbstractFloat
    NumNgbFound::Integer

    RotVel::PhysicalVector2D
    DivVel::Quantity
    CurlVel::Quantity
    dHsmlRho::AbstractFloat

    Pressure::Quantity
    DtEntropy::Quantity
    MaxSignalVel::Quantity
end
SPHGas2D() = SPHGas2D(
    PhysicalVector2D(u"kpc"), PhysicalVector2D(u"kpc/Gyr"), PhysicalVector2D(u"kpc/Gyr^2"), 0.0u"Msun", 0,
    0, 0, 0.0,
    0.0u"J", 0.0u"kpc/Gyr^2",

    0.0u"J/K", 0.0u"Msun/kpc^2", 0.0u"kpc",
    0.0, 0.0, 0,
    PhysicalVector2D(u"kpc/Gyr"), 0.0u"Gyr^-1", 0.0u"Gyr^-1", 0.0,
    0.0u"N/m", 0.0u"J/K/s", 0.0u"kpc/Gyr"
)

mutable struct SPHGas <: AbstractParticle3D
    Pos:::PhysicalVector3D
    Vel::PhysicalVector3D
    Acc::PhysicalVector3D
    Mass::Quantity
    ID::Integer

    Ti_endstep::Integer
    Ti_begstep::Integer
    GravCost::AbstractFloat

    Potential::Quantity
    OldAcc::Quantity

    # SPH
    Entropy::Quantity
    Density::Quantity
    Hsml::Quantity

    Left::AbstractFloat
    Right::AbstractFloat
    NumNgbFound::Integer

    RotVel::PhysicalVector3D
    DivVel::Quantity
    CurlVel::Quantity
    dHsmlRho::AbstractFloat

    Pressure::Quantity
    DtEntropy::Quantity
    MaxSignalVel::Quantity
end
SPHGas() = SPHGas(
    PhysicalVector3D(u"kpc"), PhysicalVector3D(u"kpc/Gyr"), PhysicalVector3D(u"kpc/Gyr^2"), 0.0u"Msun", 0,
    0, 0, 0.0,
    0.0u"J", 0.0u"kpc/Gyr^2",

    0.0u"J/K", 0.0u"Msun/kpc^3", 0.0u"kpc",
    0.0, 0.0, 0,
    PhysicalVector3D(u"kpc/Gyr"), 0.0u"Gyr^-1", 0.0u"Gyr^-1", 0.0,
    0.0u"N/m", 0.0u"J/K/s", 0.0u"kpc/Gyr"
)