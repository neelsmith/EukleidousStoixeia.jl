"""Model the proposition Euclid 1.1.
$(SIGNATURES)
"""
function euclid_1_1()
    Proposition(
        "Euclid, Elements, 1.1",
        1, 4, 4,
        diagram_euclid_1_1
    )
end

function diagram_euclid_1_1(psg; fig = Figure())
    ax = isempty(fig.content)  ?  Axis(fig[1,1], aspect=DataAspect(), limits = (-1, 1, -1, 1)) : fig.content[1]

    
end