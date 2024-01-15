"""Implementation of Euclid 1.definitions.8."""
struct EuclidAngle
    a::EuclidPoint
    b::EuclidPoint
    c::EuclidPoint
end

"""True if correspodning points of two angles are equal.
$(SIGNATURES)
"""
function ==(a1::EuclidAngle, a2::EuclidAngle)
    a1.a == a2.a &&
    a1.b == a2.b &&
    a1.c == a2.c
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




"""Add an angle  to a Makie figure. Returns the Makie figure
with triangle added to it.
$(SIGNATURES)
"""
function makieplot!(angle::EuclidAngle; fig = Figure(),
    linewidth = 1, color = :gray
    )
	xs = [angle.a.x, angle.b.x, angle.c.x]
	ys = [angle.a.y, angle.b.y, angle.c.y]
    ax = isempty(fig.content)  ?  Axis(fig[1,1], aspect=DataAspect(), limits = (-1, 1, -1, 1)) : fig.content[1]
	lines!(ax, xs, ys; linewidth = linewidth, color = color)
    #scatter!(ax, xs, ys)
    fig
end



"""Add labelled points representing end points of a line segment to a Makie figure.
Returns the Makie figure with labelled points added to it.
$(SIGNATURES)
"""
function makielabel!(angle::EuclidAngle; fig = Figure()
    )
	xs = [angle.a.x, angle.b.x, angle.c.x]
	ys = [angle.a.y, angle.b.y, angle.c.y]
    ax = isempty(fig.content)  ?  Axis(fig[1,1], aspect=DataAspect(), limits = (-1, 1, -1, 1)) : fig.content[1]

    text!(ax, angle.a.x, angle.a.y; text = "A")
    text!(ax, angle.b.x, angle.b.y; text = "B")
    text!(ax, angle.c.x, angle.c.y; text = "C")
    scatter!(ax, xs, ys)
    fig
end