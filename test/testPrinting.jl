@testset "Printing" begin
    #!!! Just make sure these could be printed
    a = println(PVector2D())
    @test a == nothing

    a = println(PVector2D(u"m"))
    @test a == nothing

    a = println(PVector())
    @test a == nothing

    a = println(PVector(u"m"))
    @test a == nothing

    a = println(Massless2D())
    @test a == nothing

    a = println(Massless())
    @test a == nothing

    a = println(Ball2D())
    @test a == nothing

    a = println(Ball())
    @test a == nothing

    a = println(Star2D())
    @test a == nothing

    a = println(Star())
    @test a == nothing

    a = println(SPHGas2D())
    @test a == nothing

    a = println(SPHGas())
    @test a == nothing

    a = println(Extent2D(0.0, 0.0, 0.0, 0.0, 0.0, PVector2D(), PVector2D()))
    @test a == nothing

    a = println(Extent(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, PVector(), PVector()))
    @test a == nothing

    println()
end