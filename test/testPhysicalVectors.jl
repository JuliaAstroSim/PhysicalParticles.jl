# Test PVector2D, PVector

@testset "2D Physical Vectors" begin
    a = PVector2D(1.0f0u"m", 2.0f0u"m")
    b = PVector2D(3.0u"m", 4.0u"m")

    @testset "Basic" begin
        @test PVector(0.0, 0.0, u"m") == PVector2D(u"m")
        @test PVector(1.0, 2.0, u"m") == PVector2D(1.0, 2.0, u"m")

        @test a + b == PVector2D(4.0u"m", 6.0u"m")
        @test b - a == PVector(2.0u"m", 2.0u"m")
        
        @test a * b == 11.0u"m^2"
        @test 3.0 * b == PVector2D(9.0u"m", 12.0u"m")
        @test b * 3.0 == PVector2D(9.0u"m", 12.0u"m")
        
        @test b / 2.0 == PVector2D(1.5u"m", 2.0u"m")

        # Quantity multiplication and division
        @test 3.0u"s" * b == PVector2D(9.0u"m * s", 12.0u"m * s")
        @test b * 3.0u"s" == PVector2D(9.0u"m * s", 12.0u"m * s")
        
        @test b / 2.0u"s" == PVector2D(1.5u"m / s", 2.0u"m / s")
    end

    @testset "Linear Algebra" begin
        p = [PVector2D(1.0u"m", 1.0u"m") for i = 1:5]
        
        @test norm(PVector2D(3.0f0u"m", 4.0f0u"m")) == 5.0f0u"m"
        @test norm(PVector2D(3.0u"m", 4.0u"m")) == 5.0u"m"
        
        @test normalize(PVector2D(3.0u"m", 4.0u"m")) == PVector2D(0.6u"m", 0.8u"m")
        
        @test dot(a,a) == 5.0f0u"m^2"
        
        @test mean(p) == PVector2D(1.0u"m", 1.0u"m")

        @test median(
            [PVector2D(1.0, 4.0, u"m"), PVector2D(2.0, 2.0, u"m"), PVector2D(4.0, 1.0, u"m")]
        ) == PVector2D(2.0, 2.0, u"m")

        @test median(
            Dict("data" => [PVector2D(1.0, 4.0, u"m"), PVector2D(2.0, 2.0, u"m"), PVector2D(4.0, 1.0, u"m")])
        ) == PVector2D(2.0, 2.0, u"m")

        @test median(
            Dict("data" => [PVector2D(1.0, 4.0, u"m"), PVector2D(2.0, 2.0, u"m"), PVector2D(4.0, 1.0, u"m")]), :x
        ) == 2.0u"m"
        
        @test rotate(PVector(1.0u"m", 0.0u"m"), 0.5pi) * PVector(1.0u"m", 0.0u"m") < 1.0e-10u"m^2"
        @test rotate_z(PVector(1.0u"m", 0.0u"m"), 0.5pi) * PVector(1.0u"m", 0.0u"m") < 1.0e-10u"m^2"

        @test rotate(PVector(1.0u"m", 0.0u"m"), 90.0u"°") * PVector(1.0u"m", 0.0u"m") < 1.0e-10u"m^2"
        @test rotate_z(PVector(1.0u"m", 0.0u"m"), 90.0u"°") * PVector(1.0u"m", 0.0u"m") < 1.0e-10u"m^2"
    end

    @testset "Center" begin
        p = [PVector2D(-1.0u"m", 1.0u"m"), PVector2D(1.0u"m", -1.0u"m")]

        @test minimum_x(p) == -1.0u"m"
        @test minimum_y(p) == -1.0u"m"
        @test maximum_x(p) == 1.0u"m"
        @test maximum_y(p) == 1.0u"m"
        @test center_x(p) == 0.0u"m"
        @test center_y(p) == 0.0u"m"
        @test center(p) == PVector2D(0.0u"m", 0.0u"m")
    end
    
    @testset "Conversion" begin
        @test pconvert([1.0u"m", 2.0u"m"]) == PVector2D(1.0u"m", 2.0u"m")
        
        @test pconvert([1.0u"m" 3.0u"m"; 2.0u"m" 4.0u"m"]) == [PVector2D(1.0u"m", 2.0u"m"), PVector2D(3.0u"m", 4.0u"m")]
    end
end


