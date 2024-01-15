
"""Representation in a Cartesian plane of Euclid 1.defintions.1."""
struct EuclidPoint
    x::Real
    y::Real
end

"""True if two points have equal X and Y values.
$(SIGNATURES)
"""
function ==(pt1::EuclidPoint, pt2::EuclidPoint)
    pt1.x == pt2.x && pt1.y == pt2.y
end

"""Construct a `EuclidPoint` from a `GeometryBasics.Point`.
$(SIGNATURES)
"""
function euclidPoint(p::Point)
    EuclidPoint(ptx(p), pty(p))
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
