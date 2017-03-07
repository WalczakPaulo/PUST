function [ error ] = dmcE(argN, argNu, argLambda, draw)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
load('s.mat');
D = 150;
N = argN;
Nu = argNu;
lambda = argLambda;
error = 0;
Ypp = 3;
Upp = 0.9;
Umin = 0.6;
Umax = 1.2;
dUmax = 0.1;
dUmin = -0.1;

Yzad = zeros(N,1);
Y0 = zeros(N,1);
Yk = zeros(N,1);

U(1:11) = Upp;
Y(1:11) = Ypp;

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

yzad(1:200) = 2.5;
yzad(201:400) = 2.8;
yzad(401:700) = 3.1;
yzad(701:1000) = 3.4;

for k = 12:1000
    Yk(1:end) = Y(k-1) - Ypp;
    Yzad(1:end) = yzad(k) - Ypp;
    Y0 = Yk + Mp*dUp;
    dU = K*(Yzad - Y0);
    if dU(1) > dUmax
        dU(1) = dUmax;
    elseif dU(1) < dUmin
       dU(1) = dUmin;
    end
    
    dUp(2:end) = dUp(1:end-1);
    dUp(1) = dU(1);
    
    uk_1 = U(k-1) - Upp;
    ukk = uk_1 + dU(1);

    if ukk < Umin - Upp
        ukk = Umin - Upp;
    elseif ukk > Umax - Upp
        ukk = Umax - Upp;
    end
    U(k) = ukk + Upp;
    Y(k) = symulacja_obiektu2Y(U(k-10),U(k-11),Y(k-1),Y(k-2));
    error = error + (yzad(k) - Y(k))^2;
end
if draw == true
   figure;
   subplot(2, 1, 1)
    stairs(Y)
    hold on
    stairs(yzad)
    title('Wyjście obiektu');
    xlabel('Chwila (k)')
    ylabel('Wartość wyjścia/zadana')
    legend('Y','Yzad','location','best');
    legend('boxoff')
    
    subplot(2, 1, 2)
    stairs(U)
    title('Sterowanie');
    xlabel('Chwila (k)')
    ylabel('Wartość sterowania')
    
    file = fopen('dmc_optim_y.txt', 'w');
    for i = 1:1000
       fprintf(file, '%f %f\n', i, Y(i));
    end
    fclose(file);
    
    file = fopen('dmc_optim_yzad.txt', 'w');
    for i = 1:1000
       fprintf(file, '%f %f\n', i, yzad(i));
    end
    fclose(file);
    
    file = fopen('dmc_optim_u.txt', 'w');
    for i = 1:1000
       fprintf(file, '%f %f\n', i, U(i));
    end
    fclose(file);
end
end

