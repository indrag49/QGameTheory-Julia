function QuantumHawkDove(p, q, moves, v, j, D)
    a=b=d=sqrt(5/16)
    c=1/4
    Q0 = [1; 0]
    Q1 = [0; 1]
    Q00 = kron(Q0, Q0)
    Q01 = kron(Q0, Q1)
    Q10 = kron(Q1, Q0)
    Q11 = kron(Q1, Q1)

    Psi_in = a*Q00 + b*Q01 + c*Q10 + d*Q11
    density_in = kron(Psi_in, transpose(conj(Psi_in)))
    m1 = moves[1]
    m2 = moves[2]
    d1 = (p*q*kron(m1, m1)'*density_in)*kron(transpose(conj(m1)), transpose(conj(m1)))
    d2 = (p*(1-q)*kron(m1, m2)'*density_in)*kron(transpose(conj(m1)), transpose(conj(m2)))
    d3 = (q*(1-p)*kron(m2, m1)'*density_in)*kron(transpose(conj(m2)), transpose(conj(m1)))
    d4 = ((1-p)*(1-q)*kron(m2, m2)'*density_in)*kron(transpose(conj(m2)), transpose(conj(m2)))
    density_matrix=d1+d2+d3+d4

    PA = (v+j)/2*kron(Q00, transpose(conj(Q00)))+(v/2+D)*kron(Q11, transpose(conj(Q11)))+v*kron(Q01, transpose(conj(Q01)))
    PB = (v+j)/2*kron(Q00, transpose(conj(Q00)))+(v/2+D)*kron(Q11, transpose(conj(Q11)))+v*kron(Q10, transpose(conj(Q10)))
    payoff_A = tr(PA'*density_matrix)
    payoff_B = tr(PB'*density_matrix)

    return  [payoff_A; payoff_B]
end

moves=[[1 0; 0 1], [0 1; 1 0]]
println(QuantumHawkDove(0.5, 0.5, moves, 50, -100, -10))

function PayoffMatrix_QuantumHawkDove(moves, v, j, D)
    Alice = zeros((2,2))
    Bob = zeros((2,2))
    for i in 1:2
        for j in 1:2
            X = QuantumHawkDove(i-1, j-1, moves, v, j, D)
            Alice[i,j] = X[1]
            Bob[i,j] = X[2]
        end
    end

    return [Alice; Bob]
end

moves = [[1 0; 0 1], [0 1; 1 0]]
println(PayoffMatrix_QuantumHawkDove(moves, 50, -100, -10))
