
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

