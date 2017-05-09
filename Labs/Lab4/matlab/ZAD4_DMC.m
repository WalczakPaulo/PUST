D = 500;
N = D;
Nu = D;
lambda = 1;

Ypp = 31.5;
Upp = 27;
Umin = 0;
Umax = 100;
% dUmax = 0.1;
% dUmin = -0.1;

s = csvread('skok_approx.csv');
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
        M(i,j) = s(i-j+1);
    end
end

for i = 1:N
    for j = 1:D-1
        Mp(i,j) = s(i+j)-s(j);
    end
end

K = (M'*M + lambda * eye(Nu))\M';

kk = 1200;
yzad(1:200) = 34;
yzad(201:400) = 37;
yzad(401:600) = 40;
yzad(601:800) = 43;
yzad(801:1000) = 46;
yzad(1001:1200) = 41;
Y(1) = Ypp;
U(1) = Upp;

for k = 2:kk
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
    sendNonlinearControls(U(k));

    disp([k,U(k),Y(k)]);
    waitForNewIteration ();
     plot(Y)
     drawnow
end