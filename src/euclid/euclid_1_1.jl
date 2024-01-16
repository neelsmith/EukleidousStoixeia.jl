"""Model the proposition Euclid 1.1.
$(SIGNATURES)
"""
function euclid_1_1()
    Proposition(
        "Euclid, Elements, 1.1",
        CtsUrn("urn:cts:greekLit:tlg1799.tlg001.stoicheia:1.1"),
        1, 3, 5,
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
    ax = isempty(fig.content)  ? defaultAxis(fig, title = "Euclid, Elements, 1.1") : fig.content[1]

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
        euclid_1_1_proof(psg, fig, seg;
        markersize = markersize, markercolor = markercolor, 
        linewidth = linewidth, color = color)


    else
        # doing the whole thing proposition is static, unhilited,
        # so it's enough just to do the construction:
        euclid_1_1_construction(psg, fig, seg;
        markersize = markersize, markercolor = markercolor, 
        linewidth = linewidth, color = color,
        hilite = hilite
        )
    end
    fig
end


"""Add protasis of Euclid 1.1 to a Makie figure.
$(SIGNATURES)
"""
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



"""Add construction of Euclid 1.1 to a  Makie figure.
$(SIGNATURES)
"""
function euclid_1_1_construction(psg, fig, segAB::EuclidLineSegment;
    linewidth = 1, color = :gray,
    markersize = 4, markercolor = :blue,
    hilite = :orange
    )
    @debug("Plot construction for Euclid 1.1, beginning with protasis")
    @debug("Use segAB $(segAB)")
    @debug("Construction: color is $(color)")

    euclid_1_1_protasis(fig, segAB;
        markersize = markersize, markercolor = markercolor,
        linewidth = linewidth, color = color
    )

    parts = split(psg, ".")
    step = if length(parts) > 3 && parts[3] == "construction"
        parse(Int, parts[4])
    else
        4
    end
    radius = seglength(segAB)
    circ = EuclidCircle(segAB.a, radius)
    circ2 = EuclidCircle(segAB.b, radius)
    intersects = intersection(circ, circ2)
    hypotenuse = EuclidLineSegment(
        circ.center, intersects[1]
    )
    hypotenuse2 = EuclidLineSegment(
        circ2.center, intersects[1]
    )

    # Step 1;
    color = step == 1 ? hilite : color
    makieplot!(circ, fig = fig, color = color)
    
    if step > 1
        color = step == 2 ? hilite : color    
        makieplot!(circ2, fig = fig, color = color)
    end
    if step > 2
        color = step == 3 ? hilite : color
        makieplot!(intersects[1], color = color, markersize = 8, fig = fig)
        makielabel!(intersects[1], labeltext = "C", fig = fig)

        makieplot!(hypotenuse; fig = fig, color = color)
        makieplot!(hypotenuse2; fig = fig, color = color)
    end

    fig
end

"""Add proof of Euclid 1.1 to a  Makie figure.
$(SIGNATURES)
"""
function euclid_1_1_proof(psg, fig, segAB::EuclidLineSegment;
    linewidth = 1, color = :gray,
    markersize = 4, markercolor = :blue,
    hilite = :lawngreen, hilite2 = :purple2
    )
    
    fig = euclid_1_1_construction(psg, fig, segAB;
    markersize = markersize, markercolor = markercolor, 
    linewidth = linewidth, color = color)

    parts = split(psg, ".")
    if length(parts) > 3 && parts[3] == "proof"
        step = parse(Int, parts[4])

        radius = seglength(segAB)
        circ = EuclidCircle(segAB.a, radius)
        circ2 = EuclidCircle(segAB.b, radius)
        intersects = intersection(circ, circ2)
        hypotenuse = EuclidLineSegment(
            circ.center, intersects[1]
        )
        hypotenuse2 = EuclidLineSegment(
            circ2.center, intersects[1]
        )

        if step == 1
            makieplot!(hypotenuse, fig = fig, color = hilite)
            makieplot!(segAB, fig = fig, color = hilite2)
        elseif step == 2
            makieplot!(hypotenuse2, fig = fig, color = hilite2)
            makieplot!(segAB, fig = fig, color = hilite)
        elseif step == 3
            makieplot!(hypotenuse, fig = fig, color = hilite)
            makieplot!(hypotenuse2, fig = fig, color = hilite)
            makieplot!(segAB, fig = fig, color = hilite2)
        elseif step == 4
            makieplot!(hypotenuse, fig = fig, color = hilite)
            makieplot!(hypotenuse2, fig = fig, color = hilite2)
        elseif step == 5
            makieplot!(hypotenuse, fig = fig, color = hilite)
            makieplot!(hypotenuse2, fig = fig, color = hilite)
            makieplot!(segAB, fig = fig, color = hilite)
        end
    

    else
        fig 
    end


  

    
end