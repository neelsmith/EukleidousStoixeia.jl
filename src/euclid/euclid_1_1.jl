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
    markersize = 4, markercolor = :blue
    )
    ax = isempty(fig.content)  ?  Axis(fig[1,1], aspect=DataAspect(), limits = (-1, 1, -1, 1)) : fig.content[1]

    seg = if haskey(propconfig, :segAB)    
        propconfig[:segAB]
    else
        x1 = rand(Float64, 1)[1]
        y1 = rand(Float64, 1)[1]
  
        x2 = rand(Float64, 1)[1]
        y2 = rand(Float64, 1)[1]

        EuclidLineSegment(EuclidPoint(x1,y1), EuclidPoint(x2,y2))

    end


    if contains(psg, "protasis")        
        euclid_1_1_protasis(psg, fig, seg,
            markersize = markersize, markercolor = markercolor, 
            linewidth = linewidth, color = color
        )

    elseif contains(psg, "construction")
        euclid_1_1_construction(psg, fig, seg,
        markersize = markersize, markercolor = markercolor, 
        linewidth = linewidth, color = color
        )
    elseif contains(psg, "proof")
    else

        # do the whole thing
    end
    fig
end

function euclid_1_1_protasis(psg, fig, segAB::EuclidLineSegment;
    linewidth = 1, color = :gray,
    markersize = 4, markercolor = :blue
    )
    @warn("Plotting protasis for Euclid 1.1..")
    @info("Marker color is $(markercolor)")
    # Only 1 step: add it no matter what:
    makieplot!(segAB; 
        fig = fig,
        linewidth = 1, color = :gray
    )
    makielabel!(segAB; 
        fig = fig,
        markersize = markersize,
        color = markercolor
        )
    fig
end

function euclid_1_1_construction(psg, fig, segAB::EuclidLineSegment,
    linewidth = 1, color = :gray,
    markersize = 4, markercolor = :blue
    )
    @info("Plot construction for Euclid 1.1, beginning with protasis")
    # Check step level from psg
    euclid_1_1_protasis(psg, fig, segAB;
        markersize = markersize, makercolor = markercolor
    )

    radius = seglength(segAB)
    circ = EuclidCircle(segAB.a, radius)
    makieplot!(circ, fig = fig)
    circ2 = EuclidCircle(segAB.b, radius)
    makieplot!(circ2, fig = fig)
    fig
end

function euclid_1_1_proof(psg, fig, segAB::EuclidLineSegment)
    # Check step level from psg
    
    fig
end