module QuantumCircuits

export
    haar_unitary,
    random_hermitian,
    zero_state,
    random_statevector,
    projective_measurement_operator,
    is_valid_statevector,
    fidelity,
    unitary_circuit_evolution,
    unitary_circuit_evolution_with_measurement,
    unitary_circuit_evolution_with_measurement_and_fidelity,
    prob,
    post_measurement_state

include("RandomMatrices.jl")
include("QCircuitUtils.jl")
include("QCircuitDynamics.jl")

"""
    greet() = print("Hello QuantumCircuits!")
"""
greet() = print("Hello QuantumCircuits!")

end
