% sprawdzenie charakterystyki statycznej

clear all
N = 300;
Upp = 0.9;
Ypp = 3;
y = [];
U(1:10) = Upp;
U(11:N) = 0.6;
Y(1:11) = Ypp;
for skok = 0.6:0.01:1.2
   U(11:N) = skok;
   for k = 12:N
       Y(k)=symulacja_obiektu2Y(U(k-10),U(k-11),Y(k-1),Y(k-2));
   end
   y = [y, Y(N)];
end
plot(0.6:0.01:1.2, y)
xlabel('sterowanie (u)')
ylabel('wyjście (y)')