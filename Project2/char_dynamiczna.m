clear;

n = 200;
start = 9;
du = 0:0.01:0.5;
skoki = length(du);
u = zeros(n,1);
y = zeros(n,1);
z = zeros(n,1);
kd = zeros(skoki,1);

for i = 1:skoki
    u(start:n) = du(i);
    for k = start:n
        y(k) = symulacja_obiektu11y(u(k-7),u(k-8),z(k-3),z(k-4),y(k-1),y(k-2));
    end
    Ykonc = y(n);
    if du(i) > 0
        for k = start:n
            if y(k) > 0.9*Ykonc
                kd(i) = k-start;
                break;
            end
        end
    end
end

plot(du(2:end),kd(2:end))
title('Charakterystyka dynamiczna Y')
xlabel('Skok - dU')
ylabel('Iteracja k, gdzie Y(k)-Ypp(k) >= 0.9*(Ykonc(k)-Ypp(k))')

write_to_file('zad2_u_dyn',du(2:end),kd(2:end)')