function [error] = pid_zwykly(argK, argTi, argTd, draw)
%OPTYMALNE WEDŁUG FMINCON: K = 0.3004, Ti = 6.9992, Td = 2.0577
close all
K = argK;
Ti = argTi;
Td = argTd;

error = 0;
start = 7;
N = 1200;

Tp = 0.5;

Upp = 0;
Ypp = 0;

u = Upp*ones(N, 1);
y = Ypp*ones(N, 1);

Umin = -1;
Umax = 1;

prevE = 0;
prevUi = 0;

yzad(1:250) = 1;
yzad(251:500) = 3;
yzad(501:750) = 2;
yzad(751:N) = -0.07;
for k = start:N
    e = yzad(k-1) - y(k-1);
    
    uP = K*e;
    uI = prevUi + (K/Ti) * Tp * (prevE + e) / 2;
    uD = K * (Td/Tp) * (e - prevE);
    u(k) = uP + uI + uD;
    
    prevE = e;
    prevUi = uI;
    
    u(k) = u(k) + Upp;
    
    if u(k) > Umax
      u(k) = Umax;
    elseif u(k) < Umin
      u(k) = Umin;
    end
    
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
    write_to_file(['y_pid_' num2str(argK) '_' num2str(argTi) '_' num2str(argTd)], 1:N, y')
    write_to_file('zad4_yzad', 1:N, yzad)
    write_to_file(['u_pid_' num2str(argK) '_' num2str(argTi) '_' num2str(argTd)], 1:N, u')

%     csvwrite('sprawko/wykresy/zad3_pid_y.csv', y)
%     csvwrite('sprawko/wykresy/zad3_pid_u.csv', u)
end