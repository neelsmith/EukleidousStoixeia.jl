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

"""Represent a line segment as a geometric vector with
magnitude and direction.
$(SIGNATURES)
"""
function geomvect(seg::EuclidLineSegment)
    magn = seglength(seg)
    direction = atan(seb)
    #[seg.a.x, seg.a.y, seg.b.x, seg.b.y]

end

"""Represent a line segment as a vector of x and y magnitudes.
$(SIGNATURES)
"""
function vect(seg::EuclidLineSegment)
    [seg.b.x - seg.a.x, seg.b.y - seg.a.y]
end

"""Add a linesegment to a Makie figure. Returns the Makie figure
with line segment added to it.
$(SIGNATURES)
"""
function makieplot!(s::EuclidLineSegment; fig = Figure(),
    linewidth = 1, color = :gray#,
    #markersize = 4, markercolor = :gray
    )
	xs = [s.a.x, s.b.x]
	ys = [s.a.y, s.b.y]
    ax = isempty(fig.content)  ?  Axis(fig[1,1], aspect=DataAspect(), limits = (-1, 1, -1, 1)) : fig.content[1]
	lines!(ax, xs,ys; linewidth = linewidth, color = color)
    fig
end


"""Add labelled points representing end points of a line segment to a Makie figure.
Returns the Makie figure with labelled points added to it.
$(SIGNATURES)
"""
function makielabel!(s::EuclidLineSegment; 
    fig = Figure(),
    markersize = 4, color = :gray 
    )
	xs = [s.a.x, s.b.x]
	ys = [s.a.y, s.b.y]
    ax = isempty(fig.content)  ?  Axis(fig[1,1], aspect=DataAspect(), limits = (-1, 1, -1, 1)) : fig.content[1]
	#lines!(ax, xs,ys)

    text!(ax, s.a.x, s.a.y; text = "A")
    text!(ax, s.b.x, s.b.y; text = "B")
    scatter!(ax, xs, ys; markersize = markersize, color = color)
    fig
end