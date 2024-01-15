### A Pluto.jl notebook ###
# v0.19.36

using Markdown
using InteractiveUtils

# ╔═╡ 4b395764-b380-11ee-1eef-336ec2f9361c
# ╠═╡ show_logs = false
begin
	using Pkg
	repo = pwd() |> dirname
	#@info(repo)
	Pkg.activate(repo)
	Pkg.instantiate()
	
	using EukleidousStoixeia
	using CairoMakie
end

# ╔═╡ 558f2af1-d64d-4682-89e2-849d599bf93f
md"""# Simplest Makie"""

# ╔═╡ 0f53fd26-d201-47ad-bd54-260da2c722ae
ptA = EuclidPoint(0,0)

# ╔═╡ 81596f85-9a14-416f-a533-415cc7dbbe83
ptB = EuclidPoint(1,0)

# ╔═╡ 69db3e9e-1ba4-49e4-9d91-d692be4fa678
seg1 = EuclidLineSegment(ptA, ptB)

# ╔═╡ 510656a3-12a9-4102-a9dd-1d53d2b916a3
#x = range(0, 10, length=100)

# ╔═╡ 71f3ece3-0d39-4b39-a231-83c118287f4f


# ╔═╡ 2dbffe5c-3ec3-48cb-af4b-32c3460aecda
#figure, axis, lineplot = lines(x, y)

# ╔═╡ c5b8da93-994a-4b09-9b1f-0eab3aa527e4
fig = Figure()

# ╔═╡ 37387906-4244-4f3a-83de-db12b488ae96
fig.content |> length

# ╔═╡ 72280c37-e391-4f16-8aba-c5b52827ebb3
ax = Axis(fig[1,1], aspect=DataAspect(), limits = (-1, 1, -1, 1))
    

# ╔═╡ Cell order:
# ╠═4b395764-b380-11ee-1eef-336ec2f9361c
# ╟─558f2af1-d64d-4682-89e2-849d599bf93f
# ╠═37387906-4244-4f3a-83de-db12b488ae96
# ╠═0f53fd26-d201-47ad-bd54-260da2c722ae
# ╠═81596f85-9a14-416f-a533-415cc7dbbe83
# ╠═69db3e9e-1ba4-49e4-9d91-d692be4fa678
# ╟─510656a3-12a9-4102-a9dd-1d53d2b916a3
# ╠═71f3ece3-0d39-4b39-a231-83c118287f4f
# ╠═2dbffe5c-3ec3-48cb-af4b-32c3460aecda
# ╠═c5b8da93-994a-4b09-9b1f-0eab3aa527e4
# ╠═72280c37-e391-4f16-8aba-c5b52827ebb3
