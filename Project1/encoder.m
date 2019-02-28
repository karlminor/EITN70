function [v, state] = encoder(u, state)
%ENCODER Summary of this function goes here
%   Detailed explanation goes here
v(1) = u;
for i = 1:3
    mem(i) = bitget(state,i);
end
a = bitxor(mem(2),mem(3));
b = bitxor(a,u);
c = bitxor(b,mem(1));
v(2) = bitxor(c,mem(3));

state = bitshift(state, 1);
state = bitset(state, 1, b);
if(bitget(state, 4) == 1)
    state = bitset(state, 4, 0);
end
end

