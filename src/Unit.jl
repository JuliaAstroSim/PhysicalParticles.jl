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

function getunits(units = nothing)
    uLength, uTime, uCurrent, uTemperature, uLuminosity, uMass, uAmount = uDefaults

    if !isnothing(units)
        uLength, uTime, uCurrent, uTemperature, uLuminosity, uMass, uAmount = units
    end
    return uLength, uTime, uCurrent, uTemperature, uLuminosity, uMass, uAmount
end