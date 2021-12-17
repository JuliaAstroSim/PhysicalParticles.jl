# Predefined particle types

## Non-unit particles

"""
$(TYPEDEF)
$(TYPEDFIELDS)
2D particle type without mass.

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

Massless2D{F,I}(u::Nothing=nothing; id::I = zero(I)) where {F<:AbstractFloat, I<:Integer} = Massless2D(PVector2D(F), PVector2D(F), id)

function Massless2D{F,I}(units::Array; id::I = zero(I)) where {F<:AbstractFloat, I<:Integer}
    uLength = getuLength(units)
    uTime = getuTime(units)
    return Massless2D(PVector2D(F, uLength), PVector2D(F, uLength / uTime), id)
end

Massless2D(args...; kw...) = Massless2D{Float64, Int}(args...; kw...)
Massless2D(F, I, args...; kw...) = Massless2D{F, I}(args...; kw...)

"""
$(TYPEDEF)
$(TYPEDFIELDS)
3D particle type without mass.

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

Massless{F,I}(u::Nothing=nothing; id::I = zero(I)) where {F<:AbstractFloat, I<:Integer} = Massless(PVector(F), PVector(F), id)

function Massless{F,I}(units::Array; id::I = zero(I)) where {F<:AbstractFloat, I<:Integer}
    uLength = getuLength(units)
    uTime = getuTime(units)
    return Massless(PVector(F, uLength), PVector(F, uLength / uTime), id)
end

Massless(args...; kw...) = Massless{Float64, Int}(args...; kw...)
Massless(F, I, args...; kw...) = Massless{F, I}(args...; kw...)

## Physical particles

"""
$(TYPEDEF)
$(TYPEDFIELDS)
Basic 2D particle type.

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

Ball2D{F,I}(u::Nothing=nothing; id::I = zero(I)) where {F<:AbstractFloat, I<:Integer} = Ball2D(
    PVector2D(F), PVector2D(F), PVector2D(F), zero(F), id
)

function Ball2D{F,I}(units::Array; id::I = zero(I)) where {F<:AbstractFloat, I<:Integer}
    uLength = getuLength(units)
    uTime = getuTime(units)
    uMass = getuMass(units)
    return Ball2D(PVector2D(F, uLength), PVector2D(F, uLength / uTime), PVector2D(F, uLength / uTime^2), zero(F) * uMass, id)
end

Ball2D(args...; kw...) = Ball2D{Float64, Int}(args...; kw...)
Ball2D(F, I, args...; kw...) = Ball2D{F, I}(args...; kw...)

"""
$(TYPEDEF)
$(TYPEDFIELDS)
Basic 3D particle type.

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

Ball{F,I}(u::Nothing=nothing; id::I = zero(I)) where {F<:AbstractFloat, I<:Integer} = Ball(
    PVector(F), PVector(F), PVector(F), zero(F), id
)

function Ball{F,I}(units::Array; id::I = zero(I)) where {F<:AbstractFloat, I<:Integer}
    uLength = getuLength(units)
    uTime = getuTime(units)
    uMass = getuMass(units)
    return Ball(PVector(F, uLength), PVector(F, uLength / uTime), PVector(F, uLength / uTime^2), zero(F) * uMass, id)
end

Ball(args...; kw...) = Ball{Float64, Int}(args...; kw...)
Ball(F, I, args...; kw...) = Ball{F, I}(args...; kw...)


## Astrophysical particles

