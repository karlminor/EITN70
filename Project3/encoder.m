function v = encoder(p, a, u)
N = p - 1;
[temp, K] = size(u);

for i = 1:(N-K)
    if i == 1
        gx = mod(poly(a^i),p);
    else
        gx = gfconv(gx,mod(poly(a^i),p),p);
    end
end
gx = flip(gx);
x(N-K+1) = 1;
vx = gfconv(x,u,p);
[Q, px] = gfdeconv(vx,gx,p);
px(numel(px)+1:numel(vx)) = 0;
v = mod(vx - px,p);
if numel(v) < N
    v(numel(v)+1:N) = 0;
end


end

