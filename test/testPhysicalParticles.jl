@testset "2D particles" begin
    @testset "Linear Algebra" begin
        a_Massless2D = Massless2D(PVector2D(0.0, 0.0), PVector2D(), 1)
        b_Massless2D = Massless2D(PVector2D(3.0, 4.0), PVector2D(), 2)

        @test distance(a_Massless2D, b_Massless2D) == 5.0


        a_Ball2D = Ball2D(PVector2D(0.0u"m", 0.0u"m"), PVector2D(u"m/s"), PVector2D(u"m/s^2"), 0.0u"kg", 1)
        b_Ball2D = Ball2D(PVector2D(3.0u"m", 4.0u"m"), PVector2D(u"m/s"), PVector2D(u"m/s^2"), 0.0u"kg", 2)

        @test distance(a_Ball2D, b_Ball2D) == 5.0u"m"

        
        a_Star2D = Star2D()
        b_Star2D = Star2D()
        b_Star2D.Pos = PVector2D(3.0u"m", 4.0u"m")
        @test distance(a_Star2D, b_Star2D) == 5.0u"m"


        a_SPHGas2D = SPHGas2D()
        b_SPHGas2D = SPHGas2D()
        b_SPHGas2D.Pos = PVector2D(3.0u"m", 4.0u"m")
        @test distance(a_SPHGas2D, b_SPHGas2D) == 5.0u"m"
    end

    @testset "Random" begin
        # Non-unit
        a_non = rand_pvector2d(5)
        p_Massless2D = [Massless2D() for i=1:5]
        assign_points(p_Massless2D, :Pos, a_non)
        @test p_Massless2D[1].Pos == a_non[1]

        # Unitful
        a = rand_pvector2d(5, u"m")

        p_Ball2D = [Ball2D() for i=1:5]
        assign_points(p_Ball2D, :Pos, a)
        @test p_Ball2D[1].Pos == a[1]

        p_Star2D = [Star2D() for i=1:5]
        assign_points(p_Star2D, :Pos, a)
        @test p_Star2D[1].Pos == a[1]

        p_SPHGas2D = [SPHGas2D() for i=1:5]
        assign_points(p_SPHGas2D, :Pos, a)
        @test p_SPHGas2D[1].Pos == a[1]
    end

    # Do not repeat on all particle types here 
    # since the Random section has already tested basic constructions.
    @testset "Extent" begin
        p_non = [Massless2D(PVector2D(-1.0, 1.0), PVector2D(), 1), 
                 Massless2D(PVector2D(1.0, -1.0), PVector2D(), 2)]

        @test min_x(p_non) == -1.0
        @test min_y(p_non) == -1.0
        @test max_x(p_non) == 1.0
        @test max_y(p_non) == 1.0
        @test center_x(p_non) == 0.0
        @test center_y(p_non) == 0.0
        @test center(p_non) == PVector2D(0.0, 0.0)

        @test extent(p_non) == Extent2D(-1.0, 1.0, -1.0, 1.0, 2.0, PVector2D(), PVector(-1.0, -1.0))

        p = [Ball2D(PVector2D(-1.0u"m", 1.0u"m"), PVector2D(u"m/s"), PVector2D(u"m/s^2"), 1.0u"kg", 1), 
             Ball2D(PVector2D(1.0u"m", -1.0u"m"), PVector2D(u"m/s"), PVector2D(u"m/s^2"), 1000.0u"g", 2)]

        @test min_x(p) == -1.0u"m"
        @test min_y(p) == -1.0u"m"
        @test max_x(p) == 1.0u"m"
        @test max_y(p) == 1.0u"m"
        @test center_x(p) == 0.0u"m"
        @test center_y(p) == 0.0u"m"
        @test center(p) == PVector2D(0.0u"m", 0.0u"m")

        @test extent(p) == Extent2D(-1.0u"m", 1.0u"m", -1.0u"m", 1.0u"m", 2.0u"m", PVector2D(u"m"), PVector(-1.0, -1.0, u"m"))
        @test mass_center(p) == PVector2D(u"m")
    end
end

