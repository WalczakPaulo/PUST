clear 
load('s.mat')
D = 150;
N = D;
Nu = 50;
lambda = 1;

Yzad = 5;
Yzad = zeros(N,1) + Yzad;

Y = zeros(N,1);
dU = zeros(Nu,1);
dUp = zeros(D-1,1);

M = zeros(N,Nu);
Mp = zeros(N,D-1);

for i = 1:N
    for j = 1:i
        if j == Nu + 1
            break
        end
        M(i,j) = s(i-j+1);
    end
end

for i = 1:N
    for j = 1:D-1
        Mp(i,j) = s(i+j)-s(j);
    end
end

K = (M'*M + lambda * eye(Nu))\M';