"""
$(TYPEDEF)
$(TYPEDFIELDS)
2D Particle type designed for AstroSim.jl.
[`Collection`](@ref) is an `Enum` defined in the same way with `Gadget2`, with index starting from 1.

## Examples
```jl
julia> Star2D()
SPHGas 0 GAS: Pos = PVector2D{Float64}(0.0, 0.0), Vel = PVector2D{Float64}(0.0, 0.0), Acc = PVector2D{Float64}(0.0, 0.0), Mass = 0.0, Ti_endstep = 0, Ti_begstep = 0, Potential = 0.0, OldAcc = 0.0, Entropy = 0.0, Density = 0.0, Hsml = 0.0, Left = 0.0, Right = 0.0, NumNgbFound = 0, RotVel = PVector2D{Float64}(0.0, 0.0), DivVel = 0.0, CurlVel = 0.0, dHsmlRho = 0.0, Pressure = 0.0, DtEntropy = 0.0, MaxSignalVel = 0.0

julia> Star2D(uAstro, collection = BLACKHOLE)
SPHGas 0 BLACKHOLE: Pos = PVector2D(0.0 kpc, 0.0 kpc), Vel = PVector2D(0.0 kpc Gyr^-1, 0.0 kpc Gyr^-1), Acc = PVector2D(0.0 kpc Gyr^-2, 0.0 kpc Gyr^-2), Mass = 0.0 M⊙, Ti_endstep = 0, Ti_begstep = 0, Potential = 0.0 kpc^2 M⊙ Gyr^-2, OldAcc = 0.0 kpc Gyr^-2, 
Entropy = 0.0 kpc^2 M⊙ K^-1 Gyr^-2, Density = 0.0 M⊙ kpc^-2, Hsml = 0.0 kpc, Left = 0.0, Right = 0.0, NumNgbFound = 0, RotVel = PVector2D(0.0 kpc Gyr^-1, 0.0 kpc Gyr^-1), DivVel = 0.0 Gyr^-1, CurlVel = 0.0 Gyr^-1, dHsmlRho = 0.0 kpc, Pressure = 0.0 M⊙ kpc^-1 Gyr^-2, DtEntropy = 0.0 kpc^2 M⊙ K^-1 Gyr^-3, MaxSignalVel = 0.0 kpc Gyr^-1

julia> Star2D(uSI, id = 1)
SPHGas 1 GAS: Pos = PVector2D(0.0 m, 0.0 m), Vel = PVector2D(0.0 m s^-1, 0.0 m s^-1), Acc = PVector2D(0.0 m s^-2, 0.0 m s^-2), Mass = 0.0 kg, Ti_endstep = 0, Ti_begstep = 0, Potential = 0.0 kg m^2 s^-2, OldAcc = 0.0 m s^-2, Entropy = 0.0 kg m^2 K^-1 s^-2, Density = 0.0 kg m^-2, Hsml = 0.0 m, Left = 0.0, Right = 0.0, NumNgbFound = 0, RotVel = PVector2D(0.0 m s^-1, 0.0 m s^-1), DivVel = 0.0 s^-1, CurlVel = 0.0 s^-1, dHsmlRho = 0.0 m, Pressure = 0.0 kg m^-1 s^-2, DtEntropy = 0.0 kg m^2 K^-1 s^-3, MaxSignalVel = 0.0 m s^-1
```
"""
struct Star2D{P, V, A, M, E, I<:Integer} <: AbstractParticle2D
    Pos::PVector2D{P}
    Vel::PVector2D{V}
    Acc::PVector2D{A}
    Mass::M
    ID::I
    Collection::Collection

    "Next integer step on the timeline."
    Ti_endstep::I
    "Present integer step on the timeline."
    Ti_begstep::I
    "For each two-particle interaction, GravCost += 1"
    GravCost::I
    
    "Particle potential in the force field"
    Potential::E
    "Save the normalization of acceleration of last step. Useful in Tree n-body method"
    OldAcc::A

    # SPH
    # Entropy::Et
    # Density::D
    # Hsml::P

    # Left::F
    # Right::F
    # NumNgbFound::I

    # RotVel::PVector2D{V}
    # DivVel::T_1
    # CurlVel::T_1
    # dHsmlRho::dP

    # Pressure::Prs
    # DtEntropy::dE
    # MaxSignalVel::V
end

function Star2D{F,I}(u::Nothing=nothing; id::I = zero(I), collection = STAR) where {F<:AbstractFloat, I<:Integer}
    Star2D(
        PVector2D(F), PVector2D(F), PVector2D(F), zero(F), id, collection,
        zero(I), zero(I), zero(I),
        zero(F), zero(F),

        # 0.0, 0.0, 0.0,
        # 0.0, 0.0, 0,
        # PVector2D(F), 0.0, 0.0, 0.0,
        # 0.0, 0.0, 0.0
    )
end

function Star2D{F,I}(units::Array; id::I = zero(I), collection = STAR) where {F<:AbstractFloat, I<:Integer}
    uLength = getuLength(units)
    uTime = getuTime(units)
    uMass = getuMass(units)
    uTemperature = getuTemperature(units)
    return Star2D(
        PVector2D(F, uLength), PVector2D(F, uLength / uTime), PVector2D(F, uLength / uTime^2),
        zero(F) * uMass, id, collection,
        zero(I), zero(I), zero(I),
        zero(F) * getuEnergy(units), zero(F) * uLength / uTime^2,

        # 0.0 * getuEntropy(units),
        # 0.0 * getuDensity2D(units), 0.0 * uLength,
        # 0.0, 0.0, 0,
        # PVector2D(F, uLength / uTime),
        # 0.0 / uTime, 0.0 / uTime, 0.0 * uLength,
        # 0.0 * getuPressure(units),
        # 0.0 * getuEntropy(units) / uTime,
        # 0.0 * uLength / uTime
    )
