clear


LB=[0,0,0,0,0,0,0,0,0];
UB=[inf,inf,inf,inf,inf,inf,inf,inf,inf];

K=[1 1 1];
Ti=[1000,1000,1000];
Td=[0,0,0];
whichUs = [4 3 2]; % najlepszy tor, bo najlepsze uwarunkowanie macierzy
x0=[K Ti];
options = optimset('MaxFunEvals', 1000)
x=fmincon(@(x)(pidFunc([x(1) x(2) x(3)],[x(4) x(5) x(6)],[0 0 0],whichUs,false)),x0,[],[],[],[],LB,UB,[], options);
pidFunc([x(1) x(2) x(3)],[x(4) x(5) x(6)],[0 0 0],[2 4 1],true)