%PID optimization
[x,fval]= fminunc(@(x)(E(x(1),x(2),x(3),false)),[2 2 2]);
%drawPid
E(x(1),x(2),x(3),true);
%DMC optimization
x=[150 150 1];
[x,fval]= ga(@(x)(dmcE(x(1),x(2),x(3),false)),3,[],[],[],[],[],[],[],[1 2 3],[]);
%drawDMC
dmcE(x(1),x(2),x(3),true);

