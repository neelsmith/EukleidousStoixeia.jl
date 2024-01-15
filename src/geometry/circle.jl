
struct EuclidCircle
    center::EuclidPoint
    radius::Real    
end


function euclidCircle(c::EuclidPoint, seg::EuclidLineSegment)
    EuclidCircle(c, seglength(seg))
end

function euclidCircle(c::Point2{Float64}, radius::Real)
    EuclidCircle(euclidPoint(c), radius)
end

function euclidCircle(c::Point2{Float64}, seg::EuclidLineSegment)
    EuclidCircle(euclidPoint(c), seglength(seg))
end


