# Predefined Test Data
array2d = [1.0 2.0 3.0 4.0 5.0;
           6.0 7.0 8.0 9.0 10.0]
array3d = [1.0 2.0 3.0 4.0 5.0;
           6.0 7.0 8.0 9.0 10.0;
           11.0 12.0 13.0 14.0 15.0]

@testset "2D Points" begin
    a = Point2D(1.0f0, 2.0f0)
    b = Point2D(3.0, 4.0)
    #c = Point2D(BigFloat(5.0), BigFloat(6.0))

    @testset "Basic" begin
        @test a + b == Point2D(4.0, 6.0)
        #@test b + c == Point2D(BigFloat(8.0), BigFloat(10.0))
        #@test c - a == Point2D(BigFloat(4.0), BigFloat(4.0))

        @test a * b == 11.0
        @test 3.0 * b == Point2D(9.0, 12.0)
        #@test c * 2.0 == Point2D(BigFloat(10.0), BigFloat(12.0))

        @test b / 2.0 == Point2D(1.5, 2.0)
    end

    @testset "Linear Algebra" begin
        @test norm(Point2D(3.0f0, 4.0f0)) == 5.0f0
        @test norm(Point2D(3.0, 4.0)) == 5.0
        #@test norm(Point2D(3.0, 4.0)) == BigFloat(5.0)

        @test normalize(Point2D(3.0, 4.0)) == Point2D(0.6, 0.8)

        @test rotate(Point(1.0, 0.0), 0.5pi) * Point(1.0, 0.0) < 1.0e-10
        @test rotate_z(Point(1.0, 0.0), 0.5pi) * Point(1.0, 0.0) < 1.0e-10
    end
end
