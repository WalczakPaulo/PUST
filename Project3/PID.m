N = 1000;
Yz1 = 3*ones(N, 1);
Yz2 = 2*ones(N, 1);
y1 = zeros(N, 1);
y2 = zeros(N, 1);
U1 = zeros(N, 1);
U2 = zeros(N, 1);

K1 = 1;
Ti1 = Inf;
Td1 = 0;

K2 = 1;
Ti2 = Inf;
Td2 = 0;

T = 0.5;


prevE1 = 0;
prevE2 = 0;
prevUi1 = 0;
prevUi2 = 0;

for k = 9:N
   e1 = Yz1(k - 1) - y1(k - 1);
   e2 = Yz2(k - 1) - y2(k - 1);
   
   uP1 = K1 * e1;
   uI1 = prevUi1 + (K1 / Ti1) * T * (prevE1 + e1) / 2;
   uD1 = K1 * (Td1 / T) * (e1 - prevE1);
   U1(k) = uP1 + uI1 + uD1;
   
   uP2 = K2 * e2;
   uI2 = prevUi2 + (K2 / Ti2) * T * (prevE2 + e2) / 2;
   uD2 = K2 * (Td2 / T) * (e2 - prevE2);
   U2(k) = uP2 + uI2 + uD2;
   
   y1(k) = symulacja_obiektu5y1(U1(k - 7), U1(k - 8), U2(k - 2), U2(k - 3), y1(k - 1), y1(k - 2));
   y2(k) = symulacja_obiektu5y2(U1(k - 3), U1(k - 4), U2(k - 4), U2(k - 5), y2(k - 1), y2(k - 2));
end