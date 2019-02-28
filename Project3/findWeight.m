function w = findWeight(v)
n = max(size(de2bi(max(max(v)))));
[r N] = size(v);
w(1:N) = 0;
for k = 1:r
    sum = 0;
   for i = 1:N
       if(v(k,i) ~= 0)
           sum = sum+1;
       end
   end
   if(sum ~= 0)
        w(sum) = w(sum)+1;
   end
end


end

