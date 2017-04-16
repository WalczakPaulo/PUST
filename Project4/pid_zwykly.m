function [error] = pid_zwykly(argK, argTi, argTd, draw)

error = 0;

kstart = 7;
N = 500;

% K = 2;
% Ti = 10;
% Td = 0;

K = argK;
Ti = argTi;
Td = argTd;

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
yzad(251:N) = 3;

for k = kstart:N
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
    csvwrite('sprawko/wykresy/zad3_pid_y.csv', y)
    csvwrite('sprawko/wykresy/zad3_pid_u.csv', u)
end
ylabel(u)