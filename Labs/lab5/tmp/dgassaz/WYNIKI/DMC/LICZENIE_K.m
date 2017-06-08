s11 = csvread('skok_1_1k.csv');
s12 = csvread('skok_1_2k.csv');
s21 = csvread('skok_2_1k.csv');
s22 = csvread('skok_2_2k.csv');
s11(50:100) = s11(49);
s12(50:100) = s12(49);
s21(50:100) = s21(49);
s22(50:100) = s22(49);

D = 49;
N = 49;
Nu = 49;
lambda = 1;

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

ke1 = sum(K(1, :));
ke2 = sum(K(2, :));
ku1 = K(1, :)*Mp;
ku2 = K(2, :)*Mp;

% dUp = zeros((D - 1)*2, 1);
% ek1 = yzad1(k) - Y1(k-1);
% ek2 = yzad2(k) - Y2(k-1);
% 
% dU1 = ke1 * ek1 - ku1 * dUp;
% dU2 = ke2 * ek2 - ku2 * dUp;
% 
% dUp(3:end) = dUp(1:end-2);
% dUp(1) = dU1;
% dUp(2) = dU2;