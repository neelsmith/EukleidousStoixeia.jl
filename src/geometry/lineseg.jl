"""Implementation of Euclid 1.definitions.2."""
struct EuclidLineSegment
    a::EuclidPoint
    b::EuclidPoint
end


"""True if coresponding end points of each segment are equal.
$(SIGNATURES)
"""
function ==(s1::EuclidLineSegment, s2::EuclidLineSegment)
    s1.a == s2.a && s1.b == s2.b
end

"""Find length of a line segment.
$(SIGNATURES)
"""
function seglength(seg::EuclidLineSegment)
    xs = (seg.a.x - seg.b.x)^2
    ys =  (seg.a.y - seg.b.y)^2
    sqrt(xs + ys)
end

"""???"""
function normed(seg::EuclidLineSegment)
    norm([seg.b.x - seg.a.x, seg.b.y, - seg.b.x])
end

function unitvect(seg::EuclidLineSegment)

end

"""Represent a line segment as a vector of real numbers.
$(SIGNATURES)
"""
function vect(seg::EuclidLineSegment)
    magn = seglength(seg)
    direction = atan(seb)
    #[seg.a.x, seg.a.y, seg.b.x, seg.b.y]

end