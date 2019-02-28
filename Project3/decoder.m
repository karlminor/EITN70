function v = decoder(rs, a, p, K, t)
N = p-1;
for k = 1:N-K
    R(k) = mod(polyval(flip(rs), mod(a^k,p)),p);
end
if sum(R) ~= 0
    
    ax(N-K+1) = 1;
    S = R;
    bx = S;
    i = 1;
    qsaved = zeros(N,N);
    rsaved = zeros(N,N);
    [q, r1] = gfdeconv(ax, bx, p);
    qsaved(i,1:numel(q)) = q;
    rsaved(i,1:numel(r1)) = r1;
    ax = bx;
    r = r1;
    
    while numel(r)-1 >= t,
        i = i+1;
        [q, r] = gfdeconv(ax, r1,p);
        qsaved(i,1:numel(q)) = q;
        rsaved(i,1:numel(r)) = r;
        ax = r1;
        r1 = r;
        if r == 0
            break
        end
    end
    Tx = mod(-r,p);
    g = zeros(N,N);
    g(1,:) = 0;
    g(2,1) = 1;
    for counter = 1:i
        prod = gfconv(qsaved(counter,:),g(counter+1,:),p);
        g(counter+2,:) = mod(gfsub(g(counter,:),prod,p),p);
        if counter == i
            lambda = g(counter+2,1:max(find(g(counter+2,:))));
        end
    end
    
    count = 0;
    for c = 1:N
        if mod(polyval(flip(lambda),c),p) == 0
            count = count+1;
            j(count) = c;
        end
    end
    for n = 1:count
        for c = 0:N
            if mod(a^c,p) == j(n)
                jk(n) = c-N;
            end
        end
    end
    
    dlambda = mod(polyder(flip(lambda)),p);
    
    e(1:N) = 0;
    for n = 1:count
        nom = mod(polyval(flip(Tx),a^(jk(n)+N)),p);
        denom = mod(polyval(dlambda,a^(jk(n)+N)),p);
        e(abs(jk(n))+1) =  mod(nom*mod(denom^(-1+N),p),p);
    end
    v = mod(rs - e,p);
    
else
    v = rs;
end
end
