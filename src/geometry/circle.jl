"""Implementation of Euclid 1.definitions.15.
"""
struct EuclidCircle
    center::EuclidPoint
    radius::Real    
end


"""True if center and radius of each circle are equal.
If `exact` is true, use equality comparison, otherwise
compare within tolerance of machine computation with 
$(SIGNATURES)
"""
function ==(c1::EuclidCircle, c2::EuclidCircle; exact = false)
    exact ?  c1.center == c2.center && c1.radius == c2.radius : c1.center == c2.center && c1.radius  ≈ c2.radius
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


