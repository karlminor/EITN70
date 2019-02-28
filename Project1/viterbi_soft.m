function [u_hat] = viterbi_soft(r, output, transition)

n = 2;
m  = 3;
max_states = 2^m;
[temp, r_size] = size(r);
length_total = r_size;
length_info = r_size - m;

%arbitrarily small value
inf = -10^5;

%initialize trellis
trellis = inf*ones(max_states, length_total);

%initialize path matrix for storing the weights
path = zeros(max_states, length_total);

%keep track of paths traced
path_taken = path;

%determine trellis and path at time 1
ri = r(:, 1)';
for i = 0:1
    
    %set v = 0 -> x = 1, v = 1 -> x = -1
    x = -(2*output(1,n*i+1 : n*(i+1))-1);
    next_state = transition(1, i+1);
    path_lambda = 0;
    
    for j = 0:1
        path_lambda = path_lambda + ri(1, j+1) * x(1, j+1);
    end
    
    trellis(next_state, 1) = path_lambda;
    path(next_state, 1) = i;
end

%determine trellis and path at time 2 to length_total

for t = 2:length_total
   rt = r(:,t)';
   
   for state = 1:max_states
       for i = 0:1
           x = -(2*output(state,n*i+1 : n*(i+1))-1);
           next_state = transition(state, i+1);
           
           lambda = 0;
           for j = 1:n
               if rt(j)
                   lambda = lambda + rt(1, j) * x(1, j);
               end
           end
           
           %update path and trellis
           path_lambda = lambda + trellis(state, t-1);
           if(path_lambda > trellis(next_state, t))
               trellis(next_state, t) = path_lambda;
               path_taken(next_state,1:t) = [path(state, 1:t - 1) i];
               
           end
       end
   end
   path = path_taken;
end

u_hat = path(1,1:length_total);




    

