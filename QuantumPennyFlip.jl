using LinearAlgebra, SparseArrays
function QuantumPennyFlip(initial_state, strategies_Alice, strategies_Bob)
    l_Alice = length(strategies_Alice)
    l_Bob = length(strategies_Bob)

    # Alice prepares the initial state
    Alice = initial_state
    state = Alice

    # Bob plays his move
    B = rand(1:l_Bob)
    Bob = strategies_Bob[B]
    state = Bob' * state

    # Alice plays again
    A = rand(1:l_Alice)
    Alice = strategies_Alice[A]
    state = Alice'*state

    # Last move by Bob
    B = rand(1:l_Bob)
    Bob = strategies_Bob[B]
    state = Bob'*state

    return state
end

Q0 = [1; 0]
Q1 = [0; 1]
I2 = [1 0; 0 1]
psi = (Q0 + Q1)/sqrt(2)
S1 = [0 1; 1 0]
S2 = I2
H = [1 1; 1 -1]/sqrt(2)
SA = [S1, S2]
SB = [H]
state = QuantumPennyFlip(psi, SA, SB)
print(state)
