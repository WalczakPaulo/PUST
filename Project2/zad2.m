clear;

%%Skok sterowania i odpowiedz
N = 200;
Upp = 0;
Ypp = 0;
skoki_u = [0.5 1 1.5 2];
U = zeros(N,1);
Y = zeros(N,1);
Z = zeros(N,1);

for skok = skoki_u
   U(9:N) = skok;
   for k = 9:N
        Y(k)=symulacja_obiektu11y(U(k-7),U(k-8),Z(k-3),Z(k-4),Y(k-1),Y(k-2));
   end
   hold on
   stairs(Y)
end

legend(string(skoki_u))
legend('boxoff')
legend('location', 'northwest')
xlabel('Iteracje')
ylabel('wyjście (y) od skoków sterowania')

%%Skok zak��ce� i odpowiedx
skoki_z = [0.5 1 1.5 2];
U(1:N) = Upp;
Y(1:N) = Ypp;
Z(1:8) = 0;
figure
for skok = skoki_z
   Z(9:N) = skok;
   for k = 9:N
        Y(k)=symulacja_obiektu11y(U(k-7),U(k-8),Z(k-3),Z(k-4),Y(k-1),Y(k-2));
   end
   hold on
   stairs(Y)
end

legend(string(skoki_z))
legend('boxoff')
legend('location', 'northwest')
xlabel('Iteracje')
ylabel('wyjście (y) od skoku zakłóceń')

%%Charakterystyka statyczna y(u) dla punktu pracy y(z) = 0
N = 200;
y_stat_u = [];
U = zeros(N,1);
Y = zeros(N,1);
Z = zeros(N,1);

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
ylabel('wyjście (y)')
title('Charaktertystyka statyczna y(u)')

%%Charakterystyka statyczna y(z) dla punktu pracy (y,u) = (0,0)
y_stat_z = [];
U = zeros(N,1);
Y = zeros(N,1);
Z = zeros(N,1);

for skok_z = 0:0.01:1.5
   Z(9:N) = skok_z;
   for k = 9:N
        Y(k)=symulacja_obiektu11y(U(k-7),U(k-8),Z(k-3),Z(k-4),Y(k-1),Y(k-2));
   end
   y_stat_z = [y_stat_z, Y(N)];
end
figure
plot(0:0.01:1.5, y_stat_z)
xlabel('zakłócenie (z)')
ylabel('wyjście (y)')
title('Charaktertystyka statyczna y(z)')
