
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



"""Add a linesegment to a Makie figure. Returns the Makie figure
with line segment added to it.
$(SIGNATURES)
"""
function makieplot!(pt::EuclidPoint; fig = Figure())
	xs = [pt.x]
	ys = [pt.y]
    ax = isempty(fig.content)  ?  Axis(fig[1,1], aspect=DataAspect(), limits = (-1, 1, -1, 1)) : fig.content[1]
	scatter!(ax, xs,ys)
    fig
end


"""Add labelled points representing end points of a line segment to a Makie figure.
Returns the Makie figure with labelled points added to it.
$(SIGNATURES)
"""
function makielabel!(pt::EuclidPoint; fig = Figure(), labeltext = "")
    label = isempty(labeltext) ? "$(pt.x),$(pt.y)" : labeltext
    ax = isempty(fig.content)  ?  Axis(fig[1,1], aspect=DataAspect(), limits = (-1, 1, -1, 1)) : fig.content[1]
    text!(ax, pt.x, pt.y; text = label)
    fig
end