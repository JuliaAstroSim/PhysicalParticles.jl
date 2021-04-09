# Predefined particle types

## Non-unit particles

"""
    struct Massless2D{P, V, I<:Integer} <: AbstractParticle2D

2D particle type without mass.

## Fields
```jl
Pos::PVector2D{P}
Vel::PVector2D{V}
ID::I
```

## Examples
```jl
julia> Massless2D()
Massless 0: Pos = PVector2D{Float64}(0.0, 0.0), Vel = PVector2D{Float64}(0.0, 0.0)

julia> Massless2D(uAstro)
Massless 0: Pos = PVector2D(0.0 kpc, 0.0 kpc), Vel = PVector2D(0.0 kpc Gyr^-1, 0.0 kpc Gyr^-1)

julia> Massless2D(uSI, id = 1)
Massless 1: Pos = PVector2D(0.0 m, 0.0 m), Vel = PVector2D(0.0 m s^-1, 0.0 m s^-1)
```
"""
struct Massless2D{P, V, I<:Integer} <: AbstractParticle2D
    Pos::PVector2D{P}
    Vel::PVector2D{V}
    ID::I
end

Massless2D(; id = 0) = Massless2D(PVector2D(), PVector2D(), id)

function Massless2D(units::Array; id = 0)
    uLength = getuLength(units)
    uTime = getuTime(units)
    return Massless2D(PVector2D(uLength), PVector2D(uLength / uTime), id)
end

"""
    struct Massless{P, V, I<:Integer} <: AbstractParticle3D
        
3D particle type without mass.

## Fields
```jl
Pos::PVector{P}
Vel::PVector{V}
ID::I
```

## Examples
```jl
julia> Massless()
Massless 0: Pos = PVector{Float64}(0.0, 0.0, 0.0), Vel = PVector{Float64}(0.0, 0.0, 0.0)

julia> Massless(uAstro)
Massless 0: Pos = PVector(0.0 kpc, 0.0 kpc, 0.0 kpc), Vel = PVector(0.0 kpc Gyr^-1, 0.0 kpc Gyr^-1, 0.0 kpc Gyr^-1)

julia> Massless(uSI, id = 1)
Massless 1: Pos = PVector(0.0 m, 0.0 m, 0.0 m), Vel = PVector(0.0 m s^-1, 0.0 m s^-1, 0.0 m s^-1)
```
"""
struct Massless{P, V, I<:Integer} <: AbstractParticle3D
    Pos::PVector{P}
    Vel::PVector{V}
    ID::I
end

Massless(; id = 0) = Massless(PVector(), PVector(), id)

function Massless(units::Array; id = 0)
    uLength = getuLength(units)
    uTime = getuTime(units)
    return Massless(PVector(uLength), PVector(uLength / uTime), id)
end


## Physical particles

"""
    struct Ball2D{P, V, A, M, I<:Integer} <: AbstractParticle2D

Basic 2D particle type.

## Fields
```jl
Pos::PVector2D{P}
Vel::PVector2D{V}
Acc::PVector2D{A}
Mass::M
ID::I
```

## Examples
```jl
julia> Ball2D()
Ball 0: Pos = PVector2D{Float64}(0.0, 0.0), Vel = PVector2D{Float64}(0.0, 0.0), Acc = PVector2D{Float64}(0.0, 0.0), Mass = 0.0

julia> Ball2D(uAstro)
Ball 0: Pos = PVector2D(0.0 kpc, 0.0 kpc), Vel = PVector2D(0.0 kpc Gyr^-1, 0.0 kpc Gyr^-1), Acc = PVector2D(0.0 kpc Gyr^-2, 0.0 kpc Gyr^-2), Mass = 0.0 M⊙

julia> Ball2D(uSI, id = 1)
Ball 1: Pos = PVector2D(0.0 m, 0.0 m), Vel = PVector2D(0.0 m s^-1, 0.0 m s^-1), Acc = PVector2D(0.0 m s^-2, 0.0 m s^-2), Mass = 0.0 kg
```
"""
struct Ball2D{P, V, A, M, I<:Integer} <: AbstractParticle2D
    Pos::PVector2D{P}
    Vel::PVector2D{V}
    Acc::PVector2D{A}
    Mass::M
    ID::I
