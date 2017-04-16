clear

x0 = [0.925 30 2.5]; %start point
lb = [0 0 0]; %lower bound
[x,fval]= fmincon(@(x)(pid_zwykly(x(1),x(2),x(3),false)),x0,[],[],[],[],lb);