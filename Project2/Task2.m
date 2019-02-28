clear

load('H_1024_3_6.mat');

[vector_nodes, check_nodes] = tanner(H);

Lch = load('LchGroup3.txt');

Lout = BPdecoder(H, Lch, 20);

for i = 1:max(size(Lout))
   if Lout(i) < 0
       v(i) = 1;
   else
       v(i) = 0;
   end
end

Vcheck = gf(v)*gf(H)';
Vcheckint = Vcheck.x;
%If sum is 0 then the codeword multiplied with the parity check matrix is 0
%and the codeword is valid
sum(Vcheckint)