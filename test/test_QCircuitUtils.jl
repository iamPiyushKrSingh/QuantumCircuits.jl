using Test
using QuantumCircuits

using LinearAlgebra: norm, I
using QuantumInformation: ket

u = ket(1, 2)
d = ket(2, 2)

r = (u + d) / sqrt(2)
l = (u - d) / sqrt(2)

@testset "random_statevector tests" begin
    # Test case 1: Check if the output vector has the correct length
    function test_random_statevector_length()
        n = 3
        v = random_statevector(n)
        @test length(v) == 2^n
    end
    test_random_statevector_length()

    # Test case 2: Check if the output vector is normalized
    function test_random_statevector_normalized()
        n = 3
        v = random_statevector(n)
        @test norm(v, 2) ≈ 1.0
    end
    test_random_statevector_normalized()

    # Test case 3: Check if an ArgumentError is thrown for n = 0
    @test_throws ArgumentError random_statevector(0)
end

@testset "is_valid_statevector tests" begin
    # Test case 1: Check if a valid state vector returns true
    function test_is_valid_statevector_valid()
        v = [0.6 + 0.0im, 0.8 + 0.0im]
        @test is_valid_statevector(v) == true
    end
    test_is_valid_statevector_valid()

    # Test case 2: Check if an invalid state vector returns false
    function test_is_valid_statevector_invalid()
        v = [1.0 + 0.0im, 1.0 + 0.0im]
        @test is_valid_statevector(v) == false
    end
    test_is_valid_statevector_invalid()
end

@testset "fidelity tests" begin
    # Test case 1: Check if the fidelity between two identical vectors is 1.0
    function test_fidelity_not_normalized_vectors()
        v = [1.0 + 0.0im, 2.0 + 0.0im, 3.0 + 0.0im]
        @test_throws ArgumentError fidelity(v, v)
    end
    test_fidelity_not_normalized_vectors()

    # Test case 2: Check if the fidelity between orthogonal vectors is 0.0
    function test_fidelity_orthogonal_vectors()
        v1 = [1.0 + 0.0im, 0.0 + 0.0im, 0.0 + 0.0im]
        v2 = [0.0 + 0.0im, 1.0 + 0.0im, 0.0 + 0.0im]
        @test fidelity(v1, v2) ≈ 0.0
    end
    test_fidelity_orthogonal_vectors()

    # Test case 3: Check if the fidelity between two identical vectors is 1.0
    function test_fidelity_identical_vectors()
        v = [1.0 + 0.0im, 2.0 + 0.0im, 3.0 + 0.0im]
        v /= norm(v, 2)
        @test fidelity(v, v) ≈ 1.0
    end
    test_fidelity_identical_vectors()
end

@testset "projective_measurement_operator tests" begin
    # Test case 1: Check if the projective measurement operator for basis 'z' and index 1 is correct
    function test_projective_measurement_operator_z_basis_index_1()
        n = 3
        basis = 'z'
        index = 1
        op = projective_measurement_operator(n, basis, index)
        expected_op = kron(u * u', I(2^(n - 1)))
        @test op ≈ expected_op
    end
    test_projective_measurement_operator_z_basis_index_1()
    # Test case 2: Check if the projective measurement operator for basis 'z' and index n is correct
    function test_projective_measurement_operator_z_basis_index_n()
        n = 3
        basis = 'z'
        index = n
        op = projective_measurement_operator(n, basis, index)
        expected_op = kron(I(2^(n - 1)), u * u')
        @test op ≈ expected_op
    end
    test_projective_measurement_operator_z_basis_index_n()
    # Test case 3: Check if the projective measurement operator for basis 'z' and index in between 1 and n is correct
    function test_projective_measurement_operator_z_basis_index_in_between()
        n = 3
        basis = 'z'
        index = 2
        op = projective_measurement_operator(n, basis, index)
        expected_op = kron(I(2^(index - 1)), u * u', I(2^(n - index)))
        @test op ≈ expected_op
    end
    test_projective_measurement_operator_z_basis_index_in_between()
    # Test case 4: Check if the projective measurement operator for basis 'x' and index 1 is correct
    function test_projective_measurement_operator_x_basis_index_1()
        n = 3
        basis = 'x'
        index = 1
        op = projective_measurement_operator(n, basis, index)
        expected_op = kron(r * r', I(2^(n - 1)))
        @test op ≈ expected_op
    end
    test_projective_measurement_operator_x_basis_index_1()
    # Test case 5: Check if the projective measurement operator for basis 'x' and index n is correct
    function test_projective_measurement_operator_x_basis_index_n()
        n = 3
        basis = 'x'
        index = n
        op = projective_measurement_operator(n, basis, index)
        expected_op = kron(I(2^(n - 1)), r * r')
        @test op ≈ expected_op
    end
    test_projective_measurement_operator_x_basis_index_n()
    # Test case 6: Check if the projective measurement operator for basis 'x' and index in between 1 and n is correct
    function test_projective_measurement_operator_x_basis_index_in_between()
        n = 3
        basis = 'x'
        index = 2
        op = projective_measurement_operator(n, basis, index)
        expected_op = kron(I(2^(index - 1)), r * r', I(2^(n - index)))
        @test op ≈ expected_op
    end
    test_projective_measurement_operator_x_basis_index_in_between()
end
