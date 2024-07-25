# Quantum Circuit Utils
```@example circuitUtils
using QuantumCircuits # hide
using QuantumInformation: ket # hide

u = ket(1, 2); # |0⟩
d = ket(2, 2); # |1⟩

u, d
```

## State Vectors Utility

```@docs
random_statevector
```

```@docs
is_valid_statevector
```

```@docs
zero_state
```

## Quantum Information Quantities

### Fidelity
!!! tip "Fidelity"
    The fidelity between two states is defined as the square of the overlap between the two states.
    ```math
    F(\psi, \phi) = |\langle \psi | \phi \rangle|^2
    ```

```@docs
fidelity
```

```@example circuitUtils
fidelity(u, d)
```

!!! warning "Fidelity over loaded"
    The `fidelity` function is defined in the `QuantumInformation` module as well, so you may need to use the full path to the function.
    ```julia
    QuantumCircuits.fidelity(u, d)
    ```

### Probability
!!! tip "Probability"
    The probability of measuring a state in a given basis is the square of the amplitude of the state in that basis.
    ```math
    P(\psi, \Pi) = |\langle \psi | \Pi | \psi \rangle|
    ```

```@docs
prob
```

```@example circuitUtils
Pi = u * u';
prob(u, Pi)
```

## Measurement

```@docs
projective_measurement_operator
```

```@docs
post_measurement_state
```
