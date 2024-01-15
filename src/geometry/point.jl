
struct EuclidPoint
    x::Real
    y::Real
end

function euclidPoint(p::Point)
    EuclidPoint(ptx(p), pty(p))
end


"""X value of a `GeometryBasics.Point`.
"""
function ptx(pt::Point)
	pt.data[1]
end

"""Y value of a `GeometryBasics.Point`.
"""
function pty(pt::Point)
	pt.data[2]
end
