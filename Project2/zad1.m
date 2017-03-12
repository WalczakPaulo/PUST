clear all;

Tp=0.5;
Upp = 1; 
n = 500
U = ones(n,1)*Upp;
Y = zeros(n,1);
Z = zeros(n,1);
for k=9:n
    Y(k)=symulacja_obiektu11y(U(k-7),U(k-8),Z(k-3),Z(k-4),Y(k-1),Y(k-2));
end  %U(k-4),U(k-5)

plot(Y);
ylabel('y');
xlabel('Krok');
legend('Y(k)');
title('Wyj�cie dla Upp = 1');

% Do sprawozdania: 
% Celem zadania by�o sprawdzenie poprawno�ci podanego punktu pracy.
% Startujemy z punktu pracy (u,y,z) = (0,0,0) i zadajemy skok warto�ci
% sterowania Upp = 1. Zauwa�amy, �e wyj�cie obiektu d��y do danej warto�ci.
% Obiekt stabilizuje si� na warto�ci Y = 1.1022. Oraz nie wychodzi z punktu
% pracy