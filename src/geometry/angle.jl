"""Implementation of Euclid 1.definitions.8."""
struct EuclidAngle
    a::EuclidPoint
    b::EuclidPoint
    c::EuclidPoint
end


"""Valiue of angle in radians.
$(SIGNATURES)
"""
function rad(angle::EuclidAngle)
    side1 = seglength(EuclidLineSegment(angle.a, angle.b))
    side2 = seglength(EuclidLineSegment(angle.a, angle.c))
    hypot = seglength(EuclidLineSegment(angle.b, angle.c))
    (side1^2 + side2^2 - hypot^2) / (2 * side1 * side2) |> acos
end


"""Value of angle in degrees.
$(SIGNATURES)
"""
function deg(angle::EuclidAngle)
    rad(angle) |> rad2deg
end


"""Construct the chord of an angle as a `EuclidLineSegment`.
$(SIGNATURES)
"""
function chord(angle::EuclidAngle)
    EuclidLineSegment(angle.a, angle.c)
end