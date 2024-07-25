using LinearAlgebra, QuantumInformation


"""
    random_statevector(n::Int) :: Vector{ComplexF64}

Generate a random state vector of length 2^n.

# Arguments
- `n::Int`: The number of qubits.

# Returns
- `v::Vector{ComplexF64}`: The random state vector.
"""
function random_statevector(n::Int)::Vector{ComplexF64}
    if n <= 0
        throw(ArgumentError("n must be greater than 0"))
    end

    v = randn(ComplexF64, 2^n)
    return v / norm(v, 2)
end



"""
    zero_state(n::Int) :: Vector{ComplexF64}

Initialize the state vector for a quantum circuit with `n` qubits.

# Arguments
- `n::Int`: The number of qubits in the quantum circuit.

# Returns
- `v::Vector{ComplexF64}`: The initialized state vector.
"""
function zero_state(n::Int)::Vector{ComplexF64}
    if n <= 0
        throw(ArgumentError("n must be greater than 0"))
    end
    v = zeros(ComplexF64, 2^n)
    v[1] = 1.0
    return v
end



"""
    is_valid_statevector(v::Vector{ComplexF64}) :: Bool

Check if the given vector `v` is a valid state vector.

A valid state vector is a vector of complex numbers whose Euclidean norm is approximately equal to 1.

# Arguments
- `v::Vector{ComplexF64}`: The vector to be checked.

# Returns
- `true` if the vector is a valid state vector, `false` otherwise.
"""
function is_valid_statevector(v::Vector{ComplexF64})::Bool
    return norm(v, 2) ≈ 1.0
end



"""
    fidelity(v1::Vector{ComplexF64}, v2::Vector{ComplexF64}) :: Float64

Compute the fidelity between two complex vectors `v1` and `v2`.

The fidelity is defined as the squared absolute value of the dot product between `v1` and `v2`.

# Arguments
- `v1::Vector{ComplexF64}`: The first complex vector.
- `v2::Vector{ComplexF64}`: The second complex vector.

# Returns
- `Float64`: The fidelity between `v1` and `v2`.
"""
function fidelity(v1::Vector{ComplexF64}, v2::Vector{ComplexF64})::Float64
    # throw an error if the vectors are valid state vectors
    if !is_valid_statevector(v1) || !is_valid_statevector(v2)
        throw(ArgumentError("Either v1 or v2 or both is not a valid state vector"))
    end
    # throw an error if the vectors are not of the same length
    if length(v1) != length(v2)
        throw(ArgumentError("v1 and v2 must have the same length"))
    end

    return abs(v1' * v2)^2
end



"""
    prob(state::Vector{ComplexF64}, Π::Matrix{ComplexF64})::Float64

Compute the probability of measuring a quantum state `state` given the measurement operator `Π`.

# Arguments
- `state::Vector{ComplexF64}`: The quantum state vector.
- `Π::Matrix{ComplexF64}`: The measurement operator.

# Returns
- `Float64`: The probability of measuring the state.
"""
function prob(state::Vector{ComplexF64}, Π::Matrix{ComplexF64})::Float64
    return real(tr(Π * state * state'))
end



"""
    post_measurement_state(state::Vector{ComplexF64}, Π::Matrix{ComplexF64})::Vector{ComplexF64}

Post-processes the state vector after a measurement is performed.

# Arguments
- `state::Vector{ComplexF64}`: The input state vector.
- `Π::Matrix{ComplexF64}`: The measurement operator.

# Returns
- `Vector{ComplexF64}`: The post-measurement state vector.

# Throws
- `ArgumentError`: If the probability of getting the measurement outcome is zero.

"""
function post_measurement_state(state::Vector{ComplexF64}, Π::Matrix{ComplexF64})::Vector{ComplexF64}
    if prob(state, Π) == 0
        throw(ArgumentError("The probability of getting the measurement outcome is zero"))
    end
    return Π * state / √prob(state, Π)
end


"""
    projective_measurement_operator(n::Int, basis::Char, index::Int)::Matrix{ComplexF64}

Constructs the projective measurement operator for a quantum circuit.

# Arguments
- `n::Int`: The number of qubits in the quantum circuit.
- `basis::Char`: The measurement basis. Must be either 'z' or 'x'.
- `index::Int`: The index of the qubit to be measured.

# Returns
A matrix representing the projective measurement operator.
"""
function projective_measurement_operator(n::Int, basis::Char, index::Int)::Matrix{ComplexF64}
    if n <= 0
        throw(ArgumentError("n must be greater than 0"))
    end

    if index < 1 || index > n
        throw(ArgumentError("The index must be between 1 and n"))
    end

    u = ket(1, 2)
    d = ket(2, 2)
    if basis == 'z'
        Π₀ = u * u'
        # Π₁ = d * d'
        if index == 1
            return kron(Π₀, I(2^(n - 1)))
        elseif index == n
            return kron(I(2^(n - 1)), Π₀)
        else
            return kron(I(2^(index - 1)), Π₀, I(2^(n - index)))
        end
    elseif basis == 'x'
        r = (u + d) / sqrt(2)
        # l = (u - d) / sqrt(2)
        Π_r = r * r'
        # Π_l = l * l'
        if index == 1
            return kron(Π_r, I(2^(n - 1)))
        elseif index == n
            return kron(I(2^(n - 1)), Π_r)
        else
            return kron(I(2^(index - 1)), Π_r, I(2^(n - index)))
        end
    else
        throw(ArgumentError("The basis must be either 'z' or 'x'"))
    end
end
