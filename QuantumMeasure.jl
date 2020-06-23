using Plots
function QuantumMeasure(n)
    l = length(n)
    values=Float64[]
    for i in 1:l
        push!(values, abs(n[i])^2)
    end
    if l==2
        x=["|0>", "|1>"]
    elseif l==2^2
        x=["|00>", "|01>", "|10>", "|11>"]
    else
        x=["|000>","|001>","|010>","|011>","|100>","|101>","|110>","|111>"]
    end
    bar(x, values, legend=false)
end

Q0 = [1; 0]
Q1 = [0; 1]
Q01 = kron(Q0, Q1)
print(Q01)
QuantumMeasure(Q01)
