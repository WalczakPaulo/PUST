 addpath ('F:\SerialCommunication'); % add a path
 initSerialControl COM3 % initialise com port


K = 5; %1.85 oscylacje niegasnace
Ti = 65;
Td = 1.25;
T = 1;

Umax = 100;
Umin = 0;

prevE = 0;
prevUi = 0;

Ypp = 31.5;
Upp = 27;
kk = 1200;
Yzad(1:1200) = 31.5

U = zeros(kk,1);
Y = zeros(kk,1);
error = 0;
% Y = zeros(kk,1);
sendControls ([ 1],[ 50]) ;
sendNonlinearControls(Upp);



 for k=1:kk
 %% obtaining measurements
Y(k) = readMeasurements(1) ; % read measurements
 %% processing of the measurements
 

 
%% controls PID
    Ytemp(k) = Y(k) - Ypp;
   
   % PID
   e = Yzad(k) - Ytemp(k) - Ypp;
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
%    if U(k) - U(k - 1) > dUmax
%       U(k) = U(k - 1) + dUmax;
%       disp('dUmax')
%    elseif U(k) - U(k - 1) < dUmin
%       U(k) = U(k - 1) - dUmin;
%       disp('dUmin')
%    end
   
   if U(k) > Umax
      U(k) = Umax;
      disp('Umax')
   elseif U(k) < Umin
      U(k) = Umin;
      disp('Umin')
   end
   disp([k,U(k),Y(k)]);
   % Aplikacja do obiektu
    

 %% sending new values of control signals
 sendNonlinearControls(U(k));


 %% synchronising with the control process
 waitForNewIteration (); % wait for new iteration
 plot(Y)
 drawnow
 end