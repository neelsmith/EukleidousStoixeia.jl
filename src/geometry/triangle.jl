
"""Implementation of triangle as defined in Euclid 1.definitions.19."""
struct EuclidTriangle
    a::EuclidPoint
    b::EuclidPoint
    c::EuclidPoint
end


"""True if corresponding corners of two triangles are equal.
$(SIGNATURES)
"""
function ==(t1::EuclidTriangle, t2::EuclidTriangle)
    t1.a == t2.a &&
    t1.b == t2.b &&
    t1.c == t2.c
end