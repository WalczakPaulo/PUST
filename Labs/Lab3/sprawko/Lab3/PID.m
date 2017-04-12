addpath ('F:\SerialCommunication'); % add a path
initSerialControl COM17 % initialise com port
N = 500;
Yz1 = ones(N, 1);
Yz2 = ones(N, 1);
Yz1(1:200) = 38;
Yz2(1:200) = 38;
Yz1(201:end) = 41;
Yz2(201:end) = 41;
y1 = zeros(N, 1);
y2 = zeros(N, 1);
U1 = zeros(N, 1);
U2 = zeros(N, 1);


Upp1 = 27;
Upp2 = 32;
Ypp1 = 35.5;
Ypp2 = 37.06;


K1 = 5;
Ti1 = 30;
Td1 = 2.5;

K2 = 5;
Ti2 = 30;
Td2 = 2.5;

T = 0.5;


prevE1 = 0;
prevE2 = 0;
prevUi1 = 0;
prevUi2 = 0;
figure;
for k = 2:N
   y1(k) = readMeasurements (1) ; % read measurements
   y2(k) = readMeasurements (3) ; % read measurements
   e1 = Yz1(k - 1) - y1(k - 1) ;
   e2 = Yz2(k - 1) - y2(k - 1);
   uP1 = K1 * e1;
   uI1 = prevUi1 + (K1 / Ti1) * T * (prevE1 + e1) / 2;
   uD1 = K1 * (Td1 / T) * (e1 - prevE1);
   U1(k) = uP1 + uI1 + uD1;
   
   uP2 = K2 * e2;
   uI2 = prevUi2 + (K2 / Ti2) * T * (prevE2 + e2) / 2;
   uD2 = K2 * (Td2 / T) * (e2 - prevE2);
   U2(k) = uP2 + uI2 + uD2;
   U1(k) = U1(k)  + Upp1;
   U2(k) = U2(k) + Upp2;
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
   sendControls([1,2,5,6],[50,50,U1(k), U2(k)]);
   subplot(211)
   plot(y1(:))
   subplot(212)
   plot(y2(:))
   drawnow
   disp(k)
   disp([y1(k),y2(k)]);
   disp([U1(k),U2(k)]);
   waitForNewIteration (); % wait for new iteration
   prevE1 = e1;
   prevE2 = e2;
   prevUi1 = uI1;
   prevUi2 = uI2;
end