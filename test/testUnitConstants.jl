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


    @test uconvert(u"m", PVector2D(u"km")) == PVector2D(u"m")
    @test uconvert(u"m", PVector(u"km")) == PVector(u"m")

    @test ustrip(PVector2D(u"m")) == PVector2D()
    @test ustrip(PVector(u"m")) == PVector()
    @test ustrip(u"m", PVector2D(1.0, 1.0, u"km")) == PVector2D(1000.0, 1000.0)
    @test ustrip(u"m", PVector(1.0, 1.0, 1.0, u"km")) == PVector(1000.0, 1000.0, 1000.0)

    @test one(PVector2D(u"m")) == PVector2D(1.0, 1.0)
    @test one(PVector(u"m")) == PVector(1.0, 1.0, 1.0)
    @test one(u"m", PVector2D(u"km")) == PVector2D(1.0u"m", 1.0u"m")
    @test one(u"m", PVector(u"km")) == PVector(1.0u"m", 1.0u"m", 1.0u"m")

    @test zero(PVector2D(u"m")) == PVector2D()
    @test zero(PVector(u"m")) == PVector()
    @test zero(u"m", PVector2D(u"km")) == PVector2D(0.0u"m", 0.0u"m")
    @test zero(u"m", PVector(u"km")) == PVector(0.0u"m", 0.0u"m", 0.0u"m")
end

@testset "Constant" begin
    c = PhysicalParticles.Constant()
    @test Constants == c
end