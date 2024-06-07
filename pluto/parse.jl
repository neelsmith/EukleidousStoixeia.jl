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

# ╔═╡ 567d219a-c1c0-4bf1-ad59-ede8b244844b
TableOfContents()

# ╔═╡ b4612b5b-bcdd-4a17-b29b-82fd7d868a63
md"""## Reading Euclid, *Elements*

> The Julia package `EukleidouStoixeia` models both the diagrams and the text contents of Euclid's *Elements*, and lets you work with both kinds of content using CTS URNs.
"""

# ╔═╡ 4afdc4f4-251f-477a-8632-eff347679592
@bind reload Button("Reload local data")

# ╔═╡ 29a9fa5a-6390-451e-a098-246e925594a2
md"""!!! warning "Just guessing"

    Find forms in `lsjx` namespace...
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

# ╔═╡ 6ed7d2a7-1db4-4d28-8727-095bb88e2581
md"""## Things you can ignore"""

# ╔═╡ 118a6a8d-ae3e-4d8c-8170-0c9c84a2dc9f
md"""> ### Parser configuration"""

# ╔═╡ 1e174d83-c6bc-404a-83d1-2fb33344abce
kanones = joinpath("..", "..", "Kanones.jl")

# ╔═╡ 923cf047-061f-48ea-8458-1e9099e9dd0e
rulesds = joinpath(kanones, "datasets", "literarygreek-rules")

# ╔═╡ 554d91a5-ddb2-4c0e-9d50-92df7929d4c7
md"""> User selection of forms"""

# ╔═╡ 1b0e1363-2470-489f-8180-f9b0d43ba791
md"""> Tokenizing"""

# ╔═╡ 8ebb87b7-e39d-45cc-9b44-74f134c8d4db
ortho = literaryGreek()

# ╔═╡ 2fd21a98-8ab5-4b18-bfd3-fe795365d95e
"""Format Markdown display of form"""
function formatanalysis(an)
	an.form |> greekForm |> Kanones.label
end

# ╔═╡ b9a5b29b-8325-4812-b736-218deb8f59af
"""Format passages for markdown display."""
function formatpassage(psg, checklist)
	#string("*", titlecase(workid(psg.urn)),"* ", passagecomponent(psg.urn), ":\n> ", psg.text)
	tkns = split(psg.text)
	nopunct = [filter(c -> ! ispunct(c), t) for t in tkns]

	wrapped = []
	for (i, tkn) in enumerate(nopunct)
		if tkn in checklist
			s = string("<span class=\"hilite\">", tkns[i], "</span>")
			push!(wrapped, s)
		else
			push!(wrapped, tkns[i])
		end
	end
	
	htmlstr = join(wrapped, " ")
	out = string("<blockquote>",htmlstr,"</blockquote>")
	#html"""<blockquote>$(htmlstr)</blockquote>"""
	out
end

# ╔═╡ d309a145-b354-4f01-b020-1e2f272978e6
md"""> Parsing"""

# ╔═╡ 1e93c36e-697b-4a49-9422-6dba6523c7a8
parserurl = "http://shot.holycross.edu/morphology/attic_core-current.cex"

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

# ╔═╡ 283e5321-130e-49f1-8c45-01611c2e17d5
md"""> Building and managing parsers"""

# ╔═╡ 915a137f-a0a3-4d46-bf4d-f6bfe1780fbc
"""Read local dataset files and create a DataFrame of all possible parses.
"""
function readlocal()
	[rulesds, lsjds, local_data] |> dataset |> simpleDF
end

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
md"""**URN**: *$(plotu)*:"""

# ╔═╡ 8328c84b-f899-45ed-b678-e96ef1f77dc9
corpus = fromcex(joinpath(pwd() |> dirname, "text", "elements.cex"), CitableTextCorpus, FileReader)

# ╔═╡ 8230d406-9415-4b28-9c35-32e972e2cc90
textpsg = filter(corpus.passages) do txtpsg
	dropversion(txtpsg.urn) == plotu || 
	startswith(passagecomponent(txtpsg.urn), string(passagecomponent(plotu),"."))
end

# ╔═╡ 5092761f-9391-47d5-a141-e7e43d054085
textpsg |> typeof

# ╔═╡ 174f0d6f-81fe-4e91-8cb7-2d4ac309efcc
tkns = tokenize(textpsg[1], ortho)

# ╔═╡ 9401d4b9-dabb-4f7e-98a4-537447992f00
lex = filter(t -> t.tokentype isa LexicalToken, tkns)

# ╔═╡ a5e7e10f-64b7-44ce-9307-a6b8cd1eb1b8
formslist = [t.passage.text for t in lex]

# ╔═╡ 6820146b-f802-4d9c-b65f-899677cd4e1a
formsmenu = [i => formslist[i] for i in 1:length(formslist)]

# ╔═╡ 6d32fd85-9dba-4548-992e-8cb8b5c20614
md"""*See analyses for*: $(@bind showthese MultiCheckBox(formsmenu))"""

# ╔═╡ 298dcff3-410e-4b68-9c6c-334e8f90106c
	selectedtokens = map(idx -> formslist[idx], showthese)	

# ╔═╡ cc85d1f6-eea4-4f04-86bd-3ae11af518d4
formatpassage(textpsg[1], selectedtokens) |> HTML 

