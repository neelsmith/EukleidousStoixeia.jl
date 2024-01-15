
struct EuclidLineSegment
    a::EuclidPoint
    b::EuclidPoint
end


function seglength(seg::EuclidLineSegment)
    xs = (ptx(seg.a) - ptx(seg.b))^2
    ys =  (pty(seg.a) - ptx(seg.y))^2
    sqrt(xs + ys)
end

