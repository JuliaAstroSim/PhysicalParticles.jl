#!!! Avoid string interpolation for I/O

# Vectors
function Base.show(io::IO, p::PVector2D{T}) where T<:Quantity
    print(io, "PVector2D(", p.x, ", ", p.y, ")")
end

function Base.show(io::IO, p::PVector{T}) where T<:Quantity
    print(io, "PVector(", p.x, ", ", p.y, ", ", p.z, ")")
end



# Particles
function Base.show(io::IO, p::T) where T<:Union{Massless, Massless2D}
    print(io, "Massless ", p.ID, ": Pos = ", p.Pos, ", Vel = ", p.Vel)
end

function Base.show(io::IO, p::T) where T<:Union{Ball, Ball2D}
    print(io, "Ball ", p.ID, ": Pos = ", p.Pos, ", Vel = ", p.Vel, ", Acc = ", p.Acc, ", Mass = ", p.Mass)
end

function Base.show(io::IO, p::T) where T<:Union{Star, Star2D}
    print(
        io, "Star ", p.ID, " ", p.Collection,
        "\b\b: Pos = ", p.Pos, 
        ", Vel = ", p.Vel, 
        ", Acc = ", p.Acc, 
        ", Mass = ", p.Mass,
        ", Ti_endstep = ", p.Ti_endstep,
        ", Ti_begstep = ", p.Ti_begstep,
        ", Potential = ", p.Potential,
        ", OldAcc = ", p.OldAcc
    )
end

function Base.show(io::IO, p::T) where T<:Union{SPHGas, SPHGas2D}
    print(
        io, "SPHGas ", p.ID, " ", p.Collection,
        "\b\b: Pos = ", p.Pos, 
        ", Vel = ", p.Vel, 
        ", Acc = ", p.Acc, 
        ", Mass = ", p.Mass,
        ", Ti_endstep = ", p.Ti_endstep,
        ", Ti_begstep = ", p.Ti_begstep,
        ", Potential = ", p.Potential,
        ", OldAcc = ", p.OldAcc,

        ", Entropy = ", p.Entropy,
        ", Density = ", p.Density,
        ", Hsml = ", p.Hsml,
        ", Left = ", p.Left,
        ", Right = ", p.Right,
        ", NumNgbFound = ", p.NumNgbFound,
        ", RotVel = ", p.RotVel,
        ", DivVel = ", p.DivVel,
        ", CurlVel = ", p.CurlVel,
        ", dHsmlRho = ", p.dHsmlRho,
        ", Pressure = ", p.Pressure,
        ", DtEntropy = ", p.DtEntropy,
        ", MaxSignalVel = ", p.MaxSignalVel
    )
end



# Extents
function Base.show(io::IO, p::Extent2D)
    print(
        io, "Extent: ",
        "xMin = ", p.xMin,
        ", xMax = ", p.xMax,
        ", yMin = ", p.yMin,
        ", yMax = ", p.yMax,
        ", SideLength = ", p.SideLength,
        ", Center = ", p.Center,
        ", Corner = ", p.Corner
    )
end

function Base.show(io::IO, p::Extent)
    print(
        io, "Extent: ",
        "xMin = ", p.xMin,
        ", xMax = ", p.xMax,
        ", yMin = ", p.yMin,
        ", yMax = ", p.yMax,
        ", zMin = ", p.zMin,
        ", zMax = ", p.zMax,
        ", SideLength = ", p.SideLength,
        ", Center = ", p.Center,
        ", Corner = ", p.Corner
    )
end