end

Star2D(args...; kw...) = Star2D{Float64, Int}(args...; kw...)
Star2D(F, I, args...; kw...) = Star2D{F, I}(args...; kw...)

"""
$(TYPEDEF)
$(TYPEDFIELDS)
3D Particle type designed for AstroSim.jl.

[`Collection`](@ref) is an `Enum` defined in the same way with `Gadget2`, but start from 1.

## Examples
```jl
julia> Star()
Star 0 GAS: Pos = PVector{Float64}(0.0, 0.0, 0.0), Vel = PVector{Float64}(0.0, 0.0, 0.0), Acc = PVector{Float64}(0.0, 0.0, 0.0), Mass = 0.0, Ti_endstep = 0, Ti_begstep = 0, Potential = 0.0, OldAcc = 0.0, Entropy = 0.0, Density = 0.0, Hsml = 0.0, Left = 0.0, Right = 0.0, NumNgbFound = 0, RotVel = PVector{Float64}(0.0, 0.0, 0.0), DivVel = 0.0, CurlVel = 0.0, dHsmlRho = 0.0, Pressure = 0.0, DtEntropy = 0.0, MaxSignalVel = 0.0

julia> Star(uAstro, collection = BLACKHOLE)
Star 0 BLACKHOLE: Pos = PVector(0.0 kpc, 0.0 kpc, 0.0 kpc), Vel = PVector(0.0 kpc Gyr^-1, 0.0 kpc Gyr^-1, 0.0 kpc Gyr^-1), Acc = PVector(0.0 kpc Gyr^-2, 0.0 kpc Gyr^-2, 0.0 kpc Gyr^-2), Mass = 0.0 M⊙, Ti_endstep = 0, Ti_begstep = 0, Potential = 0.0 kpc^2 M⊙ Gyr^-2, OldAcc = 0.0 kpc Gyr^-2, Entropy = 0.0 kpc^2 M⊙ K^-1 Gyr^-2, Density = 0.0 M⊙ kpc^-3, Hsml = 0.0 kpc, Left = 0.0, Right = 0.0, NumNgbFound = 0, RotVel = PVector(0.0 kpc Gyr^-1, 0.0 kpc Gyr^-1, 0.0 kpc Gyr^-1), DivVel = 0.0 Gyr^-1, CurlVel = 0.0 Gyr^-1, dHsmlRho = 0.0 kpc, Pressure = 0.0 M⊙ kpc^-1 Gyr^-2, DtEntropy = 0.0 kpc^2 M⊙ K^-1 Gyr^-3, MaxSignalVel = 0.0 kpc Gyr^-1

julia> Star(uSI, id = 1)
Star 1 GAS: Pos = PVector(0.0 m, 0.0 m, 0.0 m), Vel = PVector(0.0 m s^-1, 0.0 m s^-1, 0.0 m s^-1), Acc = PVector(0.0 m s^-2, 0.0 m s^-2, 0.0 m s^-2), Mass = 0.0 kg, Ti_endstep = 0, Ti_begstep = 0, Potential = 0.0 kg m^2 s^-2, OldAcc = 0.0 m s^-2, Entropy = 0.0 kg m^2 K^-1 s^-2, Density = 0.0 kg m^-3, Hsml = 0.0 m, Left = 0.0, Right = 0.0, NumNgbFound = 0, RotVel = PVector(0.0 m s^-1, 0.0 m s^-1, 0.0 m s^-1), DivVel = 0.0 s^-1, CurlVel = 0.0 s^-1, dHsmlRho = 0.0 m, Pressure = 0.0 kg m^-1 s^-2, DtEntropy = 0.0 
kg m^2 K^-1 s^-3, MaxSignalVel = 0.0 m s^-1
```
"""
struct Star{P, V, A, M, E, I<:Integer} <: AbstractParticle3D
    Pos::PVector{P}
    Vel::PVector{V}
    Acc::PVector{A}
    Mass::M
    ID::I
    Collection::Collection

    "Next integer step on the timeline."
    Ti_endstep::I
    "Present integer step on the timeline."
    Ti_begstep::I
    "For each two-particle interaction, GravCost += 1"
    GravCost::I
    
    "Particle potential in the force field"
    Potential::E
    "Save the normalization of acceleration of last step. Useful in Tree n-body method."
    OldAcc::A

    # SPH
    # Entropy::Et
    # Density::D
    # Hsml::P

    # Left::F
    # Right::F
    # NumNgbFound::I

    # RotVel::PVector{V}
    # DivVel::T_1
    # CurlVel::T_1
    # dHsmlRho::dP

    # Pressure::Prs
    # DtEntropy::dE
    # MaxSignalVel::V
