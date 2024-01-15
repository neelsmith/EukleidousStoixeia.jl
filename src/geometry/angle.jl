struct EuclidAngle
    a::EuclidPoint
    b::EuclidPoint
    c::EuclidPoint
end


"""Valiue of angle in radians.

"""
function rad(angle::EuclidAngle)
    side1 = seglength(EuclidLineSegment(angle.a, angle.b))
    side2 = seglength(EuclidLineSegment(angle.a, angle.c))
    hypot = seglength(EuclidLineSegment(angle.b, angle.c))
    (side1^2 + side2^2 - hypot^2) / (2 * side1 * side2) |> acos
end

function deg(angle::EuclidAngle)
    rad(angle) |> rad2deg
end
