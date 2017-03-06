% Regulator PID

clear all

% Ustawienia symulacji
N = 1000;
Yzad = ones(N,1);
Yzad(1:200) = 0.1;
Yzad(200:400)=0.2;
Yzad(400:600)=0.3;
Yzad(600:800)=0.35;
Yzad(800:10000)=0.4;
error = 0;
% Nastawy regulatora
K = 1.85 / 2; %1.85 oscylacje niegasnace
Ti = 30;
Td = 2.5;
T = 0.5;

% Charakterystyka obiektu
Upp = 0.9;
Ypp = 3.0;
U = ones(N, 1) * Upp;
Y = ones(N, 1) * Ypp;
Ytemp = zeros(N, 1);

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
   Ytemp(k - 1) = Y(k - 1) - Ypp;
   
   % PID
   e = Yzad(k - 1) - Ytemp(k - 1);
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
      U(k) = U(k - 1) - dUmin;
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
   error = error + (Yzad(k) + Ypp - Y(k))^2;
end

figure;
subplot(2, 1, 1);
stairs(Y)
% % Zakomentowany fragment wyznacza przedzia� +/- 10% warto�ci zadanej
% hold on
% plot(Yzad*0.9 + Ypp, '--', 'Color', [.9 0 0])
% hold on
% plot(Yzad*1.1 + Ypp, '--', 'Color', [.9 0 0])
title('Wyj�cie obiektu');
xlabel('Czas');
ylabel('Wyj�cie (y)');
subplot(2, 1, 2);
stairs(U)
title('Sterowanie')
xlabel('Czas')
ylabel('Sterowanie (u)')