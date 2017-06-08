clear


LB=[0,0,0,0,0,0,0,0,0];
UB=[inf,inf,inf,inf,inf,inf,inf,inf,inf];

K=[1,1,1];
Ti=[inf,inf,inf];
Td=[0.0,0.0,0.0];
whichUs = [2 3 4]; % najlepszy tor, bo najlepsze uwarunkowanie macierzy
x0=[K Ti Td];

x=fmincon(@(x)(pidFunc([x(1) x(2) x(3)],[x(4) x(5) x(6)],[x(7) x(8) x(9)],whichUs,false)),x0,[],[],[],[],LB,UB);
pidFunc([x(1) x(2) x(3)],[x(4) x(5) x(6)],[x(7) x(8) x(9)],[2 4 1],true)