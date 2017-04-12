 addpath ('F:\SerialCommunication'); % add a path
 initSerialControl COM17 % initialise com port


s11 = csvread('approx/approx_s11.csv');
s12 = csvread('approx/approx_s12.csv');
s21 = csvread('approx/approx_s21.csv');
s22 = csvread('approx/approx_s22.csv');
s11 = s11(2:end);
s12 = s12(2:end);
s21 = s21(2:end);
s22 = s22(2:end);

D = 250;
N = 250;
Nu = 250;
lambda = 10;
Upp1 = 27;
Upp2 = 32;
Y0 = zeros(2*N, 1);

Yzad = zeros(2*N, 1);

Y1 = zeros(1000, 1);
Y2 = zeros(1000, 1);
U1 = Upp1*ones(1000, 1);
U2 =  Upp2*ones(1000, 1);
yzad1 = zeros(500, 1);
yzad1(1:200) = 38;
yzad1(201:end) = 41;
yzad2 = zeros(500, 1);
yzad2(1:200) = 38;
yzad2(201:end) = 41;


Zy1 = 0*ones(1000, 1);
Zy1(1:400) = 0;
Zy2 = 0*ones(1000, 1);

dU = zeros(2*Nu, 1);
dUp = zeros(2*(D-1),1);

M = zeros(N*2, Nu*2);
Mp = zeros(N*2, (D - 1) * 2);

for i = 1:N
   for j = 1:i
      if j == Nu + 1
         break
      end
      M(2*i-1:2*i, 2*j-1:2*j) = [s11(i-j+1), s12(i-j+1); s21(i-j+1), s22(i-j+1)];
   end
end
   
for i = 1:N
   for j = 1:(D-1)
      Mp(2*i-1:2*i, 2*j-1:2*j) = [s11(i+j) - s11(j), s12(i+j) - s12(j); ...
         s21(i+j) - s21(j), s22(i+j) - s22(j)];
   end
end

phi = eye(2*N);
Lambda = lambda*eye(2*Nu);

K = ((M'*phi*M + Lambda)^(-1))*M'*phi;

figure;
for k = 9:500
   Y1(k) = readMeasurements ([1]) ; % read measurements 
   Y2(k) = readMeasurements ([3]) ; % read measurements 
   Yk(1:2:end) = Y1(k-1) + Zy1(k - 1);
   Yk(2:2:end) = Y2(k-1) + Zy2(k - 1);
   
   Yzad(1:2:end) = yzad1(k);
   Yzad(2:2:end) = yzad2(k);
   
   Y0 = Yk + Mp*dUp;
   dU = K*(Yzad - Y0);
   
   dUp(3:end) = dUp(1:end-2);
   dUp(1:2) = dU(1:2);
   
   U1(k) = U1(k - 1) + dU(1) ;
   U2(k) = U2(k - 1) + dU(2) ;
   if(U1(k) > 100 )
       U1(k) = 100;
   elseif(U1(k) < 0 )
       U1(k) = 0;
   end
   if(U2(k) > 100 )
       U2(k) = 100;
   elseif(U2(k) < 0 )
       U2(k) = 0;
   end
   sendControls([1,2,5,6],[50,50,U1(k),U2(k)]);
   subplot(211)
   plot(Y1(:))
   subplot(212)
   plot(Y2(:))
   drawnow
   disp(k)
   disp([Y1(k),Y2(k)]);
   disp([U1(k),U2(k)]);
   waitForNewIteration (); % wait for new iteration
end