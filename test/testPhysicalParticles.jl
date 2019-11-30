@testset "2D particles" begin
    @testset "Linear Algebra" begin
        a_Massless2D = Massless2D(Point2D(0.0, 0.0), Point2D(), 1)
        b_Massless2D = Massless2D(Point2D(3.0, 4.0), Point2D(), 2)

        @test distance(a_Massless2D, b_Massless2D) == 5.0


        a_Ball2D = Ball2D(PhysicalVector2D(0.0u"m", 0.0u"m"), PhysicalVector2D(u"m"), 0.0u"kg", 1)
        b_Ball2D = Ball2D(PhysicalVector2D(3.0u"m", 4.0u"m"), PhysicalVector2D(u"m"), 0.0u"kg", 2)

        @test distance(a_Ball2D, b_Ball2D) == 5.0u"m"

        
        a_Star2D = Star2D()
        b_Star2D = Star2D()
        b_Star2D.Pos = PhysicalVector2D(3.0u"m", 4.0u"m")
        @test distance(a_Star2D, b_Star2D) == 5.0u"m"


        a_SPHGas2D = SPHGas2D()
        b_SPHGas2D = SPHGas2D()
        b_SPHGas2D.Pos = PhysicalVector2D(3.0u"m", 4.0u"m")
        @test distance(a_SPHGas2D, b_SPHGas2D) == 5.0u"m"
    end
end

@testset "3D particles" begin
    @testset "Linear Algebra" begin
        a_Massless = Massless(Point(0.0, 0.0, 0.0), Point(), 1)
        b_Massless = Massless(Point(3.0, 4.0, 12.0), Point(), 2)

        @test distance(a_Massless, b_Massless) == 13.0


        a_Ball = Ball(PhysicalVector(0.0u"m", 0.0u"m", 0.0u"m"), PhysicalVector(u"m"), 0.0u"kg", 1)
        b_Ball = Ball(PhysicalVector(3.0u"m", 4.0u"m", 12.0u"m"), PhysicalVector(u"m"), 0.0u"kg", 2)

        @test distance(a_Ball, b_Ball) == 13.0u"m"

        
        a_Star = Star()
        b_Star = Star()
        b_Star.Pos = PhysicalVector(3.0u"m", 4.0u"m", 12.0u"m")
        @test distance(a_Star, b_Star) == 13.0u"m"


        a_SPHGas = SPHGas()
        b_SPHGas = SPHGas()
        b_SPHGas.Pos = PhysicalVector(3.0u"m", 4.0u"m", 12.0u"m")
        @test distance(a_SPHGas, b_SPHGas) == 13.0u"m"
    end
end

@testset "Random" begin
    a = rand_point3D(5, u"m")
    p = [Star() for i=1:5]

    assign_points(p, :Pos, a)
    @test p[1].Pos == a[1]
end