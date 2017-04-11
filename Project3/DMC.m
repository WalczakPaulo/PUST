s11 = csvread('sprawko/wykresy/z3_y1_u1.csv');
s12 = csvread('sprawko/wykresy/z3_y1_u2.csv');
s21 = csvread('sprawko/wykresy/z3_y2_u1.csv');
s22 = csvread('sprawko/wykresy/z3_y2_u2.csv');
s11 = s11(2:end);
s12 = s12(2:end);
s21 = s21(2:end);
s22 = s22(2:end);

kk = 1000;

D = 150;
N = 150;
Nu = 150;
lambda = 1;

Y0 = zeros(2*N, 1);
Yk = zeros(2*N, 1);
Yzad = zeros(2*N, 1);

Y1 = zeros(kk, 1);
Y2 = zeros(kk, 1);
U1 = zeros(kk, 1);
U2 = zeros(kk, 1);
yzad1 = zeros(kk, 1);
yzad1(1:200) = 5;
yzad1(201:500) = 2;
yzad1(501:end) = 9;
yzad2 = zeros(kk, 1);
yzad2(1:200) = 2;
yzad2(201:300) = 5;
yzad2(301:700) = 9;
yzad2(700:end) = 9;

try
   Zy1;
   Zy2;
catch
   Zy1 = 0*(2*rand(kk, 1) - 1);
   Zy2 = 0*(2*rand(kk, 1) - 1);
end

tSkok1 = 750;
dSkok1 = 1;
tSkok2 = 10000;
dSkok2 = 0;

dU = zeros(2*Nu, 1);
dUp = zeros(2*(D-1),1);

M = zeros(N*2, Nu*2);
Mp = zeros(N*2, (D - 1) * 2);

for i = 1:N
   for j = 1:i
      if j == Nu + 1
         break
      end
      M(2*i-1:2*i, 2*j-1:2*j) = [s11(i-j+1), s12(i-j+1); s21(i-j+1), s22(i-j+1)];
   end
end
   
for i = 1:N
   for j = 1:(D-1)
      Mp(2*i-1:2*i, 2*j-1:2*j) = [s11(i+j) - s11(j), s12(i+j) - s12(j); ...
         s21(i+j) - s21(j), s22(i+j) - s22(j)];
   end
end

phi = eye(2*N);
Lambda = lambda*eye(2*Nu);

K = ((M'*phi*M + Lambda)^(-1))*M'*phi;


for k = 9:kk
   Yk(1:2:end) = Y1(k-1) + Zy1(k - 1);
   Yk(2:2:end) = Y2(k-1) + Zy2(k - 1);
   
   Yzad(1:2:end) = yzad1(k);
   Yzad(2:2:end) = yzad2(k);
   
   Y0 = Yk + Mp*dUp;
   dU = K*(Yzad - Y0);
   
   dUp(3:end) = dUp(1:end-2);
   dUp(1:2) = dU(1:2);
   
   U1(k) = U1(k - 1) + dU(1);
   U2(k) = U2(k - 1) + dU(2);
   Y1(k) = symulacja_obiektu5y1(U1(k - 7), U1(k - 8), U2(k - 2), U2(k - 3), Y1(k - 1), Y1(k - 2));
   Y2(k) = symulacja_obiektu5y2(U1(k - 3), U1(k - 4), U2(k - 4), U2(k - 5), Y2(k - 1), Y2(k - 2));
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