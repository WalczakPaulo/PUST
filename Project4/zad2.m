clear
dU = (-1 : 0.01 : 1)';
dU(ceil(length(dU)/2)) = [];
yu = zeros(size(dU));
kd = zeros(size(dU));
Ypp = 0;

for i = 1:length(dU)
    [y, u] = skok(dU(i));
%     plot(y)
%     hold on
    yu(i) = y(end);
    for k = 7:200
        if abs(y(k) - Ypp) > 0.9 * abs(y(end) - Ypp)
            kd(i) = k - 7;
            break;
        end
    end
%     csvwrite(sprintf('sprawko/wykresy/zad2_y_%d.csv', i), y)
%     csvwrite(sprintf('sprawko/wykresy/zad2_u_%d.csv', i), u)
end
plot(dU,yu)
% write_to_file('zad2_yu', dU', yu')
% write_to_file('zad2_kd', dU', kd')
% csvwrite('sprawko/wykresy/zad2_kd.csv', kd)