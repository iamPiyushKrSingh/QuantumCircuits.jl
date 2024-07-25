using LinearAlgebra


"""
    unitary_circuit_evolution(state::Vector{ComplexF64}, no_of_generations)

This function performs the evolution of a quantum state through a unitary circuit.

# Arguments
- `state::Vector{ComplexF64}`: The initial quantum state represented as a vector of complex numbers.
- `no_of_generations`: The number of generations or iterations of the circuit evolution.

# Returns
- `final_state::Vector{ComplexF64}`: The final quantum state after the specified number of generations.
"""
function unitary_circuit_evolution(state::Vector{ComplexF64}, no_of_generations)
    m = 2
    n = Int(log2(length(state)))
    final_state = state

    if no_of_generations == 0
        return final_state
    end

    if n % 2 != 0
        throw(ArgumentError("The number of qubits must be even"))
    end

    if n < m
        throw(ArgumentError("The number of qubits must be greater than $m"))
    end

    for i in 1:no_of_generations
        if i % 2 == 1
            odd_gen_mat = kron([haar_unitary(2^m) for _ in 1:2:n]...)
            # @show odd_gen_mat
            final_state = odd_gen_mat * final_state
        else
            even_gen_mat = kron(I(2), [haar_unitary(2^m) for _ in 2:2:n-1]..., I(2))
            # @show even_gen_mat
            final_state = even_gen_mat * final_state
        end
    end
    return final_state
end



"""
    unitary_circuit_evolution_with_measurement(state::Vector{ComplexF64}, no_of_generations)

This function performs the evolution of a quantum circuit with measurements.

**Arguments**
- `state::Vector{ComplexF64}`: The initial state of the quantum circuit.
- `no_of_generations`: The number of generations for which the circuit should evolve.

**Returns**
- `final_state::Vector{ComplexF64}`: The final state of the quantum circuit after evolution.

**Throws**
- `ArgumentError`: If the number of qubits is not even or if the number of qubits is less than `m`.

**Description**
- This function evolves a quantum circuit with measurements for a given number of generations.
- The circuit evolution is performed using unitary matrices generated from the Haar measure.
- In each generation, the circuit is evolved using either odd or even generation unitary matrices.
- After each evolution step, a measurement is performed on a randomly chosen qubit using either the ``z`` or ``x`` basis.
- The measurement outcome is used to update the state of the circuit.

"""
function unitary_circuit_evolution_with_measurement(state::Vector{ComplexF64}, no_of_generations)
    m = 2
    n = Int(log2(length(state)))
    final_state = state

    if no_of_generations == 0
        return final_state
    end

    if n % 2 != 0
        throw(ArgumentError("The number of qubits must be even"))
    end

    if n < m
        throw(ArgumentError("The number of qubits must be greater than $m"))
    end

    for i in 1:no_of_generations
        if i % 2 == 1
            odd_gen_mat = kron([haar_unitary(2^m) for _ in 1:2:n]...)
            # @show odd_gen_mat
            final_state = odd_gen_mat * final_state
            # make a choice of measurement basis and a measurement index with random number generator
            basis = rand(['z', 'x'])
            # basis = 'z'
            index = rand(1:n)
            final_state = post_measurement_state(final_state, projective_measurement_operator(n, basis, index))
        else
            even_gen_mat = kron(I(2), [haar_unitary(2^m) for _ in 2:2:n-1]..., I(2))
            # @show even_gen_mat
            final_state = even_gen_mat * final_state
            # make a choice of measurement basis and a measurement index with random number generator
            basis = rand(['z', 'x'])
            # basis = 'z'
            index = rand(1:n)
            final_state = post_measurement_state(final_state, projective_measurement_operator(n, basis, index))
        end
    end
    return final_state
end


# write a function that have unitary circuit evolution with projective measurement after each evolution and calculates the fidelity of the state at each step and returns the fidelity values
function unitary_circuit_evolution_with_measurement_and_fidelity(state::Vector{ComplexF64}, no_of_generations)
    m = 2
    n = Int(log2(length(state)))
    final_state = state
    fidelity_values = []

    if no_of_generations == 0
        return final_state
    end

    if n % 2 != 0
        throw(ArgumentError("The number of qubits must be even"))
    end

    if n < m
        throw(ArgumentError("The number of qubits must be greater than $m"))
    end

    for i in 1:no_of_generations
        if i % 2 == 1
            odd_gen_mat = kron([haar_unitary(2^m) for _ in 1:2:n]...)
            # @show odd_gen_mat
            final_state = odd_gen_mat * final_state
            # make a choice of measurement basis and a measurement index with random number generator
            basis = rand(['z', 'x'])
            # basis = 'z'
            index = rand(1:n)
            final_state = post_measurement_state(final_state, projective_measurement_operator(n, basis, index))
            push!(fidelity_values, fidelity(state, final_state))
        else
            even_gen_mat = kron(I(2), [haar_unitary(2^m) for _ in 2:2:n-1]..., I(2))
            # @show even_gen_mat
            final_state = even_gen_mat * final_state
            # make a choice of measurement basis and a measurement index with random number generator
            basis = rand(['z', 'x'])
            # basis = 'z'
            index = rand(1:n)
            final_state = post_measurement_state(final_state, projective_measurement_operator(n, basis, index))
            push!(fidelity_values, fidelity(state, final_state))
        end
    end
    return fidelity_values
end