end

Ball2D(; id = 0) = Ball2D(PVector2D(), PVector2D(), PVector2D(), 0.0, id)

function Ball2D(units::Array; id = 0)
    uLength = getuLength(units)
    uTime = getuTime(units)
    uMass = getuMass(units)
    return Ball2D(PVector2D(uLength), PVector2D(uLength / uTime), PVector2D(uLength / uTime^2), 0.0 * uMass, id)
end

"""
    struct Ball{P, V, A, M, I<:Integer} <: AbstractParticle3D

Basic 3D particle type.

## Fields
```jl
Pos::PVector{P}
Vel::PVector{V}
Acc::PVector{A}
Mass::M
ID::I
```

## Examples
```jl
julia> Ball()
Ball 0: Pos = PVector{Float64}(0.0, 0.0, 0.0), Vel = PVector{Float64}(0.0, 0.0, 0.0), Acc = PVector{Float64}(0.0, 0.0, 0.0), Mass = 0.0

julia> Ball(uAstro)
Ball 0: Pos = PVector(0.0 kpc, 0.0 kpc, 0.0 kpc), Vel = PVector(0.0 kpc Gyr^-1, 0.0 kpc Gyr^-1, 0.0 kpc Gyr^-1), Acc = PVector(0.0 kpc Gyr^-2, 0.0 kpc Gyr^-2, 0.0 kpc Gyr^-2), Mass = 0.0 M⊙

julia> Ball(uSI, id = 1)
Ball 1: Pos = PVector(0.0 m, 0.0 m, 0.0 m), Vel = PVector(0.0 m s^-1, 0.0 m s^-1, 0.0 m s^-1), Acc = PVector(0.0 m s^-2, 0.0 m s^-2, 0.0 m s^-2), Mass = 0.0 kg
```
"""
struct Ball{P, V, A, M, I<:Integer} <: AbstractParticle3D
    Pos::PVector{P}
    Vel::PVector{V}
    Acc::PVector{A}
    Mass::M
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

"""
    struct Star2D{P, V, A, M, E, I<:Integer} <: AbstractParticle2D

Basic 2D particle type to simulate in force fields.
[`Collection`](@ref) is an `Enum` defined in the same way with `Gadget2`, but start from 1.

## Fields
```jl
Pos::PVector2D{P}
Vel::PVector2D{V}
Acc::PVector2D{A}
Mass::M
ID::I
Collection::Collection

Ti_endstep::I  # Next integer step on the timeline.
Ti_begstep::I  # Present integer step on the timeline.
GravCost::I    # For each two-particle interaction, GravCost += 1

Potential::E   # Particle potential in the force field
OldAcc::A      # Save the normalization of acceleration of last step. Useful in Tree n-body method.
```

## Examples
```jl
julia> Star2D()
Star 0 STAR: Pos = PVector2D{Float64}(0.0, 0.0), Vel = PVector2D{Float64}(0.0, 0.0), Acc = PVector2D{Float64}(0.0, 0.0), Mass = 0.0, Ti_endstep = 0, Ti_begstep = 0, Potential = 0.0, OldAcc = 0.0

julia> Star2D(uAstro, collection = BLACKHOLE)
Star 0 BLACKHOLE: Pos = PVector2D(0.0 kpc, 0.0 kpc), Vel = PVector2D(0.0 kpc Gyr^-1, 0.0 kpc Gyr^-1), Acc = PVector2D(0.0 kpc Gyr^-2, 0.0 kpc Gyr^-2), Mass = 0.0 M⊙, Ti_endstep = 0, Ti_begstep = 0, Potential = 0.0 kpc^2 M⊙ Gyr^-2, OldAcc = 0.0 kpc Gyr^-2

julia> Star2D(uSI, id = 1)
Star 1 STAR: Pos = PVector2D(0.0 m, 0.0 m), Vel = PVector2D(0.0 m s^-1, 0.0 m s^-1), Acc = PVector2D(0.0 m s^-2, 0.0 m s^-2), Mass = 0.0 kg, Ti_endstep = 0, Ti_begstep = 0, Potential = 0.0 kg m^2 s^-2, OldAcc = 0.0 m s^-2
```
"""
struct Star2D{P, V, A, M, E, I<:Integer} <: AbstractParticle2D
    Pos::PVector2D{P}
    Vel::PVector2D{V}
    Acc::PVector2D{A}
    Mass::M
    ID::I
    Collection::Collection

    Ti_endstep::I  # Next integer step on the timeline.
    Ti_begstep::I  # Present integer step on the timeline.
    GravCost::I    # For each two-particle interaction, GravCost += 1

    Potential::E   # Particle potential in the force field
    OldAcc::A      # Save the normalization of acceleration of last step. Useful in Tree n-body method.
