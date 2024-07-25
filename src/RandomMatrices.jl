using LinearAlgebra


"""
    haar_unitary(n::Int) :: Matrix{ComplexF64}

Generate a random Haar unitary matrix of size n x n.

# Arguments
- `n::Int`: The size of the matrix.

# Returns
- `Matrix{ComplexF64}`: The generated Haar unitary matrix.
"""
function haar_unitary(n::Int)::Matrix{ComplexF64}
    if n <= 0
        throw(ArgumentError("n must be greater than 0"))
    end

    A = randn(n, n) + im * randn(n, n)
    # perform QR decomposition
    Q, R = qr(A)
    Q, R = convert(Matrix, Q), convert(Matrix, R)
    Λ = Diagonal(sign.(diag(R)))
    return Q * Λ
end



"""
    random_hermitian(n::Int) :: Matrix{ComplexF64}

Generate a random Hermitian matrix of size n x n.

# Arguments
- `n::Int`: The size of the matrix.

# Returns
- `Matrix{ComplexF64}`: The generated Hermitian matrix.
"""
function random_hermitian(n::Int)::Matrix{ComplexF64}
    if n <= 0
        throw(ArgumentError("n must be greater than 0"))
    end

    A = randn(n, n) + im * randn(n, n)
    return (A + A') / 2
end
