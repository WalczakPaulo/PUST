clear all;

%%Skok sterowania i odpowiedz
N = 150;
Upp = 1;
Ypp = 1.1022;
skoki_u = [0.5 1 1.5 2];
U(1:8) = Upp;
U(9:N) = 0.6;
Y(1:N) = Ypp;
Z(1:N) = 0

for skok = skoki_u
   U(9:N) = skok;
   for k = 12:N
        Y(k)=symulacja_obiektu11y(U(k-7),U(k-8),Z(k-3),Z(k-4),Y(k-1),Y(k-2));
   end
   hold on
   stairs(Y)
end

legend(string(skoki_u))
legend('boxoff')
legend('location', 'northwest')
xlabel('Iteracje')
ylabel('wyjœcie (y) od skoków sterowania')

%%Skok zak³óceñ i odpowiedx
skoki_z = [0.5 1 1.5 2];
U(1:N) = Upp;
Y(1:N) = Ypp;
Z(1:4) = 0
figure
for skok = skoki_z
   Z(5:N) = skok;
   for k = 12:N
        Y(k)=symulacja_obiektu11y(U(k-7),U(k-8),Z(k-3),Z(k-4),Y(k-1),Y(k-2));
   end
   hold on
   stairs(Y)
end

legend(string(skoki_z))
legend('boxoff')
legend('location', 'northwest')
xlabel('Iteracje')
ylabel('wyjœcie (y) od skoku zak³óceñ')

%%Charakterystyka statyczna y(u)
N = 300;
y_stat_u = [];
U(1:N) = Upp;
Y(1:8) = Ypp;
Z(1:N) = 0

for skok_u = 0:0.01:1.5
   U(9:N) = skok_u;
   for k = 9:N
        Y(k)=symulacja_obiektu11y(U(k-7),U(k-8),Z(k-3),Z(k-4),Y(k-1),Y(k-2));
   end
   y_stat_u = [y_stat_u, Y(N)];
end
figure
plot(0:0.01:1.5, y_stat_u)
xlabel('sterowanie (u)')
ylabel('wyjœcie (y)')
title('Charaktertystyka statyczna y(u)')

%%Charakterystyka statyczna y(z)
y_stat_z = [];
U(1:N) = Upp;
Y(1:N) = Ypp;
Z(1:4) = 0

for skok_z = 0:0.01:1.5
   Z(5:N) = skok_z;
   for k = 9:N
        Y(k)=symulacja_obiektu11y(U(k-7),U(k-8),Z(k-3),Z(k-4),Y(k-1),Y(k-2));
   end
   y_stat_z = [y_stat_z, Y(N)];
end
figure
plot(0:0.01:1.5, y_stat_z)
xlabel('zak³ócenie (z)')
ylabel('wyjœcie (y)')
title('Charaktertystyka statyczna y(z)')
