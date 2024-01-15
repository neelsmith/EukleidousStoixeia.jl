#=
Types for Euclid, Elements 1:

1. point (use Julia's GeometryBasics.Point)
2. line segment
3. circle
4. angle

=#


struct EuclidLineSegment
    a::Point
    b::Point
end

struct EuclidTriangle
    a::Point
    b::Point
    c::Point
end

struct EuclidCircle
    center::Point
    radius::Real    
end

struct EuclidAngle
    a::Point
    b::Point
    c::Point
end


"""X value of a `GeometryBasics.Point`.
"""
function ptx(pt::Point)
	pt.data[1]
end

"""Y value of a `GeometryBasics.Point`.
"""
function pty(pt::Point)
	pt.data[2]
end

function seglength(seg::EuclidLineSegment)
    xs = (ptx(seg.a) - ptx(seg.b))^2
    ys =  (pty(seg.a) - ptx(seg.y))^2
    sqrt(xs + ys)
end

function euclidCircle(c::Point, seg::EuclidLineSegment)
    EuclidCircle(c, seglength(seg))
end