
"""Return a Makie figure for a CtsUrn."""
function diagram(u::CtsUrn; fig = Figure())
    # Add axis if none in figure:
    if isempty(fig.content)
        Axis(fig[1,1], aspect=DataAspect(), limits = (-1, 1, -1, 1))
    end

    #= Based on URN, delegate to correct method:

    - need to find right work (for now, just Euc.Elem.)
    - determine both proposition and part (protasis, kataskeuh, apodeixis)

    =#


    fig
end


"""Determine possible optional arguments to `diagram` function for
a specific text reference.
"""
function kwlist(u::CtsUrn)
    []
end


"""Determine number of steps in specific section of a text reference.
The URN must refer to a protasis, construction or proof section.
"""
function steps(u::CtsUrn)
    0
end