end


Star2D(; id = 0, collection = STAR) = Star2D(
    PVector2D(), PVector2D(), PVector2D(), 0.0, id, collection,
    0, 0, 0,
    0.0, 0.0
)

function Star2D(units::Array; id = 0, collection = STAR)
    uLength = getuLength(units)
    uTime = getuTime(units)
    uMass = getuMass(units)
    return Star2D(
        PVector2D(uLength), PVector2D(uLength / uTime), PVector2D(uLength / uTime^2),
        0.0 * uMass, id, collection,
        0, 0, 0,
        0.0 * getuEnergy(units), 0.0 * uLength / uTime^2
    )
end

"""
    struct Star{P, V, A, M, E, I<:Integer} <: AbstractParticle3D

Basic 3D particle type to simulate in force fields.
[`Collection`](@ref) is an `Enum` defined in the same way with `Gadget2`, but start from 1.

## Fields
```jl
Pos::PVector{P}
Vel::PVector{V}
Acc::PVector{A}
Mass::M
ID::I
Collection::Collection

Ti_endstep::I  # Next integer step on the timeline.
Ti_begstep::I  # Present integer step on the timeline.
GravCost::I    # For each two-particle interaction, GravCost += 1

Potential::E   # Particle potential in the force field
OldAcc::A      # Save the normalization of acceleration of last step. Useful in Tree n-body method.
```

## Examples
```jl
julia> Star()
Star 0 STAR: Pos = PVector{Float64}(0.0, 0.0, 0.0), Vel = PVector{Float64}(0.0, 0.0, 0.0), Acc = PVector{Float64}(0.0, 0.0, 0.0), Mass = 0.0, Ti_endstep = 0, Ti_begstep = 0, Potential = 0.0, OldAcc = 0.0

julia> Star(uAstro, collection = BLACKHOLE)
Star 0 BLACKHOLE: Pos = PVector(0.0 kpc, 0.0 kpc, 0.0 kpc), Vel = PVector(0.0 kpc Gyr^-1, 0.0 kpc Gyr^-1, 0.0 kpc Gyr^-1), Acc = PVector(0.0 kpc Gyr^-2, 0.0 kpc Gyr^-2, 0.0 kpc Gyr^-2), Mass = 0.0 M⊙, Ti_endstep = 0, Ti_begstep = 0, Potential = 0.0 kpc^2 M⊙ 
Gyr^-2, OldAcc = 0.0 kpc Gyr^-2

julia> Star(uSI, id = 1)
Star 1 STAR: Pos = PVector(0.0 m, 0.0 m, 0.0 m), Vel = PVector(0.0 m s^-1, 0.0 m s^-1, 0.0 m s^-1), Acc = PVector(0.0 m s^-2, 0.0 m s^-2, 0.0 m s^-2), Mass = 0.0 kg, Ti_endstep = 0, Ti_begstep = 0, Potential = 0.0 kg m^2 s^-2, OldAcc = 0.0 m s^-2
```
"""
struct Star{P, V, A, M, E, I<:Integer} <: AbstractParticle3D
    Pos::PVector{P}
    Vel::PVector{V}
    Acc::PVector{A}
    Mass::M
    ID::I
    Collection::Collection

    Ti_endstep::I  # Next integer step on the timeline.
    Ti_begstep::I  # Present integer step on the timeline.
    GravCost::I    # For each two-particle interaction, GravCost += 1

    Potential::E   # Particle potential in the force field
    OldAcc::A      # Save the normalization of acceleration of last step. Useful in Tree n-body method.
