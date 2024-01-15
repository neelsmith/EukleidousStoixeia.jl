@testset "Test constructors for basic Euclidean geometric types" begin
    x1 = rand(Float64, 1)
    y1 = rand(Float64, 1)
    ptA = Point(x1,y1)
    @test ptA isa Point

    x2 = rand(Float64, 1)
    y2 = rand(Float64, 1)
    ptB = Point(x2,y2)

    lineseg = EuclidLineSegment(ptA, ptB)
    @test lineseg isa EuclidLineSegment

    circle = EuclidCircle(ptA, 1)
    @test circle isa EuclidCircle
    @test euclidCircle(ptA, lineseg) isa EuclidCircle

        
    x3 = rand(Float64, 1)
    y3 = rand(Float64, 1)
    ptC = Point(x3,y3) 

    triangle = EuclidTriangle(ptA, ptB, ptC)
    @test triangle isa EuclidTriangle

    angle = EuclidAngle(ptA, ptB, ptC)
    @test angle isa EuclidAngle

end
