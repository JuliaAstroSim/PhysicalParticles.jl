@testset "Printing" begin
    #!!! Just make sure these could be printed
    a = show(PVector2D())
    @test a == nothing

    a = show(PVector())
    @test a == nothing

    a = show(Massless2D())
    @test a == nothing

    a = show(Massless())
    @test a == nothing

    a = show(Ball2D())
    @test a == nothing

    a = show(Ball())
    @test a == nothing

    a = show(Star2D())
    @test a == nothing

    a = show(Star())
    @test a == nothing

    a = show(SPHGas2D())
    @test a == nothing

    a = show(SPHGas())
    @test a == nothing

    a = show(Extent2D(0.0, 0.0, 0.0, 0.0, 0.0, PVector2D(), PVector2D()))
    @test a == nothing

    a = show(Extent(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, PVector(), PVector()))
    @test a == nothing
end