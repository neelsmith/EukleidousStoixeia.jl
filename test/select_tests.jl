using Pkg
Pkg.activate("..")


using EukleidousStoixeia
using CairoMakie
using CitableText
using Test
using TestSetExtensions



@testset "All the tests" begin
    println(map(s -> replace(s, r".jl$" => ""), ARGS))
    @includetests map(s -> replace(s, r".jl$" => ""), ARGS)
end
