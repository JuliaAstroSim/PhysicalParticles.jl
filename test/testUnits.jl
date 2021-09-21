@testset "Unit" begin
    astro()
    @test uDefaults == uAstro

    si()
    @test uDefaults == uSI

    cgs()
    @test uDefaults == uCGS

    uTest = [u"mm,ms,A,K,cd,mg,mol"...]
    preferunits(uTest)
    @test [uDefaults...] == uTest

    u = getunits()
    @test [u...] == uDefaults

    u = getunits(uAstro)
    @test [u...] == uAstro

    u = getunits(nothing)
    @test u == (nothing, nothing, nothing, nothing, nothing, nothing, nothing)

    @test getuLength(nothing) === nothing
    @test getuTime(nothing) === nothing
    @test getuCurrent(nothing) === nothing
    @test getuTemperature(nothing) === nothing
    @test getuLuminosity(nothing) === nothing
    @test getuMass(nothing) === nothing
    @test getuAmount(nothing) === nothing

    @test getuVel(nothing) === nothing
    @test getuAcc(nothing) === nothing
    @test getuEnergy(nothing) === nothing
    @test getuEnergyUnit(nothing) === nothing
    @test getuEntropy(nothing) === nothing
    @test getuDensity(nothing) === nothing
    @test getuDensity2D(nothing) === nothing
    @test getuPressure(nothing) === nothing
    @test getuMomentum(nothing) === nothing

    @test getuLength(uAstro) == u"kpc"
    @test getuTime(uAstro) == u"Gyr"
    @test getuCurrent(uAstro) == u"A"
    @test getuTemperature(uAstro) == u"K"
    @test getuLuminosity(uAstro) == u"cd"
    @test getuMass(uAstro) == u"Msun"
    @test getuAmount(uAstro) == u"mol"

    @test getuVel(uAstro) == u"kpc/Gyr"
    @test getuAcc(uAstro) == u"kpc/Gyr^2"
    @test getuEnergy(uAstro) == u"Msun * kpc^2/Gyr^2"
    @test getuEnergyUnit(uAstro) == u"kpc^2/Gyr^2"
    @test getuEntropy(uAstro) == u"Msun * kpc^2 / Gyr^2 / K"
    @test getuDensity(uAstro) == u"Msun/kpc^3"
    @test getuDensity2D(uAstro) == u"Msun/kpc^2"
    @test getuPressure(uAstro) == u"Msun / kpc / Gyr^2"
    @test getuMomentum(uAstro) == u"Msun * kpc / Gyr"


    @test uconvert(u"m", PVector2D(u"km")) == PVector2D(u"m")
    @test uconvert(u"m", PVector(u"km")) == PVector(u"m")

    @test ustrip(PVector2D(u"m")) == PVector2D()
    @test ustrip(PVector(u"m")) == PVector()
    @test ustrip(u"m", PVector2D(1.0, 1.0, u"km")) == PVector2D(1000.0, 1000.0)
    @test ustrip(u"m", PVector(1.0, 1.0, 1.0, u"km")) == PVector(1000.0, 1000.0, 1000.0)
    @test ustrip(nothing, PVector2D()) == PVector2D()
    @test ustrip(nothing, PVector()) == PVector()

    @test ustrip(Float64, nothing, 1.0) == 1.0
    @test ustrip(nothing, 1.0) == 1.0

    @test one(PVector2D(u"m")) == PVector2D(1.0, 1.0)
    @test one(PVector(u"m")) == PVector(1.0, 1.0, 1.0)
    @test one(u"m", PVector2D(u"km")) == PVector2D(1.0u"m", 1.0u"m")
    @test one(u"m", PVector(u"km")) == PVector(1.0u"m", 1.0u"m", 1.0u"m")

    @test oneunit(PVector2D(u"m")) == PVector2D(1.0u"m", 1.0u"m")
    @test oneunit(PVector(u"m")) == PVector(1.0u"m", 1.0u"m", 1.0u"m")

    @test zero(PVector2D(1.0, 1.0, u"m")) == PVector2D(u"m")
    @test zero(PVector(1.0, 1.0, 1.0, u"m")) == PVector(u"m")
    @test zero(u"m", PVector2D(u"km")) == PVector2D(0.0u"m", 0.0u"m")
    @test zero(u"m", PVector(u"km")) == PVector(0.0u"m", 0.0u"m", 0.0u"m")

    @test zero(PVector{Float64}) == PVector()
    @test zero(PVector2D{Float64}) == PVector2D()
    @test zero(PVector) == PVector()
    @test zero(PVector2D) == PVector2D()

    @test isone(PVector(1.0, 1.0, 1.0))
    @test isone(PVector(1.0, 1.0, 1.0, u"m/m"))
    @test isone(PVector2D(1.0, 1.0))
    @test isone(PVector2D(1.0, 1.0, u"m/m"))

    @test iszero(PVector())
    @test iszero(PVector(u"m"))
    @test iszero(PVector2D())
    @test iszero(PVector2D(u"m"))

    @test isnan(PVector(NaN, NaN, NaN))
    @test isnan(PVector(NaN, NaN, NaN, u"m"))
    @test isnan(PVector2D(NaN, NaN))
    @test isnan(PVector2D(NaN, NaN, u"m"))

    @test hasnan(PVector(1.0, NaN, 1.0))
    @test hasnan(PVector(1.0, NaN, 1.0, u"m"))
    @test hasnan(PVector2D(1.0, NaN))
    @test hasnan(PVector2D(1.0, NaN, u"m"))

    @test isinf(PVector(Inf, Inf, Inf))
    @test isinf(PVector(Inf, Inf, Inf, u"m"))
    @test isinf(PVector2D(Inf, Inf))
    @test isinf(PVector2D(Inf, Inf, u"m"))

    @test hasinf(PVector(1.0, Inf, 1.0))
    @test hasinf(PVector(1.0, Inf, 1.0, u"m"))
    @test hasinf(PVector2D(1.0, Inf))
    @test hasinf(PVector2D(1.0, Inf, u"m"))

    @test axisunit(nothing) == ""
    @test axisunit(u"m") == " [m]"
    @test axisunit("len", u"m") == "len [m]"

    @test middle(1.0u"m") == 1.0u"m"
    @test middle(1.0u"m", 3.0u"m") == 2.0u"m"

    @test measurement(PVector(u"m")).x == measurement(PVector2D(u"m")).x

    @testset "Zero Values" begin
        ZeroValues = ZeroValue(nothing)
        @test ZeroValues.len == 0.0
        @test ZeroValues.pos == PVector()
        @test ZeroValues.vel == PVector()
        @test ZeroValues.acc == PVector()
        @test ZeroValues.pot == 0.0
        @test ZeroValues.potpermass == 0.0
        @test ZeroValues.mass == 0.0


        ZeroValues = ZeroValue(uAstro)
        @test ZeroValues.len == 0.0u"kpc"
        @test ZeroValues.pos == PVector(u"kpc")
        @test ZeroValues.vel == PVector(u"kpc/Gyr")
        @test ZeroValues.acc == PVector(u"kpc/Gyr^2")
        @test ZeroValues.pot == 0.0 * u"Msun * kpc^2 / Gyr^2"
        @test ZeroValues.potpermass == 0.0 * u"kpc^2 / Gyr^2"
        @test ZeroValues.mass == 0.0 * u"Msun"

        @test length(ZeroValues) == 1
        @test iterate(ZeroValues) == (ZeroValues, nothing)
        @test iterate(ZeroValues, nothing) === nothing

        @test show(ZeroValue()) === nothing
        @test show(ZeroValue(Measurement)) === nothing
        @test show(ZeroValue(Measurement, nothing)) === nothing
    end

    @testset "Constants" begin
        c = Constant()
        a = show(c)
        @test a === nothing

        nc = Constant(nothing, uAstro)
        @test nc == ustrip(c)

        @test show(Constant(BigFloat, uSI)) === nothing
        @test show(Constant(Measurement, uSI)) === nothing
    end
end