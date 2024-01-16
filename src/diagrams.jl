######################
# 
## Top-level functions for working with plottable propositions
# identified by CTS URN
#
######################

"""Return a Makie figure for a CtsUrn.
$(SIGNATURES)
"""
function diagram(u::CtsUrn; propconfig = Dict(),
    markersize = 6, markercolor = :gray,
    linewidth = 1, color = :gray    
    )

    prop = proposition(u)
    config = if isempty(propconfig) 
        psg = collapsePassageTo(u, 2) |> passagecomponent
        defaultsDict[psg]
    else
        propconfig
    end
    prop.fnct(passagecomponent(u), propconfig = config,
    markersize = markersize, markercolor = markercolor,
    linewidth = linewidth, color = color
    ) 
end

"""Return a Makie figure for a Proposition.
$(SIGNATURES)
"""
function diagram(prop::Proposition; propconfig = Dict(),
    markersize = 6, markercolor = :gray,
    linewidth = 1, color = :gray 
    )
    config = if isempty(propconfig) 
        psg = collapsePassageTo(prop.u, 2) |> passagecomponent
        @debug("Check for $(psg) in URN $(prop.u)")
        defaultsDict[psg]
    else
        propconfig
    end
    @debug("Config is now $(config) to sue with function $(prop.fnct)")
    prop.fnct(passagecomponent(prop.u), propconfig = config,
    markersize = markersize, markercolor = markercolor,
    linewidth = linewidth, color = color
    ) 
end

"""Determine possible optional arguments to `diagram` function for
a specific text reference.
$(SIGNATURES)
"""
function kwlist(u::CtsUrn)
    psg = collapsePassageTo(u, 2) |> passagecomponent
    haskey(defaultsDict, psg) ? defaultsDict[psg] : []
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