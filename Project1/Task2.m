clear
for state = 1:8
    [v_0, state_0] = encoder(0, state-1);
    [v_1, state_1] = encoder(1, state-1);
    
    output(state,:) = [v_0, v_1];
    
    transition(state,:) = [state_0+1 state_1+1];
end

u = load('uGroup3.txt');

state = 0;
%encode by calling encoder, resulting code in V1, does not end at state 0
for idx = 1:max(size(u))
    [v state] = encoder(u(idx), state);
    V1(:,idx) = v;
end  

[zeroState, stateBin] = createZeroState(transition);

%encode by using the tables, resulting code in V2, ends at state 0
[V2 u_full] = quick_encode(u, 1, output, transition, zeroState, stateBin);


