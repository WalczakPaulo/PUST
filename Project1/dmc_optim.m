%DMC optimization
nVars = 3; % optimizing 3 params, N, Nu and Lambda
lb = [1 1 0.1]; %lower bound
ub = [150 150 150]; %upper bound
[x,fval]= ga(@(x)(dmcE(x(1),x(2),x(3),false)),nVars,[],[],[],[],lb,ub,[],[1 2]);
%drawDMC
dmcE(x(1),x(2),x(3),true);