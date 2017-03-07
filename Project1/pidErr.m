% Regulator PID
function [error] = pidErr(argK, argTd, argTi, draw)

% Ustawienia symulacji
N = 1000;
Yzad = ones(N,1);
Yzad(1:200) = 2.6;
Yzad(201:400) = 2.8;
Yzad(401:700) = 3.1;
Yzad(701:1000) = 3.4;
error = 0;
% Nastawy regulatora
K = argK; %1.85 oscylacje niegasnace
Ti =argTi;
Td = argTd;
T = 0.5;

% Charakterystyka obiektu
Upp = 0.9;
Ypp = 3.0;
U = ones(N, 1) * Upp;
Y = ones(N, 1) * Ypp;

% Ograniczenia
Umax = 1.2;
Umin = 0.6;
dUmax = 0.1;
dUmin = -0.1;

% Symulacja

prevE = 0;
prevUi = 0;

for k = 12:N
   % Przesuni�cie punktu pracy
   Yk = Y(k - 1) - Ypp;
   yzad = Yzad(k-1) - Ypp;
   % PID
   e = yzad - Yk;
%    e = Yzad(k - 1) - Y(k - 1);
   
   uP = K * e;
   uI = prevUi + (K / Ti) * T * (prevE + e) / 2;
   uD = K * (Td / T) * (e - prevE);
   U(k) = uP + uI + uD;
   
   prevE = e;
   prevUi = uI;
   
   % Przesuni�cie punktu pracy pt. 2
   U(k) = U(k) + Upp;
   
   % Uwzgl�dnienie ogranicze�
   if U(k) - U(k - 1) > dUmax
      U(k) = U(k - 1) + dUmax;
      disp('dUmax')
   elseif U(k) - U(k - 1) < dUmin
      U(k) = U(k - 1) + dUmin;
      disp('dUmin')
   end
   
   if U(k) > Umax
      U(k) = Umax;
      disp('Umax')
   elseif U(k) < Umin
      U(k) = Umin;
      disp('Umin')
   end
   
   % Aplikacja do obiektu
   Y(k) = symulacja_obiektu2Y(U(k - 10), U(k - 11), Y(k - 1), Y(k - 2));
   error = error + (Yzad(k) - Y(k))^2;
end
if draw == true
figure;
subplot(2, 1, 1);
stairs(Y)
hold on
stairs(Yzad)
legend('Y','Yzad','location','best');
legend('boxoff')
title('Wyjście obiektu');

xlabel('Czas');
ylabel('Wyjście (y)');
subplot(2, 1, 2);
stairs(U)
title('Sterowanie')
xlabel('Czas')
ylabel('Sterowanie (u)')
end
end