end

Star(; id = 0, collection = STAR) = Star(
    PVector(), PVector(), PVector(), 0.0, id, collection,
    0, 0, 0,
    0.0, 0.0
)

function Star(units::Array; id = 0, collection = STAR)
    uLength = getuLength(units)
    uTime = getuTime(units)
    uMass = getuMass(units)
    return Star(
        PVector(uLength), PVector(uLength / uTime), PVector(uLength / uTime^2),
        0.0 * uMass, id, collection,
        0, 0, 0,
        0.0 * getuEnergy(units), 0.0 * uLength / uTime^2
    )
end

"""
    struct SPHGas2D{P, V, A, M, E, F, Et, D, dP, dE, Prs, T_1, I<:Integer} <: AbstractParticle2D

Basic 2D SPH (Smoothed Particle Hydrodynamics) particle type to simulate in force fields.
[`Collection`](@ref) is an `Enum` defined in the same way with `Gadget2`, but start from 1.

## Fields
```jl
Pos::PVector2D{P}
Vel::PVector2D{V}
Acc::PVector2D{A}
Mass::M
ID::I
Collection::Collection

Ti_endstep::I  # Next integer step on the timeline.
Ti_begstep::I  # Present integer step on the timeline.
GravCost::I    # For each two-particle interaction, GravCost += 1

Potential::E   # Particle potential in the force field
OldAcc::A      # Save the normalization of acceleration of last step. Useful in Tree n-body method.

# SPH
Entropy::Et
Density::D
Hsml::P

Left::F
Right::F
NumNgbFound::I

RotVel::PVector2D{V}
DivVel::T_1
CurlVel::T_1
dHsmlRho::dP

Pressure::Prs
DtEntropy::dE
MaxSignalVel::V
```

## Examples
```jl
julia> SPHGas2D()
SPHGas 0 GAS: Pos = PVector2D{Float64}(0.0, 0.0), Vel = PVector2D{Float64}(0.0, 0.0), Acc = PVector2D{Float64}(0.0, 0.0), Mass = 0.0, Ti_endstep = 0, Ti_begstep = 0, Potential = 0.0, OldAcc = 0.0, Entropy = 0.0, Density = 0.0, Hsml = 0.0, Left = 0.0, Right = 0.0, NumNgbFound = 0, RotVel = PVector2D{Float64}(0.0, 0.0), DivVel = 0.0, CurlVel = 0.0, dHsmlRho = 0.0, Pressure = 0.0, DtEntropy = 0.0, MaxSignalVel = 0.0

julia> SPHGas2D(uAstro, collection = BLACKHOLE)
SPHGas 0 BLACKHOLE: Pos = PVector2D(0.0 kpc, 0.0 kpc), Vel = PVector2D(0.0 kpc Gyr^-1, 0.0 kpc Gyr^-1), Acc = PVector2D(0.0 kpc Gyr^-2, 0.0 kpc Gyr^-2), Mass = 0.0 M⊙, Ti_endstep = 0, Ti_begstep = 0, Potential = 0.0 kpc^2 M⊙ Gyr^-2, OldAcc = 0.0 kpc Gyr^-2, 
Entropy = 0.0 kpc^2 M⊙ K^-1 Gyr^-2, Density = 0.0 M⊙ kpc^-2, Hsml = 0.0 kpc, Left = 0.0, Right = 0.0, NumNgbFound = 0, RotVel = PVector2D(0.0 kpc Gyr^-1, 0.0 kpc Gyr^-1), DivVel = 0.0 Gyr^-1, CurlVel = 0.0 Gyr^-1, dHsmlRho = 0.0 kpc, Pressure = 0.0 M⊙ kpc^-1 Gyr^-2, DtEntropy = 0.0 kpc^2 M⊙ K^-1 Gyr^-3, MaxSignalVel = 0.0 kpc Gyr^-1

julia> SPHGas2D(uSI, id = 1)
SPHGas 1 GAS: Pos = PVector2D(0.0 m, 0.0 m), Vel = PVector2D(0.0 m s^-1, 0.0 m s^-1), Acc = PVector2D(0.0 m s^-2, 0.0 m s^-2), Mass = 0.0 kg, Ti_endstep = 0, Ti_begstep = 0, Potential = 0.0 kg m^2 s^-2, OldAcc = 0.0 m s^-2, Entropy = 0.0 kg m^2 K^-1 s^-2, Density = 0.0 kg m^-2, Hsml = 0.0 m, Left = 0.0, Right = 0.0, NumNgbFound = 0, RotVel = PVector2D(0.0 m s^-1, 0.0 m s^-1), DivVel = 0.0 s^-1, CurlVel = 0.0 s^-1, dHsmlRho = 0.0 m, Pressure = 0.0 kg m^-1 s^-2, DtEntropy = 0.0 kg m^2 K^-1 s^-3, MaxSignalVel = 0.0 m s^-1
```
"""
struct SPHGas2D{P, V, A, M, E, F, Et, D, dP, dE, Prs, T_1, I<:Integer} <: AbstractParticle2D
    Pos::PVector2D{P}
    Vel::PVector2D{V}
    Acc::PVector2D{A}
    Mass::M
    ID::I
    Collection::Collection

    Ti_endstep::I  # Next integer step on the timeline.
    Ti_begstep::I  # Present integer step on the timeline.
    GravCost::I    # For each two-particle interaction, GravCost += 1
    
    Potential::E   # Particle potential in the force field
    OldAcc::A      # Save the normalization of acceleration of last step. Useful in Tree n-body method.

    # SPH
    Entropy::Et
    Density::D
    Hsml::P

    Left::F
    Right::F
    NumNgbFound::I

    RotVel::PVector2D{V}
    DivVel::T_1
    CurlVel::T_1
    dHsmlRho::dP

    Pressure::Prs
    DtEntropy::dE
    MaxSignalVel::V
