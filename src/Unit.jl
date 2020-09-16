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

getuLength(units = uDefaults) = units[1]
getuTime(units = uDefaults) = units[2]
getuCurrent(units = uDefaults) = units[3]
getuTemperature(units = uDefaults) = units[4]
getuLuminosity(units = uDefaults) = units[5]
getuMass(units = uDefaults) = units[6]
getuAmount(units = uDefaults) = units[7]

getuVel(units = uDefaults) = units[1] / units[2]
getuAcc(units = uDefaults) = units[1] / units[2]^2
getuEnergy(units = uDefaults) = units[6] * units[1]^2 / units[2]^2
getuEntropy(units = uDefaults) = units[6] * units[1]^2 / units[2]^2 / units[4]
getuDensity(units = uDefaults) = units[6] / units[1]^3
getuDensity2D(units = uDefaults) = units[6] / units[1]^2
getuPressure(units = uDefaults) = units[6] / units[1] / units[2]^2

ustrip(T::Type, ::Nothing, x::Real) = convert(T, x)
ustrip(::Nothing, x::Real) = x

"""
    axisunit(::Nothing)
    axisunit(u::Units)
    axisunit(s::AbstractString, u::Units)

Return a String for pretty printing.

# Examples

```jldoctest; setup = :(using PhysicalParticles)
julia> axisunit(nothing)
""

julia> axisunit(u"m")
" [m]"

julia> axisunit("1.0", u"Gyr")
"1.0 [Gyr]"
```
"""
axisunit(::Nothing) = ""
axisunit(u::Units) = string(" [", u, "]")
axisunit(s::AbstractString, u::Units) = string(s, " [", u, "]")