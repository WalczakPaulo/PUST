% clear
% close all
addpath('F:\SerialCommunication'); % add a path to the functions
initSerialControl COM4 % initialise com port
s2 = csvread('approx_s_poprawiuonelol');
s_z = csvread('odp_zakl.csv');
D = 100;
N = D;
Nu = D;
lambda = 1;
DZ = 100;
Ypp = 32;
Upp = 27;
Umin = 0;
Umax = 100;
% dUmax = 0.1;
% dUmin = -0.1;
czas_sym = 600;
Yzad = zeros(N,1);
Y0 = zeros(N,1);
Yk = zeros(N,1);
z(1:czas_sym) = 0;
e = zeros(1,czas_sym);
% U(1:11) = Upp;
% Y(1:11) = Ypp;
deltaup = zeros(1,D-1);
    deltazp = zeros(1,DZ-1);
dU = zeros(Nu,1);
dUp = zeros(D-1,1);

M = zeros(N,Nu);
MP = zeros(N,D-1);

for i = 1:N
    for j = 1:i
        if j == Nu + 1
            break
        end
        M(i,j) = s2(i-j+1);
    end
end

for i = 1:N
    for j = 1:D-1
        MP(i,j) = s2(i+j)-s2(j);
    end
end

MZP=zeros(N,DZ);
for i=1:N
    MZP(i,1) = sz(i);
   for j=2:DZ
      if i+j-1<=DZ
         MZP(i,j)=sz(i+j-1)-sz(j);
      else
         MZP(i,j)=sz(DZ)-sz(j);
      end;      
   end;
end;

MZP = zeros(N,DZ-1);
    for i = 1:N
       for j = 1:DZ-1
          if i+j <= DZ
             MZP(i,j) = s_z(i+j)-s_z(j);
          else
             MZP(i,j) = s_z(DZ)-s_z(j);
          end
       end
    end


I = eye(Nu);
    K = ((M'*M+lambda*I)^-1)*M';
    ku = K(1,:)*MP;
    kz = K(1,:)*MZP;
    ke = sum(K(1,:));

yzad(1:20) = Ypp;
yzad(21:600) = 35;
% yzad(401:700) = 3.1;
% yzad(701:1000) = 3.4;
y(1:19) = Ypp;
u(1:19) = Upp;
for k =20:600
       %symulacja obiektu
       
       y(k) = readMeasurements(1);
       %uchyb regulacji
       e(k) = yzad(k) - y(k);

       for n = DZ-1:-1:2
           deltazp(n) = deltazp(n-1);
       end
       deltazp(1) = z(k)-z(k-1);

       % Prawo regulacji
       deltauk = ke*e(k)-ku*deltaup';
       deltauk = deltauk-kz*deltazp';

       for n = D-1:-1:2
          deltaup(n) = deltaup(n-1);
       end
       deltaup(1) = deltauk;
       u(k) = u(k-1) + deltaup(1);
       if k <= 400
            sendControlsToG1AndDisturbance(u(k),0);
       else
           sendControlsToG1AndDisturbance(u(k),15);
           end
       waitForNewIteration();
       
       plot(y);
       drawnow;
    end
    
stairs(y)
hold on
stairs(U)
stairs(yzad)
xlabel('k')
ylabel('value')
legend('Y(k)','U(k)','Yzad(k)','location','best');
