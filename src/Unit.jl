const uAstro = [u"kpc,Gyr,A,K,cd,Msun,mol"...]
const uSI = [u"m,s,A,K,cd,kg,mol"...]
const uCGS = [u"cm,s,A,K,cd,g,mol"...]

const uDefaults = [u"m,s,A,K,cd,kg,mol"...]

function preferunits(u)
    Unitful.preferunits(u...)

    for i in 1:7
        @inbounds uDefaults[i] = u[i]
    end
end

astro() = preferunits(uAstro)
si() = preferunits(uSI)
cgs() = preferunits(uCGS)

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