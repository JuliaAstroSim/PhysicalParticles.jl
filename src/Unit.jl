"Default Astro units: kpc,Gyr,A,K,cd,Msun,mol"
const uAstro = [u"kpc,Gyr,A,K,cd,Msun,mol"...]

"Default SI units: m,s,A,K,cd,kg,mol"
const uSI = [u"m,s,A,K,cd,kg,mol"...]

"Default CGS units: cm,s,A,K,cd,g,mol"
const uCGS = [u"cm,s,A,K,cd,g,mol"...]

"Default units: m,s,A,K,cd,kg,mol"
const uDefaults = [u"m,s,A,K,cd,kg,mol"...]

"""
    preferunits(u)

Set defualt units to `u`, such as `uAstro`, `uSI`, `uCGS`, `uDefaults`
"""
function preferunits(u)
    Unitful.preferunits(u...)

    for i in 1:7
        @inbounds uDefaults[i] = u[i]
    end
end

"Set defulat units to `uAstro`"
astro() = preferunits(uAstro)

"Set defulat units to `uSI`"
si() = preferunits(uSI)

"Set defulat units to `uCGS`"
cgs() = preferunits(uCGS)

"""
    getunits(units = uDefaults)

Return Tuple of units from `units`
"""
function getunits(units = uDefaults)
    uLength, uTime, uCurrent, uTemperature, uLuminosity, uMass, uAmount = units
    return uLength, uTime, uCurrent, uTemperature, uLuminosity, uMass, uAmount
end

function getunits(::Nothing)
    return (nothing, nothing, nothing, nothing, nothing, nothing, nothing)
end

getuLength(::Nothing) = nothing
getuTime(::Nothing) = nothing
getuCurrent(::Nothing) = nothing
getuTemperature(::Nothing) = nothing
getuLuminosity(::Nothing) = nothing
getuMass(::Nothing) = nothing
getuAmount(::Nothing) = nothing

getuVel(::Nothing) = nothing
getuAcc(::Nothing) = nothing
getuEnergy(::Nothing) = nothing
getuEntropy(::Nothing) = nothing
getuDensity(::Nothing) = nothing
getuDensity2D(::Nothing) = nothing
getuPressure(::Nothing) = nothing

"""
    function getuLength(::Nothing)
    function getuLength(units)

Extract length unit from `units` or `nothing`

## Examples
```jl
julia> getuLength(nothing)

julia> getuLength(uAstro)
kpc

julia> getuLength(uSI)
m

julia> getuLength(uCGS)
cm
```
"""
getuLength(units = uDefaults) = units[1]

"""
    function getuTime(::Nothing)
    function getuTime(units)

Extract time unit from `units` or `nothing`

## Examples
```jl
julia> getuTime(nothing)

julia> getuTime(uAstro)
Gyr

julia> getuTime(uSI)
s

julia> getuTime(uCGS)
s
```
"""
getuTime(units = uDefaults) = units[2]

"""
    function getuCurrent(::Nothing)
    function getuCurrent(units)

Extract electric current unit from `units` or `nothing`

## Examples
```jl
julia> getuCurrent(nothing)

julia> getuCurrent(uAstro)
A

julia> getuCurrent(uSI)
A

julia> getuCurrent(uCGS)
A
```
"""
getuCurrent(units = uDefaults) = units[3]

"""
    function getuTemperature(::Nothing)
    function getuTemperature(units)

Extract temperature unit from `units` or `nothing`

## Examples
```jl
julia> getuTemperature(nothing)

julia> getuTemperature(uAstro)
K

julia> getuTemperature(uSI)
K

julia> getuTemperature(uCGS)
K
```
"""
getuTemperature(units = uDefaults) = units[4]

"""
    function getuLuminosity(::Nothing)
    function getuLuminosity(units)

Extract luminosity unit from `units` or `nothing`

## Examples
```jl
julia> getuLuminosity(nothing)

julia> getuLuminosity(uAstro)
cd

julia> getuLuminosity(uSI)
cd

julia> getuLuminosity(uCGS)
cd
```
"""
getuLuminosity(units = uDefaults) = units[5]

"""
    function getuMass(::Nothing)
    function getuMass(units)

Extract mass unit from `units` or `nothing`

## Examples
```jl
julia> getuMass(nothing)

julia> getuMass(uAstro)
M⊙

julia> getuMass(uSI)
kg

julia> getuMass(uCGS)
g
```
"""
getuMass(units = uDefaults) = units[6]

"""
    function getuAmount(::Nothing)
    function getuAmount(units)

Extract amount unit from `units` or `nothing`

## Examples
```jl
julia> getuAmount(nothing)

julia> getuAmount(uAstro)
mol

julia> getuAmount(uSI)
mol

julia> getuAmount(uCGS)
mol
```
"""
getuAmount(units = uDefaults) = units[7]


"""
    function getuVel(::Nothing)
    function getuVel(units)

Extract velocity unit from `units` or `nothing`

## Examples
```jl
julia> getuVel(nothing)

julia> getuVel(uAstro)
kpc Gyr^-1

julia> getuVel(uSI)
m s^-1

julia> getuVel(uCGS)
cm s^-1
```
"""
getuVel(units = uDefaults) = units[1] / units[2]

