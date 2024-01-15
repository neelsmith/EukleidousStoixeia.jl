
"""Return a Makie figure for a CtsUrn.
$(SIGNATURES)
"""
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
$(SIGNATURES)
"""
function kwlist(u::CtsUrn)
    []
end


"""Determine number of steps in specific section of a text reference.
The URN must refer to a protasis, construction or proof section.
$(SIGNATURES)
"""
function steps(u::CtsUrn)
    0
end


"""True if text passage identified by URN can be diagrammed
in current implementation.
$(SIGNATURES)
"""
function diagrammable(u::CtsUrn)::Bool
    false
end

"""Find list of text passages that can be diagrammed in current
implementation.  The resulting values are string representations of URNs.
$(SIGNATURES)
"""
function diagrammables()u::CtsUrn::Vector{String}
    []
end