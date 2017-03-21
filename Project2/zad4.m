clear
close all

load('s_u.mat');
s = s_u;
D = 100;
N = 20;
Nu = 5;
lambda = 1;

sim_time = 300;

Ypp = 0;
Upp = 0;

iter = 1;
for lambda = [10 5 2 0.5 0.2 0.1]
error = 0;
Yzad = zeros(N,1);
Y0 = zeros(N,1);
Yk = zeros(N,1);

U(1:8) = Upp;
Y(1:8) = Ypp;

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

yzad = zeros(sim_time,1);
yzad(50:end) = 1;
Z = zeros(1000,1);

for k = 9:sim_time
    Yk(1:end) = Y(k-1) - Ypp;
    Yzad(1:end) = yzad(k) - Ypp;
    Y0 = Yk + Mp*dUp;
    dU = K*(Yzad - Y0);
    
    
    dUp(2:end) = dUp(1:end-1);
    dUp(1) = dU(1);
    uk_1 = U(k-1) - Upp;
    ukk = uk_1 + dU(1);

    U(k) = ukk + Upp;
    Y(k) = symulacja_obiektu11y(U(k-7),U(k-8),Z(k-3),Z(k-4),Y(k-1),Y(k-2));
    error = error + (Y(k) - yzad(k))^2;
end

stairs(Y)
hold on
stairs(U)
stairs(yzad)
xlabel('k')
ylabel('value')
legend('Y(k)','U(k)','Yzad(k)','location','best');
Err(iter) = error;
iter = iter+1;

filename_y = strcat('zad4_y_lambda',int2str(lambda*10));
filename_u = strcat('zad4_u_lambda',int2str(lambda*10));
write_to_file(filename_y, 1:length(Y),Y);
write_to_file(filename_u, 1:length(U),U);
end