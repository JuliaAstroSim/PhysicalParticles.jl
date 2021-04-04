@testset "AbstractTypes" begin
    @testset "Basic" begin
        a = PVector()
        @test getx(a) == a.x
        @test gety(a) == a.y
        @test getz(a) == a.z
    end

    @testset "Iterates" begin
        a = PVector()

        @test length(a) == 1
        @test iterate(a) == (PVector{Float64}(0.0, 0.0, 0.0), nothing)
        @test iterate(a, 1) === nothing
        @test real(a) == a

        a = Ball()

        @test length(a) == 1
        @test iterate(a) == (a, nothing)
        @test iterate(a, 1) === nothing
        @test real(a) == a

        a = Extent(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, PVector(), PVector())

        @test length(a) == 1
        @test iterate(a) == (a, nothing)
        @test iterate(a, 1) === nothing
        @test real(a) == a
    end

    @testset "Data Dimensions" begin
        @test datadimension([PVector2D()]) == Unitless2D()
        @test datadimension([PVector()]) == Unitless3D()
        @test datadimension([Star2D(uAstro)]) == Physical2D()
        @test datadimension([Star(uAstro)]) == Physical3D()

        @test datadimension(Dict("pos" => [PVector2D()])) == Unitless2D()
        @test datadimension(Dict("pos" => [PVector()])) == Unitless3D()
        @test datadimension(Dict("stars" => [Star2D(uAstro)])) == Physical2D()
        @test datadimension(Dict("stars" => [Star(uAstro)])) == Physical3D()
    end
end