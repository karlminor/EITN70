% simulate error probability of viterbi soft decoder
% prepare figure
clear
figure(1); clf;

disp('Simulation running ...');

K=1; N=2; R=1/N;
EbN0dB=0:12;
EbN0=10.^(EbN0dB./10);
sigmaVec=sqrt(1./(2*R*EbN0));
sigmaVec=repmat(sigmaVec,2,1);

%create input parameters for viterbi soft decoder
for state = 1:8
    [v_0, state_0] = encoder(0, state-1);
    [v_1, state_1] = encoder(1, state-1);
    
    output(state,:) = [v_0, v_1];
 
    transition(state,:) = [state_0+1 state_1+1];
end

%create binary representations of states and generate the code snippets
%necessary to return state to 0 after transmission
[zeroState, stateBin] = createZeroState(transition);


numsim=10.^5; 
for i=1:length(sigmaVec)  % different noise values

  err=0; 
  for k=1:numsim % blocks to simulate
    
    % generate random binary input vector
    u=randi(2,1,20)-1;                 
    
    % covolution encoder
    % start state 0
    state = 1;
    [V, U] = quick_encode(u, state, output, transition, zeroState, stateBin);             
    
    % modulation to +1/-1
    x=1-2*V;   
    % AWGN channel
    for count = 1:max(size(x))
        r(:,count)=x(:,count)+sigmaVec(:,i).*randn(1,N)';
    end
    %r=r';
    
    % viterbi decoder
    Uhat = viterbi_soft(r, output, transition);              
    
    % count errors
    err=err+sum(Uhat~=u); 
    
  end
  
  % bit error rate
  Pb(i)=err/(20*numsim); 
  
  % add point to plot
  semilogy(EbN0dB(i),Pb(i),'x','linewidth',1.5); pause(0.01); drawnow;
  axis([0,15,1e-6, 0.5]); hold on; grid on;

  
end

xlabel('E_b/N_0 [dB]'); ylabel('P_b');



%% uncoded BPSK as reference

% define SNR range
EbN0dBUnc=-1:0.1:15; 
EbN0Unc=10.^(EbN0dBUnc./10);

% uncoded performance
PbUncoded=qfunc(sqrt(2*EbN0Unc));

% plot results
figure(1); 
semilogy(EbN0dBUnc,PbUncoded,'-.','linewidth',1.5);


disp('Ready.');
    
  
