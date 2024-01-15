"""Implementation of Euclid 1.definitions.15.
"""
struct EuclidCircle
    center::EuclidPoint
    radius::Real    
end

"""Construct a circle using a point and a line segment.
$(SIGNATURES)
"""
function euclidCircle(c::EuclidPoint, seg::EuclidLineSegment)
    EuclidCircle(c, seglength(seg))
end


"""Construct a circle using a point and a radius length.
$(SIGNATURES)
"""
function euclidCircle(c::Point2{Float64}, radius::Real)
    EuclidCircle(euclidPoint(c), radius)
end


"""Construct a circle using a `GeometryBasics.Point` and a line segment.
Note that `Point` is just an alias for Point2{Float64} in `GeometryBasics`.
$(SIGNATURES)
"""
function euclidCircle(c::Point2{Float64}, seg::EuclidLineSegment)
    EuclidCircle(euclidPoint(c), seglength(seg))
end


