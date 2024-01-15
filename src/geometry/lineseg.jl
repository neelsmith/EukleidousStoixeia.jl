
struct EuclidLineSegment
    a::EuclidPoint
    b::EuclidPoint
end


function seglength(seg::EuclidLineSegment)
    xs = (seg.a.x - seg.b.x)^2
    ys =  (seg.a.y - seg.b.y)^2
    sqrt(xs + ys)
end

