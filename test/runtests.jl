#
using Test, SafeTestsets

@testset "Domains.jl" begin

@time @safetestset "Box Domain" begin include("box.jl") end

end
