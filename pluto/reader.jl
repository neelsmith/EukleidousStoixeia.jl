### A Pluto.jl notebook ###
# v0.19.36

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local iv = try Base.loaded_modules[Base.PkgId(Base.UUID("6e696c72-6542-2067-7265-42206c756150"), "AbstractPlutoDingetjes")].Bonds.initial_value catch; b -> missing; end
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : iv(el)
        el
    end
end

# ╔═╡ ca58787e-b42d-11ee-1d6f-e71d6adf63ed
# ╠═╡ show_logs = false
begin
	using Pkg
	Pkg.activate(dirname(pwd()))
	Pkg.instantiate()

	using EukleidousStoixeia
	using CitableText

	Pkg.add("PlutoUI")
	using PlutoUI
	md"""*Unhide this cell to see the Julia environment*."""
end

# ╔═╡ b4612b5b-bcdd-4a17-b29b-82fd7d868a63
md"""# Reading Euclid, *Elements*"""

# ╔═╡ e0e0d1d9-9d25-4312-b201-f1d52b8300fc
html"""
<br/><br/><br/><br/><br/>
<hr/>
"""

# ╔═╡ aaf3c494-9e9a-4d7f-b3de-00540a089d00
md"""> Add these algorithmically from the text corpus..."""

# ╔═╡ 75d431ad-862c-4b03-a3a4-31d191b21f30
stepsdict = Dict(
	"1.1" => [
		"1.1.protasis",
		"1.1.construction.1",
		"1.1.construction.2",
		"1.1.construction.3",
		"1.1.proof.1",
		"1.1.proof.2",
		"1.1.proof.3",
		"1.1.proof.4",
		"1.1.proof.5",
		"all"
	
	]
)

# ╔═╡ 247a6705-982a-468b-85f0-0dca3411ba9c
md"""*Proposition*: $(@bind psg Select(keys(stepsdict) |> collect))"""

# ╔═╡ bccd061f-c81f-4f79-8469-118359e93686
md"""*Step*: $(@bind step Select(stepsdict[psg]))"""

# ╔═╡ ed9f928b-bb6e-43b7-909b-a193b52b59d4
u = CtsUrn("urn:cts:greekLit:tlg1799.tlg001:")

# ╔═╡ 5822967a-b4b8-42a3-98cc-953e3e912d2f
plotu = step == "all" ? addpassage(u, psg) : addpassage(u, step)

# ╔═╡ bf55c457-614a-46f7-acf8-c0dfef4db0fd
diagram(plotu)

# ╔═╡ Cell order:
# ╟─ca58787e-b42d-11ee-1d6f-e71d6adf63ed
# ╟─b4612b5b-bcdd-4a17-b29b-82fd7d868a63
# ╟─247a6705-982a-468b-85f0-0dca3411ba9c
# ╟─bccd061f-c81f-4f79-8469-118359e93686
# ╟─bf55c457-614a-46f7-acf8-c0dfef4db0fd
# ╟─e0e0d1d9-9d25-4312-b201-f1d52b8300fc
# ╟─aaf3c494-9e9a-4d7f-b3de-00540a089d00
# ╟─75d431ad-862c-4b03-a3a4-31d191b21f30
# ╟─ed9f928b-bb6e-43b7-909b-a193b52b59d4
# ╟─5822967a-b4b8-42a3-98cc-953e3e912d2f
