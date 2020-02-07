# Predefined particle types

## Non-unit particles

mutable struct Massless2D{I<:Integer} <: AbstractParticle2D
    Pos::PVector2D
    Vel::PVector2D
    ID::I
end

Massless2D(; id = 0) = Massless2D(PVector2D(), PVector2D(), id)

function Massless2D(units::Array; id = 0)
    uLength = getuLength(units)
    uTime = getuTime(units)
    return Massless2D(PVector2D(uLength), PVector2D(uLength / uTime), id)
end


mutable struct Massless{I<:Integer} <: AbstractParticle3D
    Pos::PVector
    Vel::PVector
    ID::I
end

Massless(; id = 0) = Massless(PVector(), PVector(), id)

function Massless(units::Array; id = 0)
    uLength = getuLength(units)
    uTime = getuTime(units)
    return Massless(PVector(uLength), PVector(uLength / uTime), id)
end


## Physical particles

mutable struct Ball2D{I<:Integer} <: AbstractParticle2D
    Pos::PVector2D
    Vel::PVector2D
    Acc::PVector2D
    Mass::Number
    ID::I
end

Ball2D(; id = 0) = Ball2D(PVector2D(), PVector2D(), PVector2D(), 0.0, id)

function Ball2D(units::Array; id = 0)
    uLength = getuLength(units)
    uTime = getuTime(units)
    uMass = getuMass(units)
    return Ball2D(PVector2D(uLength), PVector2D(uLength / uTime), PVector2D(uLength / uTime^2), 0.0 * uMass, id)
end


mutable struct Ball{I<:Integer} <: AbstractParticle3D
    Pos::PVector
    Vel::PVector
    Acc::PVector
    Mass::Number
    ID::I
end

Ball(; id = 0) = Ball(PVector(), PVector(), PVector(), 0.0, id)

function Ball(units::Array; id = 0)
    uLength = getuLength(units)
    uTime = getuTime(units)
    uMass = getuMass(units)
    return Ball(PVector(uLength), PVector(uLength / uTime), PVector(uLength / uTime^2), 0.0 * uMass, id)
end


## Astrophysical particles

mutable struct Star2D{I<:Integer} <: AbstractParticle2D
    Pos::PVector2D
    Vel::PVector2D
    Acc::PVector2D
    Mass::Number
    ID::I
    Type::AbstractParticleType

    Ti_endstep::I
    Ti_begstep::I
    GravCost::Number

    Potential::Number
    OldAcc::Number
end


Star2D(; id = 0, type = STAR()) = Star2D(
    PVector2D(), PVector2D(), PVector2D(), 0.0, id, type,
    0, 0, 0.0,
    0.0, 0.0
)

function Star2D(units::Array; id = 0, type = STAR())
    uLength = getuLength(units)
    uTime = getuTime(units)
    uMass = getuMass(units)
    return Star2D(
        PVector2D(uLength), PVector2D(uLength / uTime), PVector2D(uLength / uTime^2),
        0.0 * uMass, id, type,
        0, 0, 0.0,
        0.0 * uMass * uLength^2 / uTime^2, 0.0 * uLength / uTime^2
    )
end


mutable struct Star{I<:Integer} <: AbstractParticle3D
    Pos::PVector
    Vel::PVector
    Acc::PVector
    Mass::Number
    ID::I
    Type::AbstractParticleType

    Ti_endstep::I
    Ti_begstep::I
    GravCost::Number

    Potential::Number
    OldAcc::Number
end

Star(; id = 0, type = STAR()) = Star(
    PVector(), PVector(), PVector(), 0.0, id, type,
    0, 0, 0.0,
    0.0, 0.0
)

function Star(units::Array; id = 0, type = STAR())
    uLength = getuLength(units)
    uTime = getuTime(units)
    uMass = getuMass(units)
    return Star(
        PVector(uLength), PVector(uLength / uTime), PVector(uLength / uTime^2),
        0.0 * uMass, id, type,
        0, 0, 0.0,
        0.0 * uMass * uLength^2 / uTime^2, 0.0 * uLength / uTime^2
    )