@testset "3D particles" begin
    @testset "Linear Algebra" begin
        a_Massless = Massless(PVector(0.0, 0.0, 0.0), PVector(), 1)
        b_Massless = Massless(PVector(3.0, 4.0, 12.0), PVector(), 2)

        @test distance(a_Massless, b_Massless) == 13.0


        a_Ball = Ball(PVector(0.0u"m", 0.0u"m", 0.0u"m"), PVector(u"m/s"), PVector(u"m/s^2"), 0.0u"kg", 1)
        b_Ball = Ball(PVector(3.0u"m", 4.0u"m", 12.0u"m"), PVector(u"m/s"), PVector(u"m/s^2"), 0.0u"kg", 2)

        @test distance(a_Ball, b_Ball) == 13.0u"m"

        
        a_Star = Star()
        b_Star = Star()
        b_Star.Pos = PVector(3.0u"m", 4.0u"m", 12.0u"m")
        @test distance(a_Star, b_Star) == 13.0u"m"


        a_SPHGas = SPHGas()
        b_SPHGas = SPHGas()
        b_SPHGas.Pos = PVector(3.0u"m", 4.0u"m", 12.0u"m")
        @test distance(a_SPHGas, b_SPHGas) == 13.0u"m"
    end

    @testset "Random" begin
        # Non-unit
        a_non = rand_pvector(5)
        p_Massless = [Massless() for i=1:5]
        assign_points(p_Massless, :Pos, a_non)
        @test p_Massless[1].Pos == a_non[1]

        # Unitful
        a = rand_pvector(5, u"m")

        p_Ball = [Ball() for i=1:5]
        assign_points(p_Ball, :Pos, a)
        @test p_Ball[1].Pos == a[1]

        p_Star = [Star() for i=1:5]
        assign_points(p_Star, :Pos, a)
        @test p_Star[1].Pos == a[1]

        p_SPHGas = [SPHGas() for i=1:5]
        assign_points(p_SPHGas, :Pos, a)
        @test p_SPHGas[1].Pos == a[1]
    end

    # Do not repeat on all particle types here 
    # since the Random section has already tested basic constructions.
    @testset "Extent" begin
        p = [Massless(PVector(-1.0, 1.0, 1.0), PVector(), 1), 
             Massless(PVector(1.0, -1.0, -1.0), PVector(), 2)]

        @test min_x(p) == -1.0
        @test min_y(p) == -1.0
        @test min_z(p) == -1.0
        @test max_x(p) == 1.0
        @test max_y(p) == 1.0
        @test max_z(p) == 1.0
        @test center_x(p) == 0.0
        @test center_y(p) == 0.0
        @test center_z(p) == 0.0
        @test center(p) == PVector(0.0, 0.0, 0.0)

        @test extent(p) == Extent(-1.0, 1.0, -1.0, 1.0, -1.0, 1.0, 2.0, PVector(), PVector(-1.0, -1.0, -1.0))


        p = [Ball(PVector(-1.0u"m", 1.0u"m", 1.0u"m"), PVector(u"m/s"), PVector(u"m/s^2"), 1.0u"kg", 1), 
             Ball(PVector(1.0u"m", -1.0u"m", -1.0u"m"), PVector(u"m/s"), PVector(u"m/s^2"), 1000.0u"g", 2)]

        @test min_x(p) == -1.0u"m"
        @test min_y(p) == -1.0u"m"
        @test min_z(p) == -1.0u"m"
        @test max_x(p) == 1.0u"m"
        @test max_y(p) == 1.0u"m"
        @test max_z(p) == 1.0u"m"
        @test center_x(p) == 0.0u"m"
        @test center_y(p) == 0.0u"m"
        @test center_z(p) == 0.0u"m"
        @test center(p) == PVector(0.0u"m", 0.0u"m", 0.0u"m")

        @test extent(p) == Extent(-1.0u"m", 1.0u"m", -1.0u"m", 1.0u"m", -1.0u"m", 1.0u"m", 2.0u"m", PVector(u"m"), PVector(-1.0, -1.0, -1.0, u"m"))
        @test mass_center(p) == PVector(u"m")
    end
end