# ╔═╡ 50afd82a-445c-4f98-8c10-b200b4011c20
parses = parsewordlist(formslist, parser)

# ╔═╡ 07831cc2-e311-4de1-aeb3-0da4681d8601
begin
	formsdisplay  = []
	for selectedform in showthese
		formdisplay = join([string("1. **", formslist[selectedform], "**, ", formatanalysis(a)) for a in parses[selectedform]],"\n")# |> Markdown.parse
		push!(formsdisplay, formdisplay)
	end
	join(formsdisplay,"\n") |> Markdown.parse
end

# ╔═╡ 0d83098c-26e4-491e-897a-37d748018387
noanalysisidx = findall(plist -> isempty(plist), parses)

# ╔═╡ 5291c89e-acf2-4ac7-b703-1dd96e11d68e
if isempty(noanalysisidx)
else

md"""!!! warning "Unanalyzed forms!"

    The following forms could not be analyzed:
"""
end

# ╔═╡ 7a4625ca-0cf7-41ba-b593-4fcb7ac984d1
if isempty(noanalysisidx)
else
	failed = map(idx -> string("- ", formslist[idx]), noanalysisidx)
	faillist = join(failed,"\n") |> Markdown.parse
end

# ╔═╡ 1ee112da-de14-4288-a6fc-b7f5eead1f3e
function formatpsg(p)
	p.text
end

# ╔═╡ 3fd7740d-d9a4-45b3-8276-f1a1cfc35d76
"**Text**\n\n" * join(map(p -> formatpsg(p), textpsg), "\n\n") |> Markdown.parse #|> aside

# ╔═╡ 90d14fcc-0cb8-4782-beab-127562f88a12
md"""> CSS"""

# ╔═╡ ca9e21e4-feb8-4a1c-99c9-28d175a6a2c6
@htl """
<style>
	pluto-output {
		--julia-mono-font-stack: system-ui,sans-serif;
	}
	.hilite {
		background-color: yellow;
		font-weight: bold;
	}
</style>
"""

# ╔═╡ Cell order:
# ╟─a4874afc-27c8-4247-b722-5fb6804742d0
# ╟─ca58787e-b42d-11ee-1d6f-e71d6adf63ed
# ╟─567d219a-c1c0-4bf1-ad59-ede8b244844b
# ╟─b4612b5b-bcdd-4a17-b29b-82fd7d868a63
# ╟─4afdc4f4-251f-477a-8632-eff347679592
# ╟─247a6705-982a-468b-85f0-0dca3411ba9c
# ╟─bccd061f-c81f-4f79-8469-118359e93686
# ╟─a75d3fa3-c827-4e72-951d-3abf831670fe
# ╟─3fd7740d-d9a4-45b3-8276-f1a1cfc35d76
# ╟─cc85d1f6-eea4-4f04-86bd-3ae11af518d4
# ╟─6d32fd85-9dba-4548-992e-8cb8b5c20614
# ╟─07831cc2-e311-4de1-aeb3-0da4681d8601
# ╟─5291c89e-acf2-4ac7-b703-1dd96e11d68e
# ╟─7a4625ca-0cf7-41ba-b593-4fcb7ac984d1
# ╟─29a9fa5a-6390-451e-a098-246e925594a2
# ╠═bf55c457-614a-46f7-acf8-c0dfef4db0fd
# ╟─e0e0d1d9-9d25-4312-b201-f1d52b8300fc
# ╟─6ed7d2a7-1db4-4d28-8727-095bb88e2581
# ╟─118a6a8d-ae3e-4d8c-8170-0c9c84a2dc9f
# ╠═1e174d83-c6bc-404a-83d1-2fb33344abce
# ╠═923cf047-061f-48ea-8458-1e9099e9dd0e
# ╟─554d91a5-ddb2-4c0e-9d50-92df7929d4c7
# ╠═a5e7e10f-64b7-44ce-9307-a6b8cd1eb1b8
# ╠═298dcff3-410e-4b68-9c6c-334e8f90106c
# ╠═6820146b-f802-4d9c-b65f-899677cd4e1a
# ╟─1b0e1363-2470-489f-8180-f9b0d43ba791
# ╠═5092761f-9391-47d5-a141-e7e43d054085
# ╠═8ebb87b7-e39d-45cc-9b44-74f134c8d4db
# ╠═174f0d6f-81fe-4e91-8cb7-2d4ac309efcc
# ╠═9401d4b9-dabb-4f7e-98a4-537447992f00
# ╟─2fd21a98-8ab5-4b18-bfd3-fe795365d95e
# ╟─b9a5b29b-8325-4812-b736-218deb8f59af
# ╟─d309a145-b354-4f01-b020-1e2f272978e6
# ╟─50afd82a-445c-4f98-8c10-b200b4011c20
# ╟─0d83098c-26e4-491e-897a-37d748018387
# ╠═4bbc2347-42cd-4f96-8889-d367858d4254
# ╟─1e93c36e-697b-4a49-9422-6dba6523c7a8
# ╠═6f95e2b3-f6e9-4006-814d-8da9816e3b71
# ╠═283e5321-130e-49f1-8c45-01611c2e17d5
# ╠═915a137f-a0a3-4d46-bf4d-f6bfe1780fbc
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
# ╟─90d14fcc-0cb8-4782-beab-127562f88a12
# ╠═ca9e21e4-feb8-4a1c-99c9-28d175a6a2c6
