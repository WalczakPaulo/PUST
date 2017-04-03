s11 = csvread('z3_y1_u1.csv');
s12 = csvread('z3_y1_u2.csv');
s21 = csvread('z3_y2_u1.csv');
s22 = csvread('z3_y2_u2.csv');

D = 150;
N = D;
Nu = D;
lambda = 1;

M = zeros(N*2, Nu*2);
Mp = zeros(N*2, (D - 1) * 2);

for i = 1:N
   for j = 1:i
      if j == 2*Nu + 1
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