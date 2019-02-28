%
% EDI042 - Error Control Coding (Kodningsteknik)
% Lund University
%
% Created by Michael Lentmaier, 2015-12-01
%


% Project 2: 
% simulate the iterative decoding performance of an LDPC code
clear
fig = openfig('project_1_BER.fig');
load('H_1024_3_6.mat');

figure(fig);
disp('Simulation running ...');

N=size(H,2); K=N-size(H,1);  R=K/N;
EbN0dB=[0 1 1.5 2 2.5]; Pb=[]; ErrVec=[]; 
EbN0=10.^(EbN0dB./10);
sigma2=1./(2*R*EbN0);
sigmaVec=sqrt(sigma2);

NumIterations=20;

numsim=50; 
for i=1:length(sigmaVec)  % different noise values
    if EbN0dB(i) >= 2
        numsim = 1000;
    end
  
  err=0; 
  for k=1:numsim % blocks to simulate
    
    
    % encoder: assume all-zero sequence sent
    v=zeros(1,N);                  
    
    % modulation to +1/-1
    x=1-2*v;        
    % AWGN channel
    r=x+sigmaVec(i).*randn(1,N);      
    
    Lch = 2/sigma2(i) .* r;
        
    Lout = BPdecoder(H, Lch, NumIterations);

    
    % count errors
    err=err+sum(Lout<0); 
    
  end
  
  % bit error rate
  Pb(i)=err/(N*numsim); 
  ErrVec(i)=err;
  
  disp(['SNR ',num2str(EbN0dB)]);
  disp(['Pb  ',num2str(Pb)]);
  save 'ResultSimLDPCTest.mat' EbN0dB Pb ErrVec
  
  
  % add point to plot
  semilogy(EbN0dB(i),Pb(i),'o','linewidth',1.5); pause(0.01); drawnow;
  axis([0,15,1e-6, 0.5]); hold on; grid on;

  
end
saveas(fig,'project_2_BER.fig');


