% clear
% close all

% load('s.mat')
D = 200;
N = D;
Nu = D;
lambda = 1;

Ypp = 33.42;
Upp = 27;
Umin = 0;
Umax = 100;
% dUmax = 0.1;
% dUmin = -0.1;

Yzad = zeros(N,1);
Y0 = zeros(N,1);
Yk = zeros(N,1);

% U(1:11) = Upp;
% Y(1:11) = Ypp;

dU = zeros(Nu,1);
dUp = zeros(D-1,1);

M = zeros(N,Nu);
Mp = zeros(N,D-1);

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
        Mp(i,j) = s2(i+j)-s2(j);
    end
end

K = (M'*M + lambda * eye(Nu))\M';

yzad(1:400) = 36;
yzad(401:1000) = 40;
% yzad(401:700) = 3.1;
% yzad(701:1000) = 3.4;
Y(1:19) = Ypp;
U(1:19) = Upp;
for k = 20:1000
    Y(k) = readMeasurements(1) ;
    Yk(1:end) = Y(k) - Ypp;
    Yzad(1:end) = yzad(k) - Ypp;
    Y0 = Yk + Mp*dUp;
    dU = K*(Yzad - Y0);
    
    dUp(2:end) = dUp(1:end-1);
    dUp(1) = dU(1);

    uk_1 = U(k-1) - Upp;
    ukk = uk_1 + dU(1);

    if ukk < Umin - Upp
        ukk = Umin - Upp;
    elseif ukk > Umax - Upp
        ukk = Umax - Upp;
    end
    U(k) = ukk + Upp;
    sendControls ([ 5],[U(k)]) ;

    disp([k,U(k),Y(k)]);
    waitForNewIteration ();
     plot(Y)
     drawnow
end

stairs(Y)
hold on
stairs(U)
stairs(yzad)
xlabel('k')
ylabel('value')
legend('Y(k)','U(k)','Yzad(k)','location','best');
