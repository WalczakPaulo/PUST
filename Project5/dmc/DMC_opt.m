LB=[0,0,0];
UB=[Inf,Inf,Inf];
lambda=[1 1 1 1];
psi=[1 1 1];
x0=[psi];
x=fmincon(@(x)(zad3DMC(80,40,5,[0.3 0.15 0.1 0.3],[x(1) x(2) x(3)],false, false)),x0,[],[],[],[],LB,UB);
zad3DMC(80,40,5,[0.3 0.15 0.1 0.3],[x(1) x(2) x(3)],true, false)