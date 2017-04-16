clear
dU = (-1 : 0.2 : 1)';
dU(ceil(length(dU)/2)) = [];
yu = zeros(size(dU));
Ypp = 0;

for i = 1:length(dU)
    [y, u] = skok(dU(i));
    plot(y)
    hold on
    yu(i) = y(end);
    for k = 7:100
        if abs(y(k) - Ypp) > 0.9 * abs(y(end) - Ypp)
            kd(i) = k - 7;
            break;
        end
    end
    csvwrite(sprintf('sprawko/wykresy/zad2_y_%d.csv', i), y)
    csvwrite(sprintf('sprawko/wykresy/zad2_u_%d.csv', i), u)
end
csvwrite('sprawko/wykresy/zad2_yu.csv', yu)
csvwrite('sprawko/wykresy/zad2_du.csv', dU)
csvwrite('sprawko/wykresy/zad2_kd.csv', kd)