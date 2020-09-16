# Predefined particle types

## Non-unit particles

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

struct Star2D{P, V, A, M, E, F, I<:Integer} <: AbstractParticle2D
    Pos::PVector2D{P}
    Vel::PVector2D{V}
    Acc::PVector2D{A}
    Mass::M
    ID::I
    Collection::Collection

    Ti_endstep::I
    Ti_begstep::I
    GravCost::F

    Potential::E
    OldAcc::A
end


Star2D(; id = 0, collection = STAR) = Star2D(
    PVector2D(), PVector2D(), PVector2D(), 0.0, id, collection,
    0, 0, 0.0,
    0.0, 0.0
)

function Star2D(units::Array; id = 0, collection = STAR)
    uLength = getuLength(units)
    uTime = getuTime(units)
    uMass = getuMass(units)
    return Star2D(
        PVector2D(uLength), PVector2D(uLength / uTime), PVector2D(uLength / uTime^2),
        0.0 * uMass, id, collection,
        0, 0, 0.0,
        0.0 * getuEnergy(units), 0.0 * uLength / uTime^2
    )
end


struct Star{P, V, A, M, E, F, I<:Integer} <: AbstractParticle3D
    Pos::PVector{P}
    Vel::PVector{V}
    Acc::PVector{A}
    Mass::M
    ID::I
    Collection::Collection

    Ti_endstep::I
    Ti_begstep::I
    GravCost::F

    Potential::E
    OldAcc::A
end

Star(; id = 0, collection = STAR) = Star(
    PVector(), PVector(), PVector(), 0.0, id, collection,
    0, 0, 0.0,
    0.0, 0.0
)

function Star(units::Array; id = 0, collection = STAR)
    uLength = getuLength(units)
    uTime = getuTime(units)
    uMass = getuMass(units)
    return Star(
        PVector(uLength), PVector(uLength / uTime), PVector(uLength / uTime^2),
        0.0 * uMass, id, collection,
        0, 0, 0.0,
        0.0 * getuEnergy(units), 0.0 * uLength / uTime^2
    )
end


struct SPHGas2D{P, V, A, M, E, F, Et, D, dP, dE, Prs, T_1, I<:Integer} <: AbstractParticle2D
    Pos::PVector2D{P}
    Vel::PVector2D{V}
    Acc::PVector2D{A}
    Mass::M
    ID::I
    Collection::Collection

    Ti_endstep::I
    Ti_begstep::I
    GravCost::F

    Potential::E
    OldAcc::A

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
    0, 0, 0.0,
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
        0, 0, 0.0,
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


struct SPHGas{P, V, A, M, E, F, Et, D, dP, dE, Prs, T_1, I<:Integer} <: AbstractParticle3D
    Pos::PVector{P}
    Vel::PVector{V}
    Acc::PVector{A}
    Mass::M
    ID::I
    Collection::Collection

    Ti_endstep::I
    Ti_begstep::I
    GravCost::F

    Potential::E
    OldAcc::A

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
    0, 0, 0.0,
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
        0, 0, 0.0,
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

function countdata(data::Dict)
    len = 0
    for key in keys(data)
        len += length(data[key])
    end
    return len
end

countdata(data::Array) = length(data)

function push!(data::Dict, p::Star)
    if haskey(data, :stars)
        push!(data.stars, p)
    else
        data[:stars] = [p]
    end
end

function push!(data::Dict, p::Star2D)
    if haskey(data, :stars)
        push!(data.stars, p)
    else
        data[:stars] = [p]
    end
end

function push!(data::Dict, p::SPHGas)
    if haskey(data, :gases)
        push!(data.gases, p)
    else
        data[:gases] = [p]
    end
end

function push!(data::Dict, p::SPHGas2D)
    if haskey(data, :gases)
        push!(data.gases, p)
    else
        data[:gases] = [p]
    end
end

push!(data::Array, p) = push!(data, p)

function append!(data::Dict{S, Array{T,N}}, d::Dict{S, Array{T,N}}) where S where T<:AbstractParticle where N
    for p in Iterators.flatten(values(d))
        push!(data, p)
    end
end

"""
    split_data(data::Array, i::Int64, N::Int64)
    split_data(data::Dict, i::Int64, N::Int64)

split data to N sections, return the ith section

# Examples

```jldoctest; setup = :(using PhysicalParticles)
julia> split_data([1,2,3], 1, 2)
2-element Array{Int64,1}:
 1
 2

julia> split_data([1,2,3], 2, 2)
1-element Array{Int64,1}:
 3

julia> split_data([1,2,3], 3, 4)
1-element Array{Int64,1}:
 3

julia> split_data(Dict(1=>[1,2,3], 2=>[1,2]), 1, 2)
Dict{Int64,Array{Int64,1}} with 2 entries:
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