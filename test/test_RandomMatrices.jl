using Test
using QuantumCircuits

using LinearAlgebra: I


@testset "haar_unitary tests" begin
    # Test case 1: Check if the output matrix is of the correct size
    function test_haar_unitary_size()
        n = 3
        U = haar_unitary(n)
        @test size(U) == (n, n)
    end
    test_haar_unitary_size()

    # Test case 2: Check if the output matrix is unitary
    function test_haar_unitary_unitary()
        n = 3
        U = haar_unitary(n)
        @test U * U' ≈ I(n)
    end
    test_haar_unitary_unitary()

    # Test case 3: Check if the output matrix is random
    function test_haar_unitary_random()
        n = 3
        U1 = haar_unitary(n)
        U2 = haar_unitary(n)
        @test U1 != U2
    end
    test_haar_unitary_random()

    # Test case 4: Check if an ArgumentError is thrown for n = 0
    @test_throws ArgumentError haar_unitary(0)
end

@testset "random_hermitian tests" begin
    # Test case 1: Check if the output matrix is of the correct size
    function test_random_hermitian_size()
        n = 3
        H = random_hermitian(n)
        @test size(H) == (n, n)
    end
    test_random_hermitian_size()

    # Test case 2: Check if the output matrix is Hermitian
    function test_random_hermitian_hermitian()
        n = 3
        H = random_hermitian(n)
        @test H == H'
    end
    test_random_hermitian_hermitian()

    # Test case 3: Check if the output matrix is random
    function test_random_hermitian_random()
        n = 3
        H1 = random_hermitian(n)
        H2 = random_hermitian(n)
        @test H1 != H2
    end
    test_random_hermitian_random()

    # Test case 4: Check if an ArgumentError is thrown for n = 0
    @test_throws ArgumentError random_hermitian(0)
end
