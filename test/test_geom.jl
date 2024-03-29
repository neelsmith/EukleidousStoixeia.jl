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

@testset "Test basic relations" begin
    a = EuclidPoint(1.0, 0.0)
    aint = EuclidPoint(1,0)
    @test a == aint

    b = EuclidPoint(0.0, 0.0)
    bint = EuclidPoint(0,0)
    seg = EuclidLineSegment(a,b)
    segint = EuclidLineSegment(aint, bint)

    c = EuclidPoint(0.0, 1.0)
    cint = EuclidPoint(0,1)
    angle = EuclidAngle(a,b,c)
    angleint = EuclidAngle(aint, bint, cint)
    @test angle == angleint


    t_angle = EuclidTriangle(a,b,c)
    t_angleint = EuclidTriangle(aint, bint, cint)
    @test t_angle == t_angleint

    circ = EuclidCircle(b, 1.0)
    circint = EuclidCircle(bint, 1)
    @test circ == circint
end






@testset "Test functions on angles" begin
    a = EuclidPoint(1.0,0.0)
    b = EuclidPoint(0.0,0.0)
    c = EuclidPoint(0.0,1.0)
    angle = EuclidAngle(a,b,c)

    @test deg(angle) ≈ 45
    @test round(rad(angle), digits = 4) == 0.7854

    crd = chord(angle)
    @test crd isa EuclidLineSegment
    @test round(seglength(crd), digits = 4) == 1.4142

    aint = EuclidPoint(1,0)
    bint = EuclidPoint(0,0)
    cint = EuclidPoint(0,1)
    angleint = EuclidAngle(aint,bint,cint)
    @test angle == angleint
end

@testset "Test functions on points" begin
    @test distance(EuclidPoint(0,0), EuclidPoint(0,1)) == 1.0
end

@testset "Test functions on circles" begin

end