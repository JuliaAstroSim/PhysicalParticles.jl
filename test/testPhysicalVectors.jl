# Test PhysicalVector2D, PhysicalVector3D

@testset "2D Physical Vectors" begin
    a = PhysicalVector2D(1.0f0u"m", 2.0f0u"m")
    b = PhysicalVector2D(3.0u"m", 4.0u"m")

    @testset "Basic" begin
        @test a + b == PhysicalVector2D(4.0u"m", 6.0u"m")
        @test b - a == PhysicalVector(2.0u"m", 2.0u"m")
        
        @test a * b == 11.0u"m^2"
        @test 3.0 * b == PhysicalVector2D(9.0u"m", 12.0u"m")
        @test b * 3.0 == PhysicalVector2D(9.0u"m", 12.0u"m")
        
        @test b / 2.0 == PhysicalVector2D(1.5u"m", 2.0u"m")

        # Quantity multiplication and division
        @test 3.0u"s" * b == PhysicalVector2D(9.0u"m * s", 12.0u"m * s")
        @test b * 3.0u"s" == PhysicalVector2D(9.0u"m * s", 12.0u"m * s")
        
        @test b / 2.0u"s" == PhysicalVector2D(1.5u"m / s", 2.0u"m / s")
    end

    @testset "Linear Algebra" begin
        p = [PhysicalVector2D(1.0u"m", 1.0u"m") for i = 1:5]
        
        @test norm(PhysicalVector2D(3.0f0u"m", 4.0f0u"m")) == 5.0f0u"m"
        @test norm(PhysicalVector2D(3.0u"m", 4.0u"m")) == 5.0u"m"
        
        @test normalize(PhysicalVector2D(3.0u"m", 4.0u"m")) == PhysicalVector2D(0.6u"m", 0.8u"m")
        
        @test dot(a,a) == 5.0f0u"m^2"
        
        @test mean(p) == PhysicalVector2D(1.0u"m", 1.0u"m")
        
        @test rotate(PhysicalVector(1.0u"m", 0.0u"m"), 0.5pi) * PhysicalVector(1.0u"m", 0.0u"m") < 1.0e-10u"m^2"
        @test rotate_z(PhysicalVector(1.0u"m", 0.0u"m"), 0.5pi) * PhysicalVector(1.0u"m", 0.0u"m") < 1.0e-10u"m^2"

        @test rotate(PhysicalVector(1.0u"m", 0.0u"m"), 90.0u"°") * PhysicalVector(1.0u"m", 0.0u"m") < 1.0e-10u"m^2"
        @test rotate_z(PhysicalVector(1.0u"m", 0.0u"m"), 90.0u"°") * PhysicalVector(1.0u"m", 0.0u"m") < 1.0e-10u"m^2"
    end
    
    @testset "Conversion" begin
        @test npconvert([1.0u"m", 2.0u"m"]) == PhysicalVector2D(1.0u"m", 2.0u"m")
        
        @test npconvert([1.0u"m" 3.0u"m"; 2.0u"m" 4.0u"m"]) == [PhysicalVector2D(1.0u"m", 2.0u"m"), PhysicalVector2D(3.0u"m", 4.0u"m")]
    end
end


@testset "3D Physical Vectors" begin
    a = PhysicalVector3D(1.0f0u"m", 2.0f0u"m", 3.0f0u"m")
    b = PhysicalVector(4.0u"m", 5.0u"m", 6.0u"m")

    @testset "Basic" begin
        @test a + b == PhysicalVector3D(5.0u"m", 7.0u"m", 9.0u"m")
        @test b - a == PhysicalVector3D(3.0u"m", 3.0u"m", 3.0u"m")

        @test a * b == 32.0u"m^2"
        @test 3.0 * b == PhysicalVector(12.0u"m", 15.0u"m", 18.0u"m")
        @test b * 3.0 == PhysicalVector(12.0u"m", 15.0u"m", 18.0u"m")

        @test b / 2.0 == PhysicalVector(2.0u"m", 2.5u"m", 3.0u"m")

        # Quantity multiplication and division
        @test 3.0u"s" * b == PhysicalVector(12.0u"m * s", 15.0u"m * s", 18.0u"m * s")
        @test b * 3.0u"s" == PhysicalVector(12.0u"m * s", 15.0u"m * s", 18.0u"m * s")

        @test b / 2.0u"s" == PhysicalVector(2.0u"m / s", 2.5u"m / s", 3.0u"m / s")
    end

    @testset "Linear Algebra" begin
        p = [PhysicalVector3D(1.0u"m", 1.0u"m", 1.0u"m") for i = 1:5]

        @test norm(PhysicalVector3D(3.0f0u"m", 4.0f0u"m", 12.0f0u"m")) == 13.0f0u"m"
        @test norm(PhysicalVector(3.0u"m", 4.0u"m", 12.0u"m")) == 13.0u"m"

        @test normalize(PhysicalVector(3.0u"m", 4.0u"m", 12.0u"m")) == PhysicalVector(3.0u"m", 4.0u"m", 12.0u"m") / 13.0

        @test dot(a,a) == 14.0f0u"m^2"

        @test mean(p) == PhysicalVector3D(1.0u"m", 1.0u"m", 1.0u"m")

        @test norm(rotate_x(PhysicalVector(0.0u"m", 1.0u"m", 0.0u"m"), 0.5pi) - PhysicalVector(0.0u"m", 0.0u"m", 1.0u"m")) < 1.0e-10u"m"
        @test norm(rotate_y(PhysicalVector(1.0u"m", 0.0u"m", 0.0u"m"), 0.5pi) - PhysicalVector(0.0u"m", 0.0u"m", -1.0u"m")) < 1.0e-10u"m"
        @test norm(rotate_z(PhysicalVector(1.0u"m", 0.0u"m", 0.0u"m"), 0.5pi) - PhysicalVector(0.0u"m", 1.0u"m", 0.0u"m")) < 1.0e-10u"m"

        @test norm(rotate_x(PhysicalVector(0.0u"m", 1.0u"m", 0.0u"m"), 90.0u"°") - PhysicalVector(0.0u"m", 0.0u"m", 1.0u"m")) < 1.0e-10u"m"
        @test norm(rotate_y(PhysicalVector(1.0u"m", 0.0u"m", 0.0u"m"), 90.0u"°") - PhysicalVector(0.0u"m", 0.0u"m", -1.0u"m")) < 1.0e-10u"m"
        @test norm(rotate_z(PhysicalVector(1.0u"m", 0.0u"m", 0.0u"m"), 90.0u"°") - PhysicalVector(0.0u"m", 1.0u"m", 0.0u"m")) < 1.0e-10u"m"

        @test cross(PhysicalVector(1.0u"m", 0.0u"m", 0.0u"m"), PhysicalVector(0.0u"m", 1.0u"m", 0.0u"m")) == PhysicalVector(0.0u"m^2", 0.0u"m^2", 1.0u"m^2")
    end

    @testset "Conversion" begin
        @test npconvert([1.0u"m", 2.0u"m", 3.0u"m"]) == PhysicalVector3D(1.0u"m", 2.0u"m", 3.0u"m")

        @test npconvert([1.0u"m" 4.0u"m";
                        2.0u"m" 5.0u"m";
                        3.0u"m" 6.0u"m"]) == [PhysicalVector(1.0u"m", 2.0u"m", 3.0u"m"), PhysicalVector(4.0u"m", 5.0u"m", 6.0u"m")]
    end
end