end

SPHGas2D(; id = 0, collection = GAS) = SPHGas2D(
    PVector2D(), PVector2D(), PVector2D(), 0.0, id, collection,
    0, 0, 0,
    0.0, 0.0,

    0.0, 0.0, 0.0,
    0.0, 0.0, 0,
    PVector2D(), 0.0, 0.0, 0.0,
    0.0, 0.0, 0.0
)

function SPHGas2D(units::Array; id = 0, collection = GAS)
    uLength = getuLength(units)
    uTime = getuTime(units)
    uMass = getuMass(units)
    uTemperature = getuTemperature(units)
    return SPHGas2D(
        PVector2D(uLength), PVector2D(uLength / uTime), PVector2D(uLength / uTime^2),
        0.0 * uMass, id, collection,
        0, 0, 0,
        0.0 * getuEnergy(units), 0.0 * uLength / uTime^2,

        0.0 * getuEntropy(units),
        0.0 * getuDensity2D(units), 0.0 * uLength,
        0.0, 0.0, 0,
        PVector2D(uLength / uTime),
        0.0 / uTime, 0.0 / uTime, 0.0 * uLength,
        0.0 * getuPressure(units),
        0.0 * getuEntropy(units) / uTime,
        0.0 * uLength / uTime
    )
end

"""
    struct SPHGas{P, V, A, M, E, F, Et, D, dP, dE, Prs, T_1, I<:Integer} <: AbstractParticle3D

Basic 3D SPH (Smoothed Particle Hydrodynamics) particle type to simulate in force fields.
[`Collection`](@ref) is an `Enum` defined in the same way with `Gadget2`, but start from 1.

## Fields
```jl
Pos::PVector2D{P}
Vel::PVector2D{V}
Acc::PVector2D{A}
Mass::M
ID::I
Collection::Collection

Ti_endstep::I  # Next integer step on the timeline.
Ti_begstep::I  # Present integer step on the timeline.
GravCost::I    # For each two-particle interaction, GravCost += 1

Potential::E   # Particle potential in the force field
OldAcc::A      # Save the normalization of acceleration of last step. Useful in Tree n-body method.

# SPH
Entropy::Et
Density::D
Hsml::P

Left::F
Right::F
NumNgbFound::I

RotVel::PVector2D{V}
DivVel::T_1
CurlVel::T_1
dHsmlRho::dP

Pressure::Prs
DtEntropy::dE
MaxSignalVel::V
```

## Examples
```jl
julia> SPHGas()
SPHGas 0 GAS: Pos = PVector{Float64}(0.0, 0.0, 0.0), Vel = PVector{Float64}(0.0, 0.0, 0.0), Acc = PVector{Float64}(0.0, 0.0, 0.0), Mass = 0.0, Ti_endstep = 0, Ti_begstep = 0, Potential = 0.0, OldAcc = 0.0, Entropy = 0.0, Density = 0.0, Hsml = 0.0, Left = 0.0, Right = 0.0, NumNgbFound = 0, RotVel = PVector{Float64}(0.0, 0.0, 0.0), DivVel = 0.0, CurlVel = 0.0, dHsmlRho = 0.0, Pressure = 0.0, DtEntropy = 0.0, MaxSignalVel = 0.0

julia> SPHGas(uAstro, collection = BLACKHOLE)
SPHGas 0 BLACKHOLE: Pos = PVector(0.0 kpc, 0.0 kpc, 0.0 kpc), Vel = PVector(0.0 kpc Gyr^-1, 0.0 kpc Gyr^-1, 0.0 kpc Gyr^-1), Acc = PVector(0.0 kpc Gyr^-2, 0.0 kpc Gyr^-2, 0.0 kpc Gyr^-2), Mass = 0.0 M⊙, Ti_endstep = 0, Ti_begstep = 0, Potential = 0.0 kpc^2 M⊙ Gyr^-2, OldAcc = 0.0 kpc Gyr^-2, Entropy = 0.0 kpc^2 M⊙ K^-1 Gyr^-2, Density = 0.0 M⊙ kpc^-3, Hsml = 0.0 kpc, Left = 0.0, Right = 0.0, NumNgbFound = 0, RotVel = PVector(0.0 kpc Gyr^-1, 0.0 kpc Gyr^-1, 0.0 kpc Gyr^-1), DivVel = 0.0 Gyr^-1, CurlVel = 0.0 Gyr^-1, dHsmlRho = 0.0 kpc, Pressure = 0.0 M⊙ kpc^-1 Gyr^-2, DtEntropy = 0.0 kpc^2 M⊙ K^-1 Gyr^-3, MaxSignalVel = 0.0 kpc Gyr^-1

julia> SPHGas(uSI, id = 1)
SPHGas 1 GAS: Pos = PVector(0.0 m, 0.0 m, 0.0 m), Vel = PVector(0.0 m s^-1, 0.0 m s^-1, 0.0 m s^-1), Acc = PVector(0.0 m s^-2, 0.0 m s^-2, 0.0 m s^-2), Mass = 0.0 kg, Ti_endstep = 0, Ti_begstep = 0, Potential = 0.0 kg m^2 s^-2, OldAcc = 0.0 m s^-2, Entropy = 0.0 kg m^2 K^-1 s^-2, Density = 0.0 kg m^-3, Hsml = 0.0 m, Left = 0.0, Right = 0.0, NumNgbFound = 0, RotVel = PVector(0.0 m s^-1, 0.0 m s^-1, 0.0 m s^-1), DivVel = 0.0 s^-1, CurlVel = 0.0 s^-1, dHsmlRho = 0.0 m, Pressure = 0.0 kg m^-1 s^-2, DtEntropy = 0.0 
kg m^2 K^-1 s^-3, MaxSignalVel = 0.0 m s^-1
```
"""
struct SPHGas{P, V, A, M, E, F, Et, D, dP, dE, Prs, T_1, I<:Integer} <: AbstractParticle3D
    Pos::PVector{P}
    Vel::PVector{V}
    Acc::PVector{A}
    Mass::M
    ID::I
    Collection::Collection

    Ti_endstep::I  # Next integer step on the timeline.
    Ti_begstep::I  # Present integer step on the timeline.
    GravCost::I    # For each two-particle interaction, GravCost += 1
    
    Potential::E   # Particle potential in the force field
    OldAcc::A      # Save the normalization of acceleration of last step. Useful in Tree n-body method.

    # SPH
    Entropy::Et
    Density::D
    Hsml::P

    Left::F
    Right::F
    NumNgbFound::I

    RotVel::PVector{V}
    DivVel::T_1
    CurlVel::T_1
    dHsmlRho::dP

    Pressure::Prs
    DtEntropy::dE
    MaxSignalVel::V
