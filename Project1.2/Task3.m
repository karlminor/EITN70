clear 

r = load('rGroup3.txt');

for state = 1:8
    [v_0, state_0] = encoder(0, state-1);
    [v_1, state_1] = encoder(1, state-1);
    
    output(state,:) = [v_0, v_1];
    
    transition(state,:) = [state_0+1 state_1+1];
end

[u_hat, v_hat] = viterbi_soft_2(r, output, transition);