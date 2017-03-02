Upp = 0.9;
dU = 0.3;
Ypp = 3;
N = 150;
U(1:N) = Upp + dU;
Y(1:11) = Ypp;

for k = 12:N
    Y(k) = symulacja_obiektu2Y(U(k-10),U(k-11),Y(k-1),Y(k-2));
end
s = (Y - Ypp)/dU;
% s(1:11) = [];
plot(s)