"""
    function getuAcc(::Nothing)
    function getuAcc(units)

Extract acceleration unit from `units` or `nothing`

## Examples
```jl
julia> getuAcc(nothing)

julia> getuAcc(uAstro)
kpc Gyr^-2

julia> getuAcc(uSI)
m s^-2

julia> getuAcc(uCGS)
cm s^-2
```
"""
getuAcc(units = uDefaults) = units[1] / units[2]^2

"""
    function getuEnergy(::Nothing)
    function getuEnergy(units)

Extract energy unit from `units` or `nothing`

## Examples
```jl
julia> getuEnergy(nothing)

julia> getuEnergy(uAstro)
kpc^2 M⊙ Gyr^-2

julia> getuEnergy(uSI)
kg m^2 s^-2

julia> getuEnergy(uCGS)
g cm^2 s^-2
```
"""
getuEnergy(units = uDefaults) = units[6] * units[1]^2 / units[2]^2

"""
    function getuEntropy(::Nothing)
    function getuEntropy(units)

Extract entropy unit from `units` or `nothing`

## Examples
```jl
julia> getuEntropy(nothing)

julia> getuEntropy(uAstro)
kpc^2 M⊙ K^-1 Gyr^-2

julia> getuEntropy(uSI)
kg m^2 K^-1 s^-2

julia> getuEntropy(uCGS)
g cm^2 K^-1 s^-2
```
"""
getuEntropy(units = uDefaults) = units[6] * units[1]^2 / units[2]^2 / units[4]

"""
    function getuDensity(::Nothing)
    function getuDensity(units)

Extract 3D density unit from `units` or `nothing`

## Examples
```jl
julia> getuDensity(nothing)

julia> getuDensity(uAstro)
M⊙ kpc^-3

julia> getuDensity(uSI)
kg m^-3

julia> getuDensity(uCGS)
g cm^-3
```
"""
getuDensity(units = uDefaults) = units[6] / units[1]^3

"""
    function getuDensity2D(::Nothing)
    function getuDensity2D(units)

Extract 2D density unit from `units` or `nothing`

## Examples
```jl
julia> getuDensity2D(nothing)

julia> getuDensity2D(uAstro)
M⊙ kpc^-2

julia> getuDensity2D(uSI)
kg m^-2

julia> getuDensity2D(uCGS)
g cm^-2
```
"""
getuDensity2D(units = uDefaults) = units[6] / units[1]^2

"""
    function getuPressure(::Nothing)
    function getuPressure(units)

Extract 2D density unit from `units` or `nothing`

## Examples
```jl
julia> getuPressure(nothing)

julia> getuPressure(uAstro)
M⊙ kpc^-1 Gyr^-2

julia> getuPressure(uSI)
kg m^-1 s^-2

julia> getuPressure(uCGS)
g cm^-1 s^-2
```
"""
getuPressure(units = uDefaults) = units[6] / units[1] / units[2]^2

ustrip(T::Type, ::Nothing, x::Real) = convert(T, x)
ustrip(::Nothing, x::Real) = x

"""
    axisunit(::Nothing)
    axisunit(u::Units)
    axisunit(s::AbstractString, u::Units)

Return a String for pretty printing.

# Examples

```jl
julia> axisunit(nothing)
""

julia> axisunit(u"m")
" [m]"

julia> axisunit("Time", u"Gyr")
"Time [Gyr]"
```
"""
axisunit(::Nothing) = ""
axisunit(u::Units) = string(" [", u, "]")
axisunit(s::AbstractString, u::Units) = string(s, " [", u, "]")

struct ZeroValue{Len, POS, VEL, ACC, POT, PPM, MASS}
    len::Len
    pos::POS
    vel::VEL
    acc::ACC
    pot::POT
    potpermass::PPM
    mass::MASS
end

@inline length(::ZeroValue) = 1
@inline iterate(z::ZeroValue) = (z,nothing)
@inline iterate(z::ZeroValue,st) = nothing

"""
    function zerovalues(units::Nothing)
    function zerovalues(units::Vector{Unitful.FreeUnits{N, D, nothing} where D where N} = uAstro)

    Construct an immutable struct providing zero values in corresponding `units` (default is `uAstro`).
    Useful for accumulated summation, array initialization, etc.

# Examples

zerovalues(nothing)
zerovalues()
zerovalues(uSI)
zerovalues(uCGS)
"""
function zerovalues(units::Nothing)
    return ZeroValue(0.0, PVector(), PVector(), PVector(), 0.0, 0.0, 0.0)
end

function zerovalues(units::Vector{Unitful.FreeUnits{N, D, nothing} where D where N} = uAstro)
    return ZeroValue(
        0.0 * getuLength(units),
        PVector(getuLength(units)),
        PVector(getuVel(units)),
        PVector(getuAcc(units)),
        0.0 * getuEnergy(units),
        0.0 * getuEnergy(units) / getuMass(units),
        0.0 * getuMass(units),
    )
end

ZeroValue(units = uAstro) = zerovalues(units)

function Base.show(io::IO, z::ZeroValue)
    print(io, """
        Zero Values:
            len = $(z.len)
            pos = $(z.pos)
            vel = $(z.vel)
            acc = $(z.acc)
            pot = $(z.pot)
            potpermass = $(z.potpermass)
            mass = $(z.mass)
    """)
end