end

function Star{F,I}(u::Nothing=nothing; id::I = zero(I), collection = STAR) where {F<:AbstractFloat, I<:Integer}
    Star(
        PVector(F), PVector(F), PVector(F), zero(F), id, collection,
        zero(I), zero(I), zero(I),
        zero(F), zero(F),

        # 0.0, 0.0, 0.0,
        # 0.0, 0.0, 0,
        # PVector(F), 0.0, 0.0, 0.0,
        # 0.0, 0.0, 0.0
    )
end

function Star{F,I}(units::Array; id::I = zero(I), collection = STAR) where {F<:AbstractFloat, I<:Integer}
    uLength = getuLength(units)
    uTime = getuTime(units)
    uMass = getuMass(units)
    uVel = getuVel(units)
    uAcc = getuAcc(units)
    uEnergyUnit = getuEnergyUnit(units)
    uTemperature = getuTemperature(units)
    return Star(
        PVector(F, uLength), PVector(F, uVel), PVector(F, uAcc),
        zero(F) * uMass, id, collection,
        zero(I), zero(I), zero(I),
        zero(F) * uEnergyUnit, zero(F) * uAcc,

        # 0.0 * getuEntropy(units),
        # 0.0 * getuDensity(units), 0.0 * uLength,
        # 0.0, 0.0, 0,
        # PVector(F, uVel),
        # 0.0 / uTime, 0.0 / uTime, 0.0 * uLength,
        # 0.0 * getuPressure(units),
        # 0.0 * getuEntropy(units) / uTime,
        # 0.0 * uLength / uTime
    )
end

Star(args...; kw...) = Star{Float64, Int}(args...; kw...)
Star(F, I, args...; kw...) = Star{F, I}(args...; kw...)

Base.getindex(a::StructArray{D} where D<:AbstractParticle, col::Collection) = a[a.Collection .== col]

value(p::PVector2D) = PVector2D(value(p.x), value(p.y))
value(p::PVector) = PVector(value(p.x), value(p.y), value(p.z))
value(c::Collection) = c

value(p::Star2D) = Star2D(value.(getfield.(p, fieldnames(Star2D)))...)
value(p::Star) = Star(value.(getfield.(p, fieldnames(Star)))...)
value(p::Ball2D) = Ball2D(value.(getfield.(p, fieldnames(Ball2D)))...)
value(p::Ball) = Ball(value.(getfield.(p, fieldnames(Ball)))...)
value(p::Massless2D) = Massless2D(value.(getfield.(p, fieldnames(Massless2D)))...)
value(p::Massless) = Massless(value.(getfield.(p, fieldnames(Massless)))...)

"""
    split_block(NumTotal::Int, i::Int, N::Int)

Split data to N sections.
Return Tuple `(head, tail)` to iterate in the `i`-th block
"""
function split_block(NumTotal::Int, i::Int, N::Int)
    if i > N || i <= 0
        error("Wrong section index! 1 <= i <= N, i ∈ Integer")
    end

    if NumTotal == 0
        return 1, 0
    end

    sec = div(NumTotal, N)
    if NumTotal % N == 0
        head = (i - 1) * sec + 1
        return head, head + sec - 1
    else
        if i <= NumTotal % N
            head = (i-1)*(sec+1)+1
            return head, head + sec      # add one element
        else
            head = NumTotal - (N-i+1)*sec + 1 # count from tail
            return head, head + sec - 1
        end
    end
end

"""
    split_data(data::AbstractArray, i::Int64, N::Int64)

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
```
"""
function split_data(data::AbstractArray, i::Int64, N::Int64)
    if length(data) == 0
        return data
    end

    head, tail = split_block(length(data), i, N)
    return data[head:tail]
end