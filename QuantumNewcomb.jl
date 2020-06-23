function QuantumNewcomb(Omega, probability)
    Q0 = [1; 0]
    Q1 = [0; 1]

    if Omega[1]==1
        psi_in = kron(Q0, Q0)
    elseif Omega[2]==1
        psi_in = kron(Q1, Q1)
    end

    H = [1 1; 1 -1]/sqrt(2)
    sigma_x = [0 1; 1 0]
    I2 = [1 0; 0 1]
    psi1 = kron(H, I2)'*(probability*kron(sigma_x, I2) + (1-probability)*kron(I2, I2))
    psi2 = kron(H, I2)'*psi_in
    psif = psi1'psi2
    return psif
end

println(QuantumNewcomb([1;0], 0))
