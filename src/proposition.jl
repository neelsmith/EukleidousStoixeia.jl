struct Proposition
    label::String
    protasis::Int
    construction::Int
    proof::Int
    fnct
    kwlist

end


"""Construct a proposition for the text identified by a URN.
$(SIGNATURES)
"""
function proposition(u::CtsUrn)::Union{Proposition, Nothing}
    if startswith(workcomponent(u), "tlg1799.tlg001")
        psg = passagecomponent(u)
        if psg == "1.1" || startswith(psg, "1.1.")
            euclid_1_1()

        else
            @warn("Passage $(psg) not implemented.")
        end

    else
        @warn("Only Euclid's Elements currently implemented (tlg1799.tlg001).")
        nothing
    end
end


"""Find number of steps in "setting-out" section of proposition.
$(SIGNATURES)
"""
function protasis(prop::Proposition)
    prop.protasis
end



"""Find number of steps in construction section of proposition.
$(SIGNATURES)
"""
function construction(prop::Proposition)
    prop.construction
end



"""Find number of steps in proof section of proposition.
$(SIGNATURES)
"""
function proof(prop::Proposition)
    prop.proof
end

"""Find a human-readable label for a proposition.
$(SIGNATURES)
"""
function label(prop::Proposition)
    prop.label
end