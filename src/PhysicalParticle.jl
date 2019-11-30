# Predefined particle types

## Non-unit particles

mutable struct Massless2D{F<:AbstractFloat, I<:Integer} <: AbstractParticle2D
    Pos::Point2D{F}
    Vel::Point2D{F}
    ID::I
end
Massless2D() = Massless2D(Point2D(), Point2D(), 0)

mutable struct Massless{F<:AbstractFloat, I<:Integer} <: AbstractParticle3D
    Pos::Point3D{F}
    Vel::Point3D{F}
    ID::I
end
Massless() = Massless(Point3D(), Point3D(), 0)

## Physical particles

mutable struct Ball2D{I<:Integer} <: AbstractParticle2D
    Pos::PhysicalVector2D
    Vel::PhysicalVector2D
    Mass::Quantity
    ID::I
end
Ball2D() = Ball2D(PhysicalVector2D(u"m"), PhysicalVector2D(u"m/s"), 0.0u"kg", 0)

mutable struct Ball{I<:Integer} <: AbstractParticle3D
    Pos::PhysicalVector3D
    Vel::PhysicalVector3D
    Mass::Quantity
    ID::I
end
Ball() = Ball(PhysicalVector3D(u"m"), PhysicalVector3D(u"m/s"), 0.0u"kg", 0)

## Astrophysical particles

mutable struct Star2D{F<:AbstractFloat, I<:Integer} <: AbstractParticle2D
    Pos::PhysicalVector2D
    Vel::PhysicalVector2D
    Acc::PhysicalVector2D
    Mass::Quantity
    ID::I

    Ti_endstep::I
    Ti_begstep::I
    GravCost::F

    Potential::Quantity
    OldAcc::Quantity
end
Star2D() = Star2D(
    PhysicalVector2D(u"kpc"), PhysicalVector2D(u"kpc/Gyr"), PhysicalVector2D(u"kpc/Gyr^2"), 0.0u"Msun", 0,
    0, 0, 0.0,
    0.0u"J", 0.0u"kpc/Gyr^2"
)

mutable struct Star{F<:AbstractFloat, I<:Integer} <: AbstractParticle3D
    Pos::PhysicalVector3D
    Vel::PhysicalVector3D
    Acc::PhysicalVector3D
    Mass::Quantity
    ID::I

    Ti_endstep::I
    Ti_begstep::I
    GravCost::F

    Potential::Quantity
    OldAcc::Quantity
end
Star() = Star(
    PhysicalVector3D(u"kpc"), PhysicalVector3D(u"kpc/Gyr"), PhysicalVector3D(u"kpc/Gyr^2"), 0.0u"Msun", 0,
    0, 0, 0.0,
    0.0u"J", 0.0u"kpc/Gyr^2"
)

mutable struct SPHGas2D{F<:AbstractFloat, I<:Integer} <: AbstractParticle2D
    Pos::PhysicalVector2D
    Vel::PhysicalVector2D
    Acc::PhysicalVector2D
    Mass::Quantity
    ID::I

    Ti_endstep::I
    Ti_begstep::I
    GravCost::F

    Potential::Quantity
    OldAcc::Quantity

    # SPH
    Entropy::Quantity
    Density::Quantity
    Hsml::Quantity

    Left::F
    Right::F
    NumNgbFound::I

    RotVel::PhysicalVector2D
    DivVel::Quantity
    CurlVel::Quantity
    dHsmlRho::F

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

mutable struct SPHGas{F<:AbstractFloat, I<:Integer} <: AbstractParticle3D
    Pos::PhysicalVector3D
    Vel::PhysicalVector3D
    Acc::PhysicalVector3D
    Mass::Quantity
    ID::I

    Ti_endstep::I
    Ti_begstep::I
    GravCost::F

    Potential::Quantity
    OldAcc::Quantity

    # SPH
    Entropy::Quantity
    Density::Quantity
    Hsml::Quantity

    Left::F
    Right::F
    NumNgbFound::I

    RotVel::PhysicalVector3D
    DivVel::Quantity
    CurlVel::Quantity
    dHsmlRho::F

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