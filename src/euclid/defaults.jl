
"""Add an Axis with default settings to a Figure.
$(SIGNATURES)
"""
function defaultAxis(fig::Figure; title  = "")
    ax = Axis(fig[1,1], aspect=DataAspect(), limits = (-1, 1, -1, 1), title = title)
    hidespines!(ax)
    hidedecorations!(ax)
    ax
end

"""Dictionary of default values for plotting Euclid's givens."""
defaultsDict = Dict(

    "1.1" => Dict(
        :segAB => EuclidLineSegment(EuclidPoint(-0.3, 0), EuclidPoint(0.3, 0))
    )
)