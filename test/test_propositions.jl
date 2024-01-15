@testset "Test Proposition type" begin
  el_1_1 =   CtsUrn("urn:cts:greekLit:tlg1799.tlg001:1.1")
  prop = proposition(el_1_1)
  @test label(prop) == "Euclid, Elements, 1.1"
  @test protasis(prop) == 1
end