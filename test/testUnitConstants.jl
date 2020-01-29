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


    @test PVector2D(u"m") == uconvert(u"m", PVector2D(u"km"))
    @test PVector(u"m") == uconvert(u"m", PVector(u"km"))
end

@testset "Constant" begin
    c = PhysicalParticles.Constant()
    @test Constants == c
end