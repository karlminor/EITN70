function A = findA(q,t)
N = q-1;
for d = 2*t+1:N
    sum = 0;
    for i = 0:2*t
        sum = sum + (-1)^(d+i)*nchoosek(d,i)*(q^(2*t)-q^i);
    end
   A(d) = nchoosek(q-1,d)*q^(-2*t)*((q-1)^d+sum);
end

end

