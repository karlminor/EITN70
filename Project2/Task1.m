clear

H = [   1 1 1 0 0 0 0 0 0 ;
        1 0 0 1 0 0 1 0 0 ;
        0 0 0 1 1 1 0 0 0 ;
        0 1 0 0 1 0 0 1 0 ;
        0 0 0 0 0 0 1 1 1 ;
        0 0 1 0 0 1 0 0 1 ];

[vector_nodes, check_nodes] = tanner(H);

Lch = [1.5 -1 -1.5 2 -1 2.5 2 -1.5 -2.5];

Lout = BPdecoder(H, Lch, 1);

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