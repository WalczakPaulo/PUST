clear

lb = [0.1 0.1 1 1 0.1 0.1 1 0.1]; %lower bound
ub = [0.5 0.5 7 7 6 6 7 0.5];
[x,fval] = ga(@(x)(pid_rozm([x(1),x(2)],[x(3),x(4)],[x(5),x(6)],2,x(7),x(8))),8,[],[],[],[],lb,ub,[],[]);