# Predefined particle types

## Non-unit particles

mutable struct Massless2D{F<:AbstractFloat, I<:Integer} <: AbstractParticle2D
    Pos::PVector2D{F}
    Vel::PVector2D{F}
    ID::I
end
Massless2D() = Massless2D(PVector2D(), PVector2D(), 0)

mutable struct Massless{F<:AbstractFloat, I<:Integer} <: AbstractParticle3D
    Pos::PVector{F}
    Vel::PVector{F}
    ID::I
end
Massless() = Massless(PVector(), PVector(), 0)

## Physical particles

mutable struct Ball2D{I<:Integer} <: AbstractParticle2D
    Pos::PVector2D
    Vel::PVector2D
    Acc::PVector2D
    Mass::Quantity
    ID::I
end
Ball2D() = Ball2D(PVector2D(u"m"), PVector2D(u"m/s"), PVector2D(u"m/s^2"), 0.0u"kg", 0)

mutable struct Ball{I<:Integer} <: AbstractParticle3D
    Pos::PVector
    Vel::PVector
    Acc::PVector
    Mass::Quantity
    ID::I
end
Ball() = Ball(PVector(u"m"), PVector(u"m/s"), PVector(u"m/s^2"), 0.0u"kg", 0)

## Astrophysical particles

mutable struct Star2D{F<:AbstractFloat, I<:Integer} <: AbstractParticle2D
    Pos::PVector2D
    Vel::PVector2D
    Acc::PVector2D
    Mass::Quantity
    ID::I

    Ti_endstep::I
    Ti_begstep::I
    GravCost::F

    Potential::Quantity
    OldAcc::Quantity
end
Star2D() = Star2D(
    PVector2D(u"kpc"), PVector2D(u"kpc/Gyr"), PVector2D(u"kpc/Gyr^2"), 0.0u"Msun", 0,
    0, 0, 0.0,
    0.0u"J", 0.0u"kpc/Gyr^2"
)

mutable struct Star{F<:AbstractFloat, I<:Integer} <: AbstractParticle3D
    Pos::PVector
    Vel::PVector
    Acc::PVector
    Mass::Quantity
    ID::I

    Ti_endstep::I
    Ti_begstep::I
    GravCost::F

    Potential::Quantity
    OldAcc::Quantity
end
Star() = Star(
    PVector(u"kpc"), PVector(u"kpc/Gyr"), PVector(u"kpc/Gyr^2"), 0.0u"Msun", 0,
    0, 0, 0.0,
    0.0u"J", 0.0u"kpc/Gyr^2"
)

mutable struct SPHGas2D{F<:AbstractFloat, I<:Integer} <: AbstractParticle2D
    Pos::PVector2D
    Vel::PVector2D
    Acc::PVector2D
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

    RotVel::PVector2D
    DivVel::Quantity
    CurlVel::Quantity
    dHsmlRho::F

    Pressure::Quantity
    DtEntropy::Quantity
    MaxSignalVel::Quantity
end
SPHGas2D() = SPHGas2D(
    PVector2D(u"kpc"), PVector2D(u"kpc/Gyr"), PVector2D(u"kpc/Gyr^2"), 0.0u"Msun", 0,
    0, 0, 0.0,
    0.0u"J", 0.0u"kpc/Gyr^2",

    0.0u"J/K", 0.0u"Msun/kpc^2", 0.0u"kpc",
    0.0, 0.0, 0,
    PVector2D(u"kpc/Gyr"), 0.0u"Gyr^-1", 0.0u"Gyr^-1", 0.0,
    0.0u"N/m", 0.0u"J/K/s", 0.0u"kpc/Gyr"
)

mutable struct SPHGas{F<:AbstractFloat, I<:Integer} <: AbstractParticle3D
    Pos::PVector
    Vel::PVector
    Acc::PVector
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

    RotVel::PVector
    DivVel::Quantity
    CurlVel::Quantity
    dHsmlRho::F

    Pressure::Quantity
    DtEntropy::Quantity
    MaxSignalVel::Quantity
end
SPHGas() = SPHGas(
    PVector(u"kpc"), PVector(u"kpc/Gyr"), PVector(u"kpc/Gyr^2"), 0.0u"Msun", 0,
    0, 0, 0.0,
    0.0u"J", 0.0u"kpc/Gyr^2",

    0.0u"J/K", 0.0u"Msun/kpc^3", 0.0u"kpc",
    0.0, 0.0, 0,
    PVector(u"kpc/Gyr"), 0.0u"Gyr^-1", 0.0u"Gyr^-1", 0.0,
    0.0u"N/m", 0.0u"J/K/s", 0.0u"kpc/Gyr"
)