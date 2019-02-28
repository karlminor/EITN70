clear
p = 11;
N = p-1;
K = 3;
a = 2;
t = floor((N-K)/2);
u = [4 0 0];

v = encoder(p, a, u);

e = [0 5 0 0 0 0 3 0 0 1];
r = mod(v + e,p);

vhat = decoder(r,a,p,K,t);

%if follwing is 0 then we have no errors
v-vhat

