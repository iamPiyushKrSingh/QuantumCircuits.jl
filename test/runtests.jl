using QuantumCircuits
using Test

@testset "QuantumCircuits.jl" begin
    @testset "QCircuitUtils" begin
        include("test_QCircuitUtils.jl")
    end

    @testset "RandomMatrices" begin
        include("test_RandomMatrices.jl")
    end
end