end


mutable struct SPHGas2D{I<:Integer} <: AbstractParticle2D
    Pos::PVector2D
    Vel::PVector2D
    Acc::PVector2D
    Mass::Number
    ID::I
    Type::AbstractParticleType

    Ti_endstep::I
    Ti_begstep::I
    GravCost::Number

    Potential::Number
    OldAcc::Number

    # SPH
    Entropy::Number
    Density::Number
    Hsml::Number

    Left::Number
    Right::Number
    NumNgbFound::I

    RotVel::PVector2D
    DivVel::Number
    CurlVel::Number
    dHsmlRho::Number

    Pressure::Number
    DtEntropy::Number
    MaxSignalVel::Number
end

SPHGas2D(; id = 0, type = GAS()) = SPHGas2D(
    PVector2D(), PVector2D(), PVector2D(), 0.0, id, type,
    0, 0, 0.0,
    0.0, 0.0,

    0.0, 0.0, 0.0,
    0.0, 0.0, 0,
    PVector2D(), 0.0, 0.0, 0.0,
    0.0, 0.0, 0.0
)

function SPHGas2D(units::Array; id = 0, type = GAS())
    uLength = getuLength(units)
    uTime = getuTime(units)
    uMass = getuMass(units)
    uTemperature = getuTemperature(units)
    return SPHGas2D(
        PVector2D(uLength), PVector2D(uLength / uTime), PVector2D(uLength / uTime^2),
        0.0 * uMass, id, type,
        0, 0, 0.0,
        0.0 * uMass * uLength^2 / uTime^2, 0.0 * uLength / uTime^2,

        0.0 * uMass * uLength^2 / uTime^2 / uTemperature,
        0.0 * uMass / uLength^2, 0.0 * uLength,
        0.0, 0.0, 0,
        PVector2D(uLength / uTime),
        0.0 / uTime, 0.0 / uTime, 0.0 * uLength,
        0.0 * uMass / uLength / uTime^2,
        0.0 * uMass * uLength^2 / uTime^3 / uTemperature,
        0.0 * uLength / uTime
    )
end


mutable struct SPHGas{I<:Integer} <: AbstractParticle3D
    Pos::PVector
    Vel::PVector
    Acc::PVector
    Mass::Number
    ID::I
    Type::AbstractParticleType

    Ti_endstep::I
    Ti_begstep::I
    GravCost::Number

    Potential::Number
    OldAcc::Number

    # SPH
    Entropy::Number
    Density::Number
    Hsml::Number

    Left::Number
    Right::Number
    NumNgbFound::I

    RotVel::PVector
    DivVel::Number
    CurlVel::Number
    dHsmlRho::Number

    Pressure::Number
    DtEntropy::Number
    MaxSignalVel::Number
end

SPHGas(; id = 0, type = GAS()) = SPHGas(
    PVector(), PVector(), PVector(), 0.0, id, type,
    0, 0, 0.0,
    0.0, 0.0,

    0.0, 0.0, 0.0,
    0.0, 0.0, 0,
    PVector(), 0.0, 0.0, 0.0,
    0.0, 0.0, 0.0
)

function SPHGas(units::Array; id = 0, type = GAS())
    uLength = getuLength(units)
    uTime = getuTime(units)
    uMass = getuMass(units)
    uTemperature = getuTemperature(units)
    return SPHGas(
        PVector(uLength), PVector(uLength / uTime), PVector(uLength / uTime^2),
        0.0 * uMass, id, type,
        0, 0, 0.0,
        0.0 * uMass * uLength^2 / uTime^2, 0.0 * uLength / uTime^2,

        0.0 * uMass * uLength^2 / uTime^2 / uTemperature,
        0.0 * uMass / uLength^3, 0.0 * uLength,
        0.0, 0.0, 0,
        PVector(uLength / uTime),
        0.0 / uTime, 0.0 / uTime, 0.0 * uLength,
        0.0 * uMass / uLength / uTime^2,
        0.0 * uMass * uLength^2 / uTime^3 / uTemperature,
        0.0 * uLength / uTime
    )
end