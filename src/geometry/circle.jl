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


"""Find points of itersection, if any, between two circles.
$(SIGNATURES)
"""
function intersect(c1::EuclidCircle, c2::EuclidCircle)
    
end


"""Add a linesegment to a Makie figure. Returns the Makie figure
with line segment added to it.
$(SIGNATURES)
"""
function makieplot!(c::EuclidCircle; fig = Figure(), points = 500,
    linewidth = 1, color = :gray
    )

    θ = LinRange(0, 2*π, points)
    xs, ys = c.center.x .+ c.radius*sin.(θ), c.center.y .+ c.radius*cos.(θ)
    ax = isempty(fig.content)  ?  Axis(fig[1,1], aspect=DataAspect(), limits = (-1, 1, -1, 1)) : fig.content[1]
    lines!(ax, xs, ys, color = color, linewidth = linewidth)
    fig
end


"""Add labelled points representing end points of a line segment to a Makie figure.
Returns the Makie figure with labelled points added to it.
$(SIGNATURES)
"""
function makielabel!(c::EuclidCircle; fig = Figure(), labeltext = ""
    )
    label = isempty(labeltext) ? "Origin" : labeltext
    ax = isempty(fig.content)  ?  Axis(fig[1,1], aspect=DataAspect(), limits = (-1, 1, -1, 1)) : fig.content[1]
    text!(ax, c.center.x, c.center.y; text = label)
    scatter!(ax, [c.center.x], [c.center.y])
    fig
end