@testset "3D Physical Vectors" begin
    a = PVector(1.0f0u"m", 2.0f0u"m", 3.0f0u"m")
    b = PVector(4.0u"m", 5.0u"m", 6.0u"m")

    @testset "Basic" begin
        @test PVector(u"m") == PVector(u"m")
        @test PVector(1.0, 2.0, 3.0, u"m") == PVector(1.0, 2.0, 3.0, u"m")

        @test a + b == PVector(5.0u"m", 7.0u"m", 9.0u"m")
        @test b - a == PVector(3.0u"m", 3.0u"m", 3.0u"m")

        @test a * b == 32.0u"m^2"
        @test 3.0 * b == PVector(12.0u"m", 15.0u"m", 18.0u"m")
        @test b * 3.0 == PVector(12.0u"m", 15.0u"m", 18.0u"m")

        @test b / 2.0 == PVector(2.0u"m", 2.5u"m", 3.0u"m")

        # Quantity multiplication and division
        @test 3.0u"s" * b == PVector(12.0u"m * s", 15.0u"m * s", 18.0u"m * s")
        @test b * 3.0u"s" == PVector(12.0u"m * s", 15.0u"m * s", 18.0u"m * s")

        @test b / 2.0u"s" == PVector(2.0u"m / s", 2.5u"m / s", 3.0u"m / s")
    end

    @testset "Linear Algebra" begin
        p = [PVector(1.0u"m", 1.0u"m", 1.0u"m") for i = 1:5]

        @test norm(PVector(3.0f0u"m", 4.0f0u"m", 12.0f0u"m")) == 13.0f0u"m"
        @test norm(PVector(3.0u"m", 4.0u"m", 12.0u"m")) == 13.0u"m"

        @test normalize(PVector(3.0u"m", 4.0u"m", 12.0u"m")) == PVector(3.0u"m", 4.0u"m", 12.0u"m") / 13.0

        @test dot(a,a) == 14.0f0u"m^2"

        @test mean(p) == PVector(1.0u"m", 1.0u"m", 1.0u"m")

        @test median(
            [PVector(1.0, 4.0, 0.0, u"m"), PVector(2.0, 2.0, 0.0, u"m"), PVector(4.0, 1.0, 0.0, u"m")]
        ) == PVector(2.0, 2.0, 0.0, u"m")

        @test median(
            Dict("data" => [PVector(1.0, 4.0, 0.0, u"m"), PVector(2.0, 2.0, 0.0, u"m"), PVector(4.0, 1.0, 0.0, u"m")])
        ) == PVector(2.0, 2.0, 0.0, u"m")

        @test median(
            Dict("data" => [PVector(1.0, 4.0, 0.0, u"m"), PVector(2.0, 2.0, 0.0, u"m"), PVector(4.0, 1.0, 0.0, u"m")]), :x
        ) == 2.0u"m"

        @test norm(rotate_x(PVector(0.0u"m", 1.0u"m", 0.0u"m"), 0.5pi) - PVector(0.0u"m", 0.0u"m", 1.0u"m")) < 1.0e-10u"m"
        @test norm(rotate_y(PVector(1.0u"m", 0.0u"m", 0.0u"m"), 0.5pi) - PVector(0.0u"m", 0.0u"m", -1.0u"m")) < 1.0e-10u"m"
        @test norm(rotate_z(PVector(1.0u"m", 0.0u"m", 0.0u"m"), 0.5pi) - PVector(0.0u"m", 1.0u"m", 0.0u"m")) < 1.0e-10u"m"

        @test norm(rotate_x(PVector(0.0u"m", 1.0u"m", 0.0u"m"), 90.0u"°") - PVector(0.0u"m", 0.0u"m", 1.0u"m")) < 1.0e-10u"m"
        @test norm(rotate_y(PVector(1.0u"m", 0.0u"m", 0.0u"m"), 90.0u"°") - PVector(0.0u"m", 0.0u"m", -1.0u"m")) < 1.0e-10u"m"
        @test norm(rotate_z(PVector(1.0u"m", 0.0u"m", 0.0u"m"), 90.0u"°") - PVector(0.0u"m", 1.0u"m", 0.0u"m")) < 1.0e-10u"m"

        @test cross(PVector(1.0u"m", 0.0u"m", 0.0u"m"), PVector(0.0u"m", 1.0u"m", 0.0u"m")) == PVector(0.0u"m^2", 0.0u"m^2", 1.0u"m^2")
    end

    @testset "Center" begin
        p = [PVector(-1.0u"m", 1.0u"m", 1.0u"m"), PVector(1.0u"m", -1.0u"m", -1.0u"m")]

        @test minimum_x(p) == -1.0u"m"
        @test minimum_y(p) == -1.0u"m"
        @test minimum_z(p) == -1.0u"m"
        @test maximum_x(p) == 1.0u"m"
        @test maximum_y(p) == 1.0u"m"
        @test maximum_z(p) == 1.0u"m"
        @test center_x(p) == 0.0u"m"
        @test center_y(p) == 0.0u"m"
        @test center_z(p) == 0.0u"m"
        @test center(p) == PVector(0.0u"m", 0.0u"m", 0.0u"m")
    end

    @testset "Conversion" begin
        @test pconvert([1.0u"m", 2.0u"m", 3.0u"m"]) == PVector(1.0u"m", 2.0u"m", 3.0u"m")

        @test pconvert([1.0u"m" 4.0u"m";
                        2.0u"m" 5.0u"m";
                        3.0u"m" 6.0u"m"]) == [PVector(1.0u"m", 2.0u"m", 3.0u"m"), PVector(4.0u"m", 5.0u"m", 6.0u"m")]
    end
end
