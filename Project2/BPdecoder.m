function Lout = BPdecoder(H, Lch, imax)
[vector_nodes, check_nodes] = tanner(H);
[n_checknodes, lc] = size(check_nodes);
[n_vectornodes, lv] = size(vector_nodes);
Lc = zeros(lc, n_checknodes);
Lv = zeros(lv, n_vectornodes);
i = 1;
for v = 1:n_vectornodes
    for l = 1:lv
        Lv(l,v) = Lch(v);
    end
end

while (i <= imax)
    for c = 1:n_checknodes
        for l = lc:-1:1
            counter = 1;
            v = check_nodes(c,:);
            for z = 1:max(size(v))
                if v(z) ~= check_nodes(c,l)
                    for cv = 1:lv
                       if vector_nodes(v(z),cv) == c
                          Lvek(counter) = Lv(cv, v(z));
                          Lvektanh(counter) = tanh((1/2)*Lvek(counter));
                          counter = counter+1;
                       end
                    end
                end
            end
            Lc(l, c) =  2*atanh(prod(Lvektanh));
        end
    end
    for c = 1:n_checknodes
        for l = 1:lc
            if abs(Lc(l,c)) > 20
                Lc(l,c) = sign(Lc(l,c))*20; 
            end
        end
    end
    
    for v = 1:n_vectornodes
        for l = 1:lv
            counter = 1;
            for cl = 1:n_checknodes
                for z = 1:lc
                    if v == check_nodes(cl,z)
                        if cl ~= vector_nodes(v, l)
                            Lcej(counter) = Lc(z, cl);
                            counter = counter+1;
                        end
                    end
                end
            end
            Lv(l,v) = Lch(v) + sum(Lcej);
        end
    end

    i = i+1;
end

for v = 1:n_vectornodes
    counter = 1;
    for cl = 1:n_checknodes
        for z = 1:lc
            if v == check_nodes(cl,z)
                Lcv(counter) = Lc(z, cl);
                counter = counter+1;
            end
        end
    end
    Lout(v) = Lch(v) + sum(Lcv);
end


end

