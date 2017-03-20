clear;

%%Skok sterowania i odpowiedz
N = 200;
Upp = 0;
Ypp = 0;
skoki_u = [-2 -1.5 -1 -0.5 0.5 1 1.5 2];
U = zeros(N,1);
Y = zeros(N,1);
Z = zeros(N,1);

i = 1;
for skok = skoki_u
   U(9:N) = skok;
   for k = 9:N
        Y(k) = symulacja_obiektu11y(U(k-7),U(k-8),Z(k-3),Z(k-4),Y(k-1),Y(k-2));
   end
   hold on
   stairs(Y)
   
   filename = strcat('zad2_yu_', int2str(i));
   write_to_file(filename,1:length(Y),Y');
   i = i+1;
end

legend(string(skoki_u))
legend('boxoff')
legend('location', 'northwest')
xlabel('Iteracje')
ylabel('wyjście (y) od skoków sterowania')

%%Skok zak��ce� i odpowiedx
skoki_z = [-2 -1.5 -1 -0.5 0.5 1 1.5 2];
U = zeros(N,1);
Y = zeros(N,1);
Z = zeros(N,1);

i = 1;
figure
for skok = skoki_z
   Z(9:N) = skok;
   for k = 9:N
        Y(k)=symulacja_obiektu11y(U(k-7),U(k-8),Z(k-3),Z(k-4),Y(k-1),Y(k-2));
   end
   hold on
   stairs(Y)
   
   filename = strcat('zad2_yz_', int2str(i));
   write_to_file(filename,1:length(Y),Y');
   i = i+1;
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

for skok_u = -1.5:0.01:1.5
   U(9:N) = skok_u;
   for k = 9:N
        Y(k)=symulacja_obiektu11y(U(k-7),U(k-8),Z(k-3),Z(k-4),Y(k-1),Y(k-2));
   end
   y_stat_u = [y_stat_u, Y(N)];
end
write_to_file('zad2_y_stat_u', -1.5:0.01:1.5, y_stat_u);

figure
plot(-1.5:0.01:1.5, y_stat_u)
xlabel('sterowanie (u)')
ylabel('wyjście (y)')
title('Charaktertystyka statyczna y(u)')

%%Charakterystyka statyczna y(z) dla punktu pracy (y,u) = (0,0)
y_stat_z = [];
U = zeros(N,1);
Y = zeros(N,1);
Z = zeros(N,1);

for skok_z = -1.5:0.01:1.5
   Z(9:N) = skok_z;
   for k = 9:N
        Y(k)=symulacja_obiektu11y(U(k-7),U(k-8),Z(k-3),Z(k-4),Y(k-1),Y(k-2));
   end
   y_stat_z = [y_stat_z, Y(N)];
end
write_to_file('zad2_y_stat_z', -1.5:0.01:1.5, y_stat_z);

figure
plot(-1.5:0.01:1.5, y_stat_z)
xlabel('zakłócenie (z)')
ylabel('wyjście (y)')
title('Charaktertystyka statyczna y(z)')
