clear

load('s.mat')
D = 150;
N = D;
Nu = D;
lambda = 1;

Ypp = 3;
Upp = 0.9;
Umin = 0.6;
Umax = 1.2;
dUmax = 0.1;

Yzad = zeros(N,1);
Y0 = zeros(N,1);
Yk = zeros(N,1);

U(1:11) = Upp;
Y(1:11) = Ypp;

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

yzad(1:200) = 2.5;
yzad(201:400) = 2.8;
yzad(401:700) = 3.1;
yzad(701:1000) = 3.4;

for k = 12:1000
    Yk(1:end) = Y(k-1);
    Yzad(1:end) = yzad(k);
    Y0 = Yk + Mp*dUp;
    dU = K*(Yzad - Y0);
    if dU(1) > dUmax
        dU(1) = dUmax;
    end
    
    dUp(2:end) = dUp(1:end-1);
    dUp(1) = dU(1);
    
    ukk = U(k-1) + dU(1);
    if ukk < Umin
        ukk = Umin;
    elseif ukk > Umax
        ukk = Umax;
    end
    U(k) = ukk;
    Y(k) = symulacja_obiektu2Y(U(k-10),U(k-11),Y(k-1),Y(k-2));
end

stairs(Y)
hold on
stairs(U)
stairs(yzad)
xlabel('k')
ylabel('value')
legend('Y(k)','U(k)','Yzad(k)','location','best');
