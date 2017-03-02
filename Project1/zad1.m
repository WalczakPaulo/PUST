N = 300;
Upp = 0.9;
U(1:N) = Upp;
Y(1:11) = 0;
for k = 12:N
    Y(k)=symulacja_obiektu2Y(U(k-10),U(k-11),Y(k-1),Y(k-2));
end
plot(Y)