"""Model the proposition Euclid 1.1.
$(SIGNATURES)
"""
function euclid_1_1()
    Proposition(
        "Euclid, Elements, 1.1",
        CtsUrn("urn:cts:greekLit:tlg1799.tlg001.stoicheia:1.1"),
        1, 4, 4,
        diagram_euclid_1_1,
        Dict(
            :segAB => EuclidLineSegment
        )
    )
end


"""Add to a Makie figure the given passage of Euclid 1.1.
Euclid 1.1 sets out one unit in the protasis, a line segment. This may optionally
be supplied as a named parameter; alternatively it will be randomly generated.
$(SIGNATURES)
"""
function diagram_euclid_1_1(psg; fig = Figure(), 
    propconfig = Dict{Symbol, DataType}(),
    linewidth = 1, color = :gray,
    markersize = 4, markercolor = :blue,
    hilite = :orange
    )
    ax = isempty(fig.content)  ? defaultAxis(fig) : fig.content[1]

    seg = if haskey(propconfig, :segAB)    
        @debug("FOUND KEY IN PROPCONFIG")
        propconfig[:segAB]
        
    else
        @debug("key :segAB not found in propconfig")
        @debug("dict was $(propconfig)")
        x1 = rand(Float64, 1)[1]
        y1 = rand(Float64, 1)[1]
  
        x2 = rand(Float64, 1)[1]
        y2 = rand(Float64, 1)[1]

        EuclidLineSegment(EuclidPoint(x1,y1), EuclidPoint(x2,y2))

    end
    @debug("Seg is now $(seg)")

    if contains(psg, "protasis")        
        euclid_1_1_protasis(fig, seg;
            markersize = markersize, markercolor = markercolor, 
            linewidth = linewidth, color = hilite
        )

    elseif contains(psg, "construction")
        euclid_1_1_construction(psg, fig, seg;
        markersize = markersize, markercolor = markercolor, 
        linewidth = linewidth, color = color,
        hilite = hilite
        )
    elseif contains(psg, "proof")
        #...
    else
        euclid_1_1_proof(psg, fig, seg;
        markersize = markersize, markercolor = markercolor, 
        linewidth = linewidth, color = color)
    
        # do the whole thing
    end
    fig
end

function euclid_1_1_protasis(fig, segAB::EuclidLineSegment;
    linewidth = 1, color = :gray,
    markersize = 4, markercolor = :blue
    )
    @debug("Plotting protasis for Euclid 1.1..")
    @debug("SegAB is $(segAB)")
    @debug("Marker color is $(markercolor)")
    # Only 1 step: add it no matter what:
    makieplot!(segAB; 
        fig = fig,
        linewidth = linewidth, color = color
    )
    makielabel!(segAB; 
        fig = fig,
        markersize = markersize,
        color = markercolor
        )
    fig
end

function euclid_1_1_construction(psg, fig, segAB::EuclidLineSegment;
    linewidth = 1, color = :gray,
    markersize = 4, markercolor = :blue,
    hilite = :orange
    )
    @debug("Plot construction for Euclid 1.1, beginning with protasis")
    @debug("Use segAB $(segAB)")
    @debug("Construction: color is $(color)")
    # Check step level from psg
    euclid_1_1_protasis(fig, segAB;
        markersize = markersize, markercolor = markercolor,
        linewidth = linewidth, color = color
    )

    parts = split(psg, ".")
    step = if length(parts) > 3
        parse(Int, parts[4])
    else
        4
    end

    color = step == 1 ? hilite : color
    radius = seglength(segAB)
    circ = EuclidCircle(segAB.a, radius)
    makieplot!(circ, fig = fig, color = color)
    
    if step > 1
        color = step == 2 ? hilite : color
        circ2 = EuclidCircle(segAB.b, radius)
        makieplot!(circ2, fig = fig, color = color)
    end
    fig
end

function euclid_1_1_proof(psg, fig, segAB::EuclidLineSegment;
    linewidth = 1, color = :gray,
    markersize = 4, markercolor = :blue
    )
    
    fig = euclid_1_1_construction(psg, fig, segAB;
    markersize = markersize, markercolor = markercolor, 
    linewidth = linewidth, color = color)

    fig
end