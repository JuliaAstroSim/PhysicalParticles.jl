# Predefined Test Data
array2d = [1.0 2.0 3.0 4.0 5.0;
           6.0 7.0 8.0 9.0 10.0]
array3d = [1.0 2.0 3.0 4.0 5.0;
           6.0 7.0 8.0 9.0 10.0;
           11.0 12.0 13.0 14.0 15.0]

@testset "2D Points" begin
    @testset "Get and Set" begin
        @test 1 == 1
    end

    @testset "Basic Maths" begin
        @test 2 == 2
    end
end
