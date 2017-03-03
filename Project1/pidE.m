function [ error ] = pidE( argK,argTi,argTd, draw )
N = 300;
Yzad = ones(N, 1) * 0.2;

% Nastawy regulatora
% K = 1.85 / 2; %1.85 oscylacje niegasnace
% Ti = 30;
% Td = 2.5;
% 
K = argK;
Ti = argTi;
Td = argTd;
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
error = 0;
prevE = 0;
prevUi = 0;

for k = 12:N
   % Przesuniêcie punktu pracy
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
   
   % Przesuniêcie punktu pracy pt. 2
   U(k) = U(k) + Upp;
   
   % Uwzglêdnienie ograniczeñ
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
   error = error + (Yzad(k) + Ypp - Y(k))^2; %magic
end
if draw == true
    figure;
    subplot(2, 1, 1);
    stairs(Y)
    title('Wyjœcie obiektu');
    xlabel('Czas');
    ylabel('Wyjœcie (y)');
    subplot(2, 1, 2);
    stairs(U)
    title('Sterowanie')
    xlabel('Czas')
    ylabel('Sterowanie (u)')
end
end


