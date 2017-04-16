Upp = 0;
Tp = 0.5;
Umin = -1;
Umax = 1;

kstart = 7;

u = Upp*ones(100, 1);
y = zeros(100, 1);
for k = kstart:100
    y(k) = symulacja_obiektu5y(u(k-5), u(k-6), y(k-1), y(k-2));
end

csvwrite('sprawko/wykresy/zad1_u.csv', u)
csvwrite('sprawko/wykresy/zad1_y.csv', y)