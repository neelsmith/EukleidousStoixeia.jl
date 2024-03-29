module EukleidousStoixeia

using CitableText
using CairoMakie
using LinearAlgebra

import Base.==
using Documenter, DocStringExtensions


export diagram, makieplot!, makielabel!
export ptx, pty
#export GeomVect



export EuclidPoint, euclidPoint, distance
export EuclidLineSegment, seglength, vect
export EuclidAngle, rad, deg, chord
export EuclidTriangle
export EuclidCircle, euclidCircle, intersection

export Proposition
export proposition, label, protasis, construction, proof, kwdict, kws



include("geometry/vect.jl")
include("geometry/point.jl")
include("geometry/lineseg.jl")
include("geometry/triangle.jl")
include("geometry/circle.jl")
include("geometry/angle.jl")


include("euclid/defaults.jl")
include("euclid/euclid_1_1.jl")

include("proposition.jl")
include("diagrams.jl")



end # module
