module EukleidousStoixeia

using CitableText
using CairoMakie

export diagram
export ptx, pty
export EuclidLineSegment, seglength
export EuclidAngle
export EuclidTriangle
export EuclidCircle, euclidCircle

include("core.jl")
include("geom.jl")


end # module
