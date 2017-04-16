function [error] = dmc_zwykly(argN, argNu, argLambda, draw)
%OPTYMALNE WEGŁUG GA: N = 26, Nu = 1, lambda = 41.4768
N = argN;
Nu = argNu;
lambda = argLambda;

error = 0;
kstart = 7;
kend = 500;

load('s.mat')
D = 50;

Ypp = 0;
Upp = 0;

Umin = -1;
Umax = 1;



Yzad = zeros(N,1);
Y0 = zeros(N,1);
Yk = zeros(N,1);

u(1:kstart) = Upp;
y(1:kstart) = Ypp;


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

yzad(1:250) = 1;
yzad(251:500) = 3;

for k = kstart:kend
    Yk(1:end) = y(k-1);
    Yzad(1:end) = yzad(k);
    Y0 = Yk + Mp*dUp;
    dU = K*(Yzad - Y0);

    
    dUp(2:end) = dUp(1:end-1);
    dUp(1) = dU(1);
    
    ukk = u(k-1) + dU(1);
    if ukk < Umin
        ukk = Umin;
    elseif ukk > Umax
        ukk = Umax;
    end
    u(k) = ukk;
    y(k) = symulacja_obiektu5y(u(k-5), u(k-6), y(k-1), y(k-2));
    error = error + (yzad(k) - y(k))^2;
end

if draw
    csvwrite('sprawko/wykresy/zad3_dmc_y.csv', y)
    csvwrite('sprawko/wykresy/zad3_dmc_u.csv', u)
end