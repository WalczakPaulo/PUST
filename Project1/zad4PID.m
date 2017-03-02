% Regulator PID

clear all

% Ustawienia symulacji
N = 300;
Yzad = ones(N, 1) * 5;

% Nastawy regulatora
K = 0.1;
Ti = Inf;
Td = 0;
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
   % Przesunięcie punktu pracy
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
   
   % Przesunięcie punktu pracy pt. 2
   U(k) = U(k) + Upp;
   
   % Uwzględnienie ograniczeń
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
end

hold on
plot(Y)
