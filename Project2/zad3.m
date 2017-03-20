clear;
%Odpowiedz skokowa na sterowanie
Tp = 0.5;
Upp = 0;
Ypp = 0;
dU = 1;
N = 300;
U = zeros(N,1);
U(9:N) = dU;
Y = zeros(N,1);
Z = zeros(N,1);
s_u = zeros(N-8,1);

for k = 9:N
    Y(k) = symulacja_obiektu11y(U(k-7),U(k-8),Z(k-3),Z(k-4),Y(k-1),Y(k-2));
    s_u(k-8) = Y(k);
end

%%Normalizacja odp skokowej
s_u = (s_u-Ypp)/dU;

%%Wykres
figure;
stairs(s_u)
ylabel('Wyjscie (y)')
xlabel('Iteracje')
title('Odp. skokowa na sterowanie')

%Odpowiedz skokowa na sterowanie
U = zeros(N,1);
Y = zeros(N,1);
Z = zeros(N,1);
dZ = 1;
Z(9:N) = dZ;
s_z = zeros(N-8,1);

for k = 9:N
    Y(k) = symulacja_obiektu11y(U(k-7),U(k-8),Z(k-3),Z(k-4),Y(k-1),Y(k-2));
    s_z(k-8) = Y(k);
end
%%Normalizacja odp skokowej
s_z = (s_z - Ypp)/dZ;
%%I wykres odp skokowej
figure;
stairs(s_z);
title('Odp skokowa na zaklocenie');
ylabel('Wyjscie (y)');
xlabel('Iteracje');
