nVars = 3; % optimizing 3 params, N, Nu and Lambda
lb = [1 1 0.1]; %lower bound
ub = [50 50 50]; %upper bound
[x,fval]= ga(@(x)(dmc_zwykly(x(1),x(2),x(3),false)),nVars,[],[],[],[],lb,ub,[],[1 2]);