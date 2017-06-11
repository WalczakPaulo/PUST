LB=[0 0 0 0 0 0 0];
UB=[Inf,Inf,Inf,Inf,Inf,Inf,Inf];
lambda=[1 1 1 1];
psi=[1 1 1];
x0=[lambda psi];
x=fmincon(@(x)(zad3DMC(80,40,5,[x(1) x(2) x(3) x(4)],[x(5) x(6) x(7)],false, false)),x0,[],[],[],[],LB,UB);
zad3DMC(80,40,5,[x(1) x(2) x(3) x(4)],[x(5) x(6) x(7)],true, false)