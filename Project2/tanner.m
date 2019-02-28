function [vector_nodes, check_nodes] = tanner(H)
[n_checknodes , n_vectornodes] = size(H);
lv = sum(H(:,1));
lc = sum(H(1,:));
vector_nodes = zeros(n_vectornodes, lv);
check_nodes = zeros(n_checknodes, lc);
for c = 1:n_checknodes 
    i = 1;
    for v = 1:n_vectornodes
        if(H(c,v) == 1)
            check_nodes(c,i) = v;
            i = i+1;
        end       
    end
end

for v = 1:n_vectornodes 
    i = 1;
    for c = 1:n_checknodes
        if(H(c,v) == 1)
            vector_nodes(v,i) = c;
            i = i+1;
        end       
    end
end

end


