
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


"""Add a triangle  to a Makie figure. Returns the Makie figure
with triangle added to it.
$(SIGNATURES)
"""
function makieplot!(tr::EuclidTriangle; 
    fig = Figure(),
    linewidth = 1, color = :gray,
    markersize = 4, markercolor = :gray
    )
	xs = [tr.a.x, tr.b.x, tr.c.x, tr.a.x]
	ys = [tr.a.y, tr.b.y, tr.c.y, tr.a.y]
    ax = isempty(fig.content)  ?  Axis(fig[1,1], aspect=DataAspect(), limits = (-1, 1, -1, 1)) : fig.content[1]
	lines!(ax, xs,ys, linewidth = linewidth, color = color)
    scatter!(ax, xs, ys; markersize = markersize, color = markercolor)
    fig
end


"""Add labelled points representing end points of a line segment to a Makie figure.
Returns the Makie figure with labelled points added to it.
$(SIGNATURES)
"""
function makielabel!(tr::EuclidTriangle; fig = Figure())
	xs = [tr.a.x, tr.b.x, tr.c.x]
	ys = [tr.a.y, tr.b.y, tr.c.y]
    ax = isempty(fig.content)  ?  Axis(fig[1,1], aspect=DataAspect(), limits = (-1, 1, -1, 1)) : fig.content[1]

    text!(ax, tr.a.x, tr.a.y; text = "A")
    text!(ax, tr.b.x, tr.b.y; text = "B")
    text!(ax, tr.c.x, tr.c.y; text = "C")
    scatter!(ax, xs, ys)
    fig
end