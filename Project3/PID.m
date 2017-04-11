N = 1000;

yzad1 = zeros(1000, 1);
yzad1(1:200) = 5;
yzad1(201:500) = 2;
yzad1(501:end) = 9;
yzad2 = zeros(1000, 1);
yzad2(1:200) = 2;
yzad2(201:300) = 5;
yzad2(301:700) = 9;
yzad2(700:end) = 9;

Y1 = zeros(N, 1);
Y2 = zeros(N, 1);
U1 = zeros(N, 1);
U2 = zeros(N, 1);

try
   Zy1;
   Zy2;
catch
   Zy1 = 1*(2*rand(1000, 1) - 1);
   Zy2 = 1*(2*rand(1000, 1) - 1);
end

tSkok1 = 750;
dSkok1 = 1;
tSkok2 = 10000;
dSkok2 = 0;

K1 = 1.5;
Ti1 = 20;
Td1 = 0.1;

K2 = 1.5;
Ti2 = 20;
Td2 = 0.1;

T = 0.5;


prevE1 = 0;
prevE2 = 0;
prevUi1 = 0;
prevUi2 = 0;

for k = 9:N
   e1 = yzad1(k - 1) - (Y1(k - 1) + Zy1(k - 1));
   e2 = yzad2(k - 1) - (Y2(k - 1) + Zy2(k - 1));
   
   uP1 = K1 * e1;
   uI1 = prevUi1 + (K1 / Ti1) * T * (prevE1 + e1) / 2;
   uD1 = K1 * (Td1 / T) * (e1 - prevE1);
   U1(k) = uP1 + uI1 + uD1;
   
   uP2 = K2 * e2;
   uI2 = prevUi2 + (K2 / Ti2) * T * (prevE2 + e2) / 2;
   uD2 = K2 * (Td2 / T) * (e2 - prevE2);
   U2(k) = uP2 + uI2 + uD2;
   
   Y1(k) = symulacja_obiektu5y1(U1(k - 7), U1(k - 8), U2(k - 2), U2(k - 3), Y1(k - 1), Y1(k - 2));
   Y2(k) = symulacja_obiektu5y2(U1(k - 3), U1(k - 4), U2(k - 4), U2(k - 5), Y2(k - 1), Y2(k - 2));
   prevE1 = e1;
   prevE2 = e2;
   prevUi1 = uI1;
   prevUi2 = uI2;
   if k == tSkok1
      Y1(k) = Y1(k) + dSkok1;
   end
   if k == tSkok2
      Y2(k) = Y2(k) + dSkok2;
   end
end

clf;
subplot(2,1,1)
plot(Y1);
hold on
plot(yzad1)
subplot(2,1,2)
plot(Y2)
hold on
plot(yzad2)
hold off