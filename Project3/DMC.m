s11 = csvread('z3_y1_u1.csv');
s12 = csvread('z3_y1_u2.csv');
s21 = csvread('z3_y2_u1.csv');
s22 = csvread('z3_y2_u2.csv');

D = 150;
N = 10;
Nu = 150;
lambda = 1;

Y0 = zeros(2*N, 1);
Yk = zeros(2*N, 1);
Yzad = zeros(2*N, 1);

Y1 = zeros(1000, 1);
Y2 = zeros(1000, 1);
U1 = zeros(1000, 1);
U2 = zeros(1000, 1);
yzad1 = 5*ones(1000, 1);
yzad2 = 2*ones(1000, 1);

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


for k = 9:1000
   Yk(1:2:end) = Y1(k-1);
   Yk(2:2:end) = Y2(k-1);
   
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
end
   