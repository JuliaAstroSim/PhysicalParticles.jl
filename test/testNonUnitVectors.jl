# test PVector2D, PVector

@testset "2D Points" begin
    a = PVector2D(1.0f0, 2.0f0)
    b = PVector2D(3.0, 4.0)
    #c = PVector2D(BigFloat(5.0), BigFloat(6.0))

    @testset "Basic" begin
        @test a + b == PVector2D(4.0, 6.0)
        @test b - a == PVector(2.0, 2.0)
        #@test b + c == PVector2D(BigFloat(8.0), BigFloat(10.0))
        #@test c - a == PVector2D(BigFloat(4.0), BigFloat(4.0))

        @test a * b == 11.0
        @test 3.0 * b == PVector2D(9.0, 12.0)
        @test b * 3.0 == PVector2D(9.0, 12.0)
        #@test c * 2.0 == PVector2D(BigFloat(10.0), BigFloat(12.0))

        @test b / 2.0 == PVector2D(1.5, 2.0)

        @test PVector(0.0, 0.0, nothing) == PVector2D()
        @test PVector2D(0.0, 0.0, nothing) == PVector2D()
        @test PVector2D(nothing) == PVector2D()
    end

    @testset "Linear Algebra" begin
        p = [PVector2D(1.0, 1.0) for i = 1:5]

        @test norm(PVector2D(3.0f0, 4.0f0)) == 5.0f0
        @test norm(PVector2D(3.0, 4.0)) == 5.0
        #@test norm(PVector2D(3.0, 4.0)) == BigFloat(5.0)

        @test normalize(PVector2D(3.0, 4.0)) == PVector2D(0.6, 0.8)

        @test dot(a,a) == 5.0f0

        @test mean(p) == PVector2D(1.0, 1.0)

        @test distance(PVector2D(0.0f0, 0.0f0), PVector2D(3.0f0, 4.0f0)) == 5.0f0
        @test distance(PVector2D(0.0, 0.0), PVector2D(3.0, 4.0)) == 5.0

        @test rotate(PVector(1.0, 0.0), 0.5pi) * PVector(1.0, 0.0) < 1.0e-10
        @test rotate_z(PVector(1.0, 0.0), 0.5pi) * PVector(1.0, 0.0) < 1.0e-10
    end

    @testset "Center" begin
        p = [PVector2D(-1.0, 1.0), PVector2D(1.0, -1.0)]

        @test min_x(p) == -1.0
        @test min_y(p) == -1.0
        @test max_x(p) == 1.0
        @test max_y(p) == 1.0
        @test center_x(p) == 0.0
        @test center_y(p) == 0.0
        @test center(p) == PVector2D(0.0, 0.0)
    end

    @testset "Conversion" begin
        @test pconvert([1.0, 2.0]) == PVector2D(1.0, 2.0)

        @test pconvert([1.0 3.0; 2.0 4.0]) == [PVector2D(1.0, 2.0), PVector2D(3.0, 4.0)]

        @test_throws ErrorException pconvert([1.0, 2.0, 3.0, 4.0])

        @test_throws ErrorException pconvert([1.0 5.0;
                                              2.0 6.0;
                                              3.0 7.0;
                                              4.0 8.0])
    end
end

@testset "3D Points" begin
    a = PVector(1.0f0, 2.0f0, 3.0f0)
    b = PVector(4.0, 5.0, 6.0)

    @testset "Basic" begin
        @test a + b == PVector(5.0, 7.0, 9.0)
        @test b - a == PVector(3.0, 3.0, 3.0)

        @test a * b == 32.0
        @test 3.0 * b == PVector(12.0, 15.0, 18.0)
        @test b * 3.0 == PVector(12.0, 15.0, 18.0)

        @test b / 2.0 == PVector(2.0, 2.5, 3.0)

        @test PVector(0.0, 0.0, 0.0, nothing) == PVector()
        @test PVector(nothing) == PVector()
    end

    @testset "Linear Algebra" begin
        p = [PVector(1.0, 1.0, 1.0) for i = 1:5]

        @test norm(PVector(3.0f0, 4.0f0, 12.0f0)) == 13.0f0
        @test norm(PVector(3.0, 4.0, 12.0)) == 13.0

        @test normalize(PVector(3.0, 4.0, 12.0)) == PVector(3.0, 4.0, 12.0) / 13.0

        @test dot(a,a) == 14.0f0

        @test mean(p) == PVector(1.0, 1.0, 1.0)

        @test distance(PVector(0.0f0, 0.0f0, 0.0f0), PVector(3.0f0, 4.0f0, 12.0f0)) == 13.0f0
        @test distance(PVector(0.0, 0.0, 0.0), PVector(3.0, 4.0, 12.0)) == 13.0

        @test norm(rotate_x(PVector(0.0, 1.0, 0.0), 0.5pi) - PVector(0.0, 0.0, 1.0)) < 1.0e-10
        @test norm(rotate_y(PVector(1.0, 0.0, 0.0), 0.5pi) - PVector(0.0, 0.0, -1.0)) < 1.0e-10
        @test norm(rotate_z(PVector(1.0, 0.0, 0.0), 0.5pi) - PVector(0.0, 1.0, 0.0)) < 1.0e-10

        @test cross(PVector(1.0, 0.0, 0.0), PVector(0.0, 1.0, 0.0)) == PVector(0.0, 0.0, 1.0)
    end

    @testset "Center" begin
        p = [PVector(-1.0, 1.0, 1.0), PVector(1.0, -1.0, -1.0)]

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
    end

    @testset "Conversion" begin
        @test pconvert([1.0, 2.0, 3.0]) == PVector(1.0, 2.0, 3.0)

        @test pconvert([1.0 4.0;
                         2.0 5.0;
                         3.0 6.0]) == [PVector(1.0, 2.0, 3.0), PVector(4.0, 5.0, 6.0)]
    end
end