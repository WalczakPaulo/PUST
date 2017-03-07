%PID optimization
% x0 = [2 2 2]; %start point
% lb = [ 0 0 0]; %lower bound
% [x,fval]= fmincon(@(x)(pidErr(x(1),x(2),x(3),false)),x0,[],[],[],[],lb);
% drawPid
% pidErr(x(1),x(2),x(3),true);
% optimalPID K= 


%DMC optimization
nVars = 3; % optimizing 3 params, N, Nu and Lambda
lb = [1 1 0.1]; %lower bound
ub = [150 150 150]; %upper bound
[x,fval]= ga(@(x)(dmcE(x(1),x(2),x(3),false)),nVars,[],[],[],[],lb,ub,[],[1 2]);
%drawDMC
dmcE(x(1),x(2),x(3),true);



%optimalDMC error = 13.2748
% N = 144, Nu = 2, Lambda = 4;

