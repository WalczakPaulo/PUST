clear
close all
%PID optimization
x0 = [0.925 2.5 30]; %start point
lb = [ 0 0 0]; %lower bound
[x,fval]= fmincon(@(x)(pidErr(x(1),x(2),x(3),false)),x0,[],[],[],[],lb);
% drawPid
pidErr(x(1),x(2),x(3),true);