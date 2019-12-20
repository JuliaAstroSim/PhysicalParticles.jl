@testset "Peano" begin
    @testset "Peano key" begin
        # 2D
        @test peanokey(0,0) == 0

        # 3D
        @test peanokey(0,0,0) == 0
    end
end