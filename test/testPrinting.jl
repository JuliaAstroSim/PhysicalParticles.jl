@testset "Printing" begin
    #!!! Just make sure these could be printed
    a = show(PVector2D())
    println()
    @test a == nothing

    a = show(PVector2D(u"m"))
    println()
    @test a == nothing

    a = show(PVector())
    println()
    @test a == nothing

    a = show(PVector(u"m"))
    println()
    @test a == nothing

    a = show(Massless2D())
    println()
    @test a == nothing

    a = show(Massless())
    println()
    @test a == nothing

    a = show(Ball2D())
    println()
    @test a == nothing

    a = show(Ball())
    println()
    @test a == nothing

    a = show(Star2D())
    println()
    @test a == nothing

    a = show(Star())
    println()
    @test a == nothing

    a = show(SPHGas2D())
    println()
    @test a == nothing

    a = show(SPHGas())
    println()
    @test a == nothing

    a = show(Extent2D(0.0, 0.0, 0.0, 0.0, 0.0, PVector2D(), PVector2D()))
    println()
    @test a == nothing

    a = show(Extent(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, PVector(), PVector()))
    println()
    @test a == nothing
end