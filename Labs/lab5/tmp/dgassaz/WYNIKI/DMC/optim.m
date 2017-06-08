function [ y, T1,T2,K,Td,error ] = optim(s)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    %DMC optimization

 k = length(s);
%k = 1000;
nVars = 4; % optimizing 3 params, N, Nu and Lambda
lb = [0 0 0 0]; %lower bound
ub = [1000 1000 1000 k-100]; %upper bound
[x,error]= ga(@(x)(approx(x(1),x(2),x(3),x(4),1, s)),nVars,[],[],[],[],lb,ub,[],4);
%drawDMC
y = zeros(k,1);
u=ones(k,1)*1;
T1 = x(1);
T2 = x(2);
K = x(3);
Td = x(4);
%Td = int8(Td);
figure;
plot(s);
hold on;
alfa1 = exp(-1/T1);
alfa2 = exp(-1/T2);
a1 = -alfa1 - alfa2;
a2 = alfa1*alfa2;
b1 = (K/(T1-T2))*(T1*(1-alfa1) - T2*(1-alfa2));
b2 = (K/(T1-T2))*(alfa1*T2*(1-alfa2) - alfa2*T1*(1-alfa1));
for i = (Td+3):k
    y(i) = b1*u(i-Td-1) + b2*u(i-Td-2) - a1*y(i-1) - a2*y(i-2);
end

plot(y);


end
