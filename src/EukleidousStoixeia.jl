module EukleidousStoixeia

using CitableText
using CairoMakie

import Base.==
using Documenter, DocStringExtensions


export diagram
export ptx, pty
export EuclidPoint, euclidPoint
export EuclidLineSegment, seglength, vect
export EuclidAngle, rad, deg, chord
export EuclidTriangle
export EuclidCircle, euclidCircle


include("diagrams.jl")
include("geometry/point.jl")
include("geometry/lineseg.jl")
include("geometry/triangle.jl")
include("geometry/circle.jl")
include("geometry/angle.jl")




end # module
