@testset "AbstractTypes" begin
    @testset "Iterates" begin
        a = PVector()

        @test length(a) == 1
        @test iterate(a) == (PVector{Float64}(0.0, 0.0, 0.0), nothing)
        @test iterate(a, 1) == nothing
        @test real(a) == a

        a = Ball()

        @test length(a) == 1
        @test iterate(a) == (a, nothing)
        @test iterate(a, 1) == nothing
        @test real(a) == a

        a = Extent(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, PVector(), PVector())

        @test length(a) == 1
        @test iterate(a) == (a, nothing)
        @test iterate(a, 1) == nothing
        @test real(a) == a
    end
end