function [v, u_full] = quick_encode(u, state, output, transition, zeroState, stateBin)
m = max(size(u));
for i = 1:m
   v(:,i) = output(state,2* u(i) +1 : 2*( u(i) +1));
   state = transition(state, u(i)+1);
end

%ensure that we return to 0 state
u_zero(1:3) = stateBin(zeroState(state),:);
for c = m+1:m+max(size(u_zero))
    v(:,c) = output(state,2* u_zero(c-m) +1 : 2*( u_zero(c-m) +1));
    state = transition(state, u_zero(c-m)+1);
end
u_full = [u u_zero];
end

