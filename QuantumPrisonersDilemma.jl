using LinearAlgebra, SparseArrays
function QuantumPrisonersDilemma(U_Alice, U_Bob, w, x, y, z)
    Q0 = [1; 0]
    Q1 = [0; 1]
    Q00 = kron(Q0, Q0)
    Q01 = kron(Q0, Q1)
    Q10 = kron(Q1, Q0)
    Q11 = kron(Q1, Q1)

    sigma_x = [0 1; 1 0]
    I2 = [1 0; 0 1]
    U = (kron(I2, I2) + 1im * kron(sigma_x, sigma_x))/sqrt(2)
    U_dag = conj(transpose(U))

    initial = U'*Q00
    k = kron(U_Alice, U_Bob)
    PsiS = k'*initial
    PsiF = U_dag'*PsiS

    cpsif = conj(transpose(PsiF))
    pi_Alice_exp = w*abs(cpsif*Q00)^2 + y*abs(cpsif*Q01)^2 + z*abs(cpsif*Q10)^2 + x*abs(cpsif*Q11)^2
    pi_Bob_exp = w*abs(cpsif*Q00)^2 + z*abs(cpsif*Q01)^2 + y*abs(cpsif*Q10)^2 + x*abs(cpsif*Q11)^2

    return [pi_Alice_exp; pi_Bob_exp]
end

H = [1 1; 1 -1]/sqrt(2)
sigma_z = [1 0; 0 -1]
println(QuantumPrisonersDilemma(H, sigma_z, 3 ,1, 0, 5))

function PayoffMatrix_QuantumPrisonersDilemma(moves, w, x, y, z)
    n = length(moves)
    Alice=zeros((n,n))
    Bob=zeros((n,n))
    for i in 1:n
        for j in 1:n
            X = QuantumPrisonersDilemma(moves[i], moves[j], w, x, y, z)
            Alice[i, j] = X[1]
            Bob[i, j] = X[2]
        end
    end

    return [Alice; Bob]
end

moves=[[1 0; 0 1], sigma_x, H, sigma_z]
print(PayoffMatrix_QuantumPrisonersDilemma(moves, 3, 1, 0, 5))
