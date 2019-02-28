clear
p = 11;
N = p-1;
K = 3;
a = 2;
t = floor((N-K)/2);

A = findA(p, t);
u = [0 0 0];
encoder(p,a,u);
v = zeros(p^K,N);
counter = 1;
   for n = 0:N
       u(1) = n;
       for c = 0:N
           u(2) = c;
           for r = 0:N
               u(3) = r;
               v(counter,:) = encoder(p,a,u);
               counter = counter+1;
           end
       end
   end
   weights = findWeight(v);