clear 

r = [1.5 -3 -2 -1 -2 1 ; 1 0.5 -4 1 2 2];
output = [0 0 1 1 ; 0 0 1 1 ; 0 1 1 0 ; 0 1 1 0];
transition = [ 1 3 ; 3 1 ; 4 2 ; 2 4];

[u_hat, v_hat] = viterbi_soft_2(r, output, transition);