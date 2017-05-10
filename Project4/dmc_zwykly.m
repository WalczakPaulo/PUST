function [error] = dmc_zwykly(N, Nu, lambda, draw)
%OPTYMALNE WEGŁUG GA: N = 26, Nu = 1, lambda = 41.4768
close all

error = 0;
start = 7;
kend = 1200;

load('s.mat')
D = 50;

Ypp = 0;
Upp = 0;

Umin = -1;
Umax = 1;



Yzad = zeros(N,1);
Y0 = zeros(N,1);
Yk = zeros(N,1);

u(1:start) = Upp;
y(1:start) = Ypp;


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
yzad(501:750) = 2;
yzad(751:kend) = -0.07;

for k = start:kend
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
    figure
    plot(y)
    hold on
    plot(yzad)
    figure
    plot(u)
%     write_to_file(['y_dmc_' num2str(argN) '_' num2str(argNu) '_' num2str(argLambda)], 1:kend, y)
%     write_to_file('zad4_yzad', 1:kend, yzad)
%     write_to_file(['u_dmc_' num2str(argN) '_' num2str(argNu) '_' num2str(argLambda)], 1:kend, u)
end