end

SPHGas(; id = 0, collection = GAS) = SPHGas(
    PVector(), PVector(), PVector(), 0.0, id, collection,
    0, 0, 0,
    0.0, 0.0,

    0.0, 0.0, 0.0,
    0.0, 0.0, 0,
    PVector(), 0.0, 0.0, 0.0,
    0.0, 0.0, 0.0
)

function SPHGas(units::Array; id = 0, collection = GAS)
    uLength = getuLength(units)
    uTime = getuTime(units)
    uMass = getuMass(units)
    uTemperature = getuTemperature(units)
    return SPHGas(
        PVector(uLength), PVector(uLength / uTime), PVector(uLength / uTime^2),
        0.0 * uMass, id, collection,
        0, 0, 0,
        0.0 * uMass * uLength^2 / uTime^2, 0.0 * uLength / uTime^2,

        0.0 * getuEntropy(units),
        0.0 * getuDensity(units), 0.0 * uLength,
        0.0, 0.0, 0,
        PVector(uLength / uTime),
        0.0 / uTime, 0.0 / uTime, 0.0 * uLength,
        0.0 * getuPressure(units),
        0.0 * getuEntropy(units) / uTime,
        0.0 * uLength / uTime
    )
end

"""
    countdata(data::Dict)
    countdata(data::Array)

Count the number of points or particles
"""
function countdata(data::Dict)
    len = 0
    for key in keys(data)
        len += length(data[key])
    end
    return len
