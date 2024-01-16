using EukleidousStoixeia
using CitableText
using CairoMakie
u = CtsUrn("urn:cts:greekLit:tlg1799.tlg001:1.1")


c1 = EuclidCircle(EuclidPoint(0,0), 0.6)
c2 = EuclidCircle(EuclidPoint(0.6, 0.2), 0.4)
seg = EuclidLineSegment(c1.center, c2.center)

#=
f = makieplot!(c1)
makieplot!(c1.center, fig = f, markersize = 8)
makielabel!(c1.center, fig = f, labeltext = "A")

makieplot!(c2, fig = f)
makieplot!(c2.center, fig = f, markersize = 8)
makielabel!(c2.center, fig = f, labeltext = "B")
=#

#makieplot!(seg, fig = f)









#### DEbug more
function basicframe(f::Figure = Figure())
    makieplot!(c1, fig = f)
    makieplot!(c1.center, fig = f, markersize = 8)
    makielabel!(c1.center, fig = f, labeltext = "A")

    makieplot!(c2, fig = f)
    makieplot!(c2.center, fig = f, markersize = 8)
    makielabel!(c2.center, fig = f, labeltext = "B")

    seg = EuclidLineSegment(c1.center, c2.center)
    makieplot!(seg, fig = f)


    makieplot!(vrtx, fig = f, color = :orange, markersize = 6)
    f
end


debug = basicframe()

xdiff = c2.center.x - c1.center.x
ydiff = c2.center.y - c1.center.y
dist  = seglength(seg)



# Make a right triangle on line joining centers of circles.
# 
# Length of joining line for base from circle 1:
baseA = (c1.radius^2 - c2.radius^2 + dist^2 ) / (2 * dist)
dist - baseA
ht = sqrt(c1.radius^2 - baseA^2)

#P2 = P0 + baseA * ( P1 - P0 ) / dist
x2 = c1.center.x + (xdiff * baseA) / dist
y2 = c1.center.y + (ydiff * baseA) / dist
vrtx = EuclidPoint(x2, y2)

rx = -ydiff * (ht/dist);
ry = xdiff * (ht/dist);


i1x = x2 + rx;
i2x = x2 - rx;
i1y = y2 + ry;
i2y = y2 - ry;

ipoints = [
    EuclidPoint(i1x, i1y),
    EuclidPoint(i2x, i2y)
]

makieplot!(ipoints[1], fig = debug, color = :green, markersize = 8)
debug