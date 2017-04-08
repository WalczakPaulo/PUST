s11 = csvread('z3_y1_u1.csv');
s12 = csvread('z3_y1_u2.csv');
s21 = csvread('z3_y2_u1.csv');
s22 = csvread('z3_y2_u2.csv');

D = 150;
N = D;
Nu = D;
lambda = 1;

kk = 1000;
ny = 2;
nu = 2;
y = zeros(ny, kk);
yzad = zeros(ny, kk);
yzad(1, 10:kk) = 2;
yzad(2, 10:kk) = 2;
u = zeros(nu, kk);
du = zeros(nu, kk);
dUP = cell(D - 1, 1);
dUP(1 : D-1) = {zeros(2, 1)};
M = cell(N, Nu);
for i = 1:N
   for j = 1:Nu
      if (i >= j)
         M(i,j) = {[s11(i-j+1) s12(i-j+1); s21(i-j+1) s22(i-j+1)]};
      else
          M(i,j) = {zeros(nu, ny)};
      end
   end
end
MP = cell(N,D-1);
for i = 1:N
   for j = 1:D-1
      if i + j <= D
         MP(i, j) = {[s11(i+j)-s11(j) s12(i+j)-s12(j); s21(i+j)-s21(j) s22(i+j)-s22(j)]};
      else
         MP(i, j) = {[s11(D)-s11(j) s12(D)-s12(j); s21(D)-s21(j) s22(D)-s22(j)]};
      end
   end
end
K = (cell2mat(M)' * cell2mat(M) - diag(ones(1, Nu * nu) * lambda))^(-1) * cell2mat(M)';
ku = K(1:nu, :) * cell2mat(MP);
ke1 = sum(K(1, 1:2:(N * ny)));
ke2 = sum(K(1, 2:2:(N * ny)));
ke3 = sum(K(2, 1:2:(N * ny)));
ke4 = sum(K(2, 2:2:(N * ny)));
for k = 10:kk
    y(1,k) = symulacja_obiektu5y1(u(1, k - 7), u(1, k - 8), u(2, k - 2),...
                                  u(2, k - 3), y(1, k - 1), y(1, k - 2));
                              
    y(2,k) = symulacja_obiektu5y2(u(1, k - 3), u(1, k - 4), u(2, k - 4),...
                                  u(2, k - 5), y(2, k - 1), y(2, k - 2));
    Yzad(1:N) = {yzad(:,k)};
    Y(1:N) = {y(:,k)};
    du(:,k) = [ke1 ke2;ke3 ke4]*(yzad(:,k)-y(:,k))-ku*cell2mat(dUP);
    for n = D-1:-1:2
      dUP(n) = dUP(n-1);
    end
   dUP(1) = {du(:,k)};
   u(:,k) = u(:,k-1) + du(:,k);
end