end

countdata(data::Array) = length(data)

function push!(data::Dict, p::Union{Star, Star2D})
    if haskey(data, "stars")
        push!(data["stars"], p)
    else
        data["stars"] = [p]
    end
    return data
end

function push!(data::Dict, p::Union{SPHGas, SPHGas2D})
    if haskey(data, "gases")
        push!(data["gases"], p)
    else
        data["gases"] = [p]
    end
    return data
end

function append!(data::Dict{S, T}, d::Dict{S, T}) where S where T
    for p in Iterators.flatten(values(d))
        push!(data, p)
    end
    return data
end

"""
    split_data(data::Array, i::Int64, N::Int64)
    split_data(data::Dict, i::Int64, N::Int64)

split data to N sections, return the ith section

# Examples

```jl
julia> split_data([1,2,3], 1, 2)
2-element Vector{Int64}:
 1
 2

julia> split_data([1,2,3], 2, 2)
1-element Vector{Int64}:
 3

julia> split_data([1,2,3], 3, 4)
1-element Vector{Int64}:
 3

julia> split_data(Dict(1=>[1,2,3], 2=>[1,2]), 1, 2)
Dict{Int64, Vector{Int64}} with 2 entries:
  2 => [1]
  1 => [1, 2]
```
"""
function split_data(data::Array, i::Int64, N::Int64)
    if i > N || i <= 0
        error("Wrong section index! 1 <= i <= N, i ∈ Integer")
    end

    if length(data) == 0
        return empty(data)
    end

    len = length(data)
    sec = div(len, N)
    if len % N == 0
        head = (i - 1) * sec + 1
        return data[head : head + sec - 1]
    else
        if i <= len % N
            head = (i - 1) * (sec + 1) + 1
            return data[head : head + sec] # add one element
        else
            head = len - (N - i + 1) * sec + 1 # from tail
            return data[head : head + sec - 1]
        end
    end
end

function split_data(data::Dict, i::Int64, N::Int64)
    d = empty(data)
    for key in keys(data)
        d[key] = split_data(data[key], i, N)
    end
    return d
end