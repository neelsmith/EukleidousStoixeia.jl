### A Pluto.jl notebook ###
# v0.19.41

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
	Pkg.resolve()
	Pkg.instantiate()

	using EukleidousStoixeia
	using CitableBase, CitableText, CitableCorpus
	using Downloads

	Pkg.add("HypertextLiteral")
	using HypertextLiteral
	Pkg.add("PlutoUI")
	using PlutoUI
	Pkg.add("PlutoTeachingTools")
	using PlutoTeachingTools


	Pkg.add("Kanones")
	Pkg.add("CitableParserBuilder")
	using Kanones
	using CitableParserBuilder
	
	Pkg.add("Orthography")
	Pkg.add("PolytonicGreek")
	using Orthography, PolytonicGreek
	
	md"""*Unhide this cell to see the Julia environment*."""
end

# ╔═╡ a4874afc-27c8-4247-b722-5fb6804742d0
@htl """
<style>
	pluto-output {
		--julia-mono-font-stack: system-ui,sans-serif;
	}
</style>
"""

# ╔═╡ b4612b5b-bcdd-4a17-b29b-82fd7d868a63
md"""# Reading Euclid, *Elements*

> The Julia package `EukleidouStoixeia` models both the diagrams and the text contents of Euclid's *Elements*, and lets you work with both kinds of content using CTS URNs.
"""

# ╔═╡ bf55c457-614a-46f7-acf8-c0dfef4db0fd
#contains(passagecomponent(plotu), "enunciation") ? md"" : diagram(plotu)

# ╔═╡ e0e0d1d9-9d25-4312-b201-f1d52b8300fc
html"""
<br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/>
<hr/>
"""

# ╔═╡ d309a145-b354-4f01-b020-1e2f272978e6
md"""> Parsing"""

# ╔═╡ 1e93c36e-697b-4a49-9422-6dba6523c7a8
parserurl = "http://shot.holycross.edu/morphology/comprehensive-current.csv"

# ╔═╡ 6f95e2b3-f6e9-4006-814d-8da9816e3b71
"""Download parser data from URN `u` and instantiate a DataFrame parser.""" 
function getremoteparser(u)
	tmp = Downloads.download(u)
	parser = dfParser(tmp)
	rm(tmp)
	parser
end

# ╔═╡ 4bbc2347-42cd-4f96-8889-d367858d4254
parser = getremoteparser(parserurl)

# ╔═╡ d7029334-d5dc-42fc-a235-73dc64b2f535
md"""> Diagrams (omitted in this nb)"""

# ╔═╡ b087a148-46fb-450a-b3da-f3f00af1b9a7
#md"""`diagram` is a function that represents a text passage identified by a URN with a `Figure` object:"""

# ╔═╡ c1d077e3-92b0-4b91-b095-d74781e10e34
#plotu

# ╔═╡ a6263313-d270-4a2b-8212-9ee42fb1dd57
#diagram(plotu) |> typeof

# ╔═╡ aaf3c494-9e9a-4d7f-b3de-00540a089d00
md"""> Add these algorithmically from the text corpus..."""

# ╔═╡ 75d431ad-862c-4b03-a3a4-31d191b21f30
stepsdict = Dict(
	"1.1" => [
		"1.1.enunciation",
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

# ╔═╡ a75d3fa3-c827-4e72-951d-3abf831670fe
md"""**Text and diagram of** *$(plotu)*:"""

# ╔═╡ 8328c84b-f899-45ed-b678-e96ef1f77dc9
corpus = fromcex(joinpath(pwd() |> dirname, "text", "elements.cex"), CitableTextCorpus, FileReader)

# ╔═╡ 8230d406-9415-4b28-9c35-32e972e2cc90
textpsg = filter(corpus.passages) do txtpsg
	dropversion(txtpsg.urn) == plotu || 
	startswith(passagecomponent(txtpsg.urn), string(passagecomponent(plotu),"."))
end

# ╔═╡ 1ee112da-de14-4288-a6fc-b7f5eead1f3e
function formatpsg(p)
	p.text
end

# ╔═╡ 3fd7740d-d9a4-45b3-8276-f1a1cfc35d76
"**Text**\n\n" * join(map(p -> formatpsg(p), textpsg), "\n\n") |> Markdown.parse #|> aside

# ╔═╡ Cell order:
# ╟─a4874afc-27c8-4247-b722-5fb6804742d0
# ╠═ca58787e-b42d-11ee-1d6f-e71d6adf63ed
# ╟─b4612b5b-bcdd-4a17-b29b-82fd7d868a63
# ╟─247a6705-982a-468b-85f0-0dca3411ba9c
# ╟─bccd061f-c81f-4f79-8469-118359e93686
# ╟─a75d3fa3-c827-4e72-951d-3abf831670fe
# ╠═3fd7740d-d9a4-45b3-8276-f1a1cfc35d76
# ╠═bf55c457-614a-46f7-acf8-c0dfef4db0fd
# ╟─e0e0d1d9-9d25-4312-b201-f1d52b8300fc
# ╟─d309a145-b354-4f01-b020-1e2f272978e6
# ╠═4bbc2347-42cd-4f96-8889-d367858d4254
# ╟─1e93c36e-697b-4a49-9422-6dba6523c7a8
# ╟─6f95e2b3-f6e9-4006-814d-8da9816e3b71
# ╟─d7029334-d5dc-42fc-a235-73dc64b2f535
# ╠═b087a148-46fb-450a-b3da-f3f00af1b9a7
# ╠═c1d077e3-92b0-4b91-b095-d74781e10e34
# ╠═a6263313-d270-4a2b-8212-9ee42fb1dd57
# ╟─aaf3c494-9e9a-4d7f-b3de-00540a089d00
# ╟─75d431ad-862c-4b03-a3a4-31d191b21f30
# ╟─ed9f928b-bb6e-43b7-909b-a193b52b59d4
# ╟─5822967a-b4b8-42a3-98cc-953e3e912d2f
# ╟─8328c84b-f899-45ed-b678-e96ef1f77dc9
# ╟─8230d406-9415-4b28-9c35-32e972e2cc90
# ╟─1ee112da-de14-4288-a6fc-b7f5eead1f3e
