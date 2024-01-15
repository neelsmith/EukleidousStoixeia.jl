using CairoMakie

x = range(0, 10, length=100)
y = sin.(x)

figure, axis, lineplot = lines(x, y)


figure.content