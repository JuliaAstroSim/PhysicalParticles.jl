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

        @test PVector(1.0) == 1.0
        @test PVector(1.0, u"m") == 1.0u"m"
        @test PVector(1.0, nothing) == 1.0
    end

    @testset "Split data" begin
        @test split_data([1,2,3], 1, 2) == [1,2]
        @test split_data([1,2,3], 2, 2) == [3]
        @test split_data([1,2,3], 3, 3) == [3]
        @test split_data([1,2,3], 3, 4) == [3]
        @test split_data([1,2,3], 4, 4) == Int[]
        @test_broken split_data([1,2,3], 3, 2)
        @test split_data([], 1, 2) == []
    end
end