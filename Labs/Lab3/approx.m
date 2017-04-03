function [ error] = approx(T1, T2, K, Td, skok )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
load('s.mat');
k = length(s);
error = 0;
errorVec = zeros(k,1);
y = zeros(k,1);
u = ones(k,1)*skok;
alfa1 = exp(-1/T1);
alfa2 = exp(-1/T2);
a1 = -alfa1 - alfa2;
a2 = alfa1*alfa2;
b1 = (K/(T1-T2))*(T1*(1-alfa1) - T2*(1-alfa2));
b2 = (K/(T1-T2))*(alfa1*T2*(1-alfa2) - alfa2*T1*(1-alfa1));
for i = (Td+3):k
    y(i) = b1*u(i-Td-1) + b2*u(i-Td-2) - a1*y(i-1) - a2*y(i-2);
end

for i = 1:k
    error = error + (y(i) - s(i))^2;
end
end

