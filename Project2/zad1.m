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
title('Wyjœcie dla Upp = 1');

% Do sprawozdania: 
% Celem zadania by³o sprawdzenie poprawnoœci podanego punktu pracy.
% Startujemy z punktu pracy (u,y,z) = (0,0,0) i zadajemy skok wartoœci
% sterowania Upp = 1. Zauwa¿amy, ¿e wyjœcie obiektu d¹¿y do danej wartoœci.
% Obiekt stabilizuje siê na wartoœci Y = 1.1022. Oraz nie wychodzi z punktu
% pracy