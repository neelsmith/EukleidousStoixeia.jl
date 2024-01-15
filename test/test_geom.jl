@testset "Test constructors for basic Euclidean geometric types" begin
    x1 = rand(Float64, 1)[1]
    y1 = rand(Float64, 1)[1]
    ptA = EuclidPoint(x1,y1)
    @test ptA isa EuclidPoint
    geomPoint = Point(x1,y1)
    @test euclidPoint(geomPoint) isa EuclidPoint


    x2 = rand(Float64, 1)[1]
    y2 = rand(Float64, 1)[1]
    ptB = EuclidPoint(x2,y2)

    lineseg = EuclidLineSegment(ptA, ptB)
    @test lineseg isa EuclidLineSegment
    @test seglength(lineseg) >= 0


    circle = EuclidCircle(ptA, 1)
    @test circle isa EuclidCircle
    @test euclidCircle(ptA, lineseg) isa EuclidCircle
    @test euclidCircle(geomPoint, 1) isa EuclidCircle
    @test euclidCircle(geomPoint, lineseg) isa EuclidCircle

        
    x3 = rand(Float64, 1)[1]
    y3 = rand(Float64, 1)[1]
    ptC = EuclidPoint(x3,y3) 

    triangle = EuclidTriangle(ptA, ptB, ptC)
    @test triangle isa EuclidTriangle

    angle = EuclidAngle(ptA, ptB, ptC)
    @test angle isa EuclidAngle

end


@testset "Test functions on angles" begin
    a = EuclidPoint(1,0)
    b = EuclidPoint(0,0)
    c = EuclidPoint(0,1)
    angle = EuclidAngle(a,b,c)

    @test deg(angle) ≈ 45
    @test round(rad(angle), digits = 4) == 0.7854
end