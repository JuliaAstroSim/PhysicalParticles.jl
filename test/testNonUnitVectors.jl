# test Point2D, Point3D

@testset "2D Points" begin
    a = Point2D(1.0f0, 2.0f0)
    b = Point2D(3.0, 4.0)
    #c = Point2D(BigFloat(5.0), BigFloat(6.0))

    @testset "Basic" begin
        @test a + b == Point2D(4.0, 6.0)
        @test b - a == Point(2.0, 2.0)
        #@test b + c == Point2D(BigFloat(8.0), BigFloat(10.0))
        #@test c - a == Point2D(BigFloat(4.0), BigFloat(4.0))

        @test a * b == 11.0
        @test 3.0 * b == Point2D(9.0, 12.0)
        @test b * 3.0 == Point2D(9.0, 12.0)
        #@test c * 2.0 == Point2D(BigFloat(10.0), BigFloat(12.0))

        @test b / 2.0 == Point2D(1.5, 2.0)
    end

    @testset "Linear Algebra" begin
        p = [Point2D(1.0, 1.0) for i = 1:5]

        @test norm(Point2D(3.0f0, 4.0f0)) == 5.0f0
        @test norm(Point2D(3.0, 4.0)) == 5.0
        #@test norm(Point2D(3.0, 4.0)) == BigFloat(5.0)

        @test normalize(Point2D(3.0, 4.0)) == Point2D(0.6, 0.8)

        @test dot(a,a) == 5.0f0

        @test mean(p) == Point2D(1.0, 1.0)

        @test distance(Point2D(0.0f0, 0.0f0), Point2D(3.0f0, 4.0f0)) == 5.0f0
        @test distance(Point2D(0.0, 0.0), Point2D(3.0, 4.0)) == 5.0

        @test rotate(Point(1.0, 0.0), 0.5pi) * Point(1.0, 0.0) < 1.0e-10
        @test rotate_z(Point(1.0, 0.0), 0.5pi) * Point(1.0, 0.0) < 1.0e-10
    end

    @testset "Conversion" begin
        @test npconvert([1.0, 2.0]) == Point2D(1.0, 2.0)

        @test npconvert([1.0 3.0; 2.0 4.0]) == [Point2D(1.0, 2.0), Point2D(3.0, 4.0)]
    end
end

@testset "3D Points" begin
    a = Point3D(1.0f0, 2.0f0, 3.0f0)
    b = Point(4.0, 5.0, 6.0)

    @testset "Basic" begin
        @test a + b == Point3D(5.0, 7.0, 9.0)
        @test b - a == Point3D(3.0, 3.0, 3.0)

        @test a * b == 32.0
        @test 3.0 * b == Point(12.0, 15.0, 18.0)
        @test b * 3.0 == Point(12.0, 15.0, 18.0)

        @test b / 2.0 == Point(2.0, 2.5, 3.0)
    end

    @testset "Linear Algebra" begin
        p = [Point3D(1.0, 1.0, 1.0) for i = 1:5]

        @test norm(Point3D(3.0f0, 4.0f0, 12.0f0)) == 13.0f0
        @test norm(Point(3.0, 4.0, 12.0)) == 13.0

        @test normalize(Point(3.0, 4.0, 12.0)) == Point(3.0, 4.0, 12.0) / 13.0

        @test dot(a,a) == 14.0f0

        @test mean(p) == Point3D(1.0, 1.0, 1.0)

        @test distance(Point3D(0.0f0, 0.0f0, 0.0f0), Point3D(3.0f0, 4.0f0, 12.0f0)) == 13.0f0
        @test distance(Point3D(0.0, 0.0, 0.0), Point3D(3.0, 4.0, 12.0)) == 13.0

        @test norm(rotate_x(Point(0.0, 1.0, 0.0), 0.5pi) - Point(0.0, 0.0, 1.0)) < 1.0e-10
        @test norm(rotate_y(Point(1.0, 0.0, 0.0), 0.5pi) - Point(0.0, 0.0, -1.0)) < 1.0e-10
        @test norm(rotate_z(Point(1.0, 0.0, 0.0), 0.5pi) - Point(0.0, 1.0, 0.0)) < 1.0e-10

        @test cross(Point(1.0, 0.0, 0.0), Point(0.0, 1.0, 0.0)) == Point(0.0, 0.0, 1.0)
    end

    @testset "Conversion" begin
        @test npconvert([1.0, 2.0, 3.0]) == Point3D(1.0, 2.0, 3.0)

        @test npconvert([1.0 4.0;
                         2.0 5.0;
                         3.0 6.0]) == [Point(1.0, 2.0, 3.0), Point(4.0, 5.0, 6.0)]
    end
end