clear

Upp = 0.9;
dU = 0.3;
Ypp = 3;
N = 300;
U(1:N) = Upp + dU;
Y(1:10) = Ypp;
Y(11) = symulacja_obiektu2Y(U(1),Upp,Y(10),Y(9));
for k = 12:N
    Y(k) = symulacja_obiektu2Y(U(k-10),U(k-11),Y(k-1),Y(k-2));
end
s = (Y - Ypp)/dU;
s = s(2:end);
stairs(s)
title('Odpowiedz skokowa')
xlabel('chwila k')
ylabel('wartość s_n')