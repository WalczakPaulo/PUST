dU = (-1 : 0.2 : 1)';
yu = zeros(size(dU));

for i = 1:size(dU)
    [y, u] = skok(dU(i));
    yu(i) = y(end);
    csvwrite(sprintf('sprawko/wykresy/zad2_y_%d.csv', i), y)
    csvwrite(sprintf('sprawko/wykresy/zad2_u_%d.csv', i), u)
end
csvwrite('sprawko/wykresy/zad2_yu.csv', yu)
csvwrite('sprawko/wykresy/zad2_du.csv', dU)

% [y, u] = skok(0.1);
% csvwrite('sprawko/wykresy/zad2_y_01.csv', y)
% csvwrite('sprawko/wykresy/zad2_u_01.csv', u)
% 
% [y, u] = skok(0.5);
% csvwrite('sprawko/wykresy/zad2_y_05.csv', y)
% csvwrite('sprawko/wykresy/zad2_u_05.csv', u)
% 
% [y, u] = skok(0.8);
% csvwrite('sprawko/wykresy/zad2_y_08.csv', y)
% csvwrite('sprawko/wykresy/zad2_u_08.csv', u)
% 
% [y, u] = skok(1);
% csvwrite('sprawko/wykresy/zad2_y_1.csv', y)
% csvwrite('sprawko/wykresy/zad2_u_1.csv', u)
% 
% [y, u] = skok(-0.1);
% csvwrite('sprawko/wykresy/zad2_y_minus01.csv', y)
% csvwrite('sprawko/wykresy/zad2_u_minus01.csv', u)
% 
% [y, u] = skok(-0.5);
% csvwrite('sprawko/wykresy/zad2_y_minus05.csv', y)
% csvwrite('sprawko/wykresy/zad2_u_minus05.csv', u)
% 
% [y, u] = skok(-0.8);
% csvwrite('sprawko/wykresy/zad2_y_minus08.csv', y)
% csvwrite('sprawko/wykresy/zad2_u_minus08.csv', u)
% 
% [y, u] = skok(-1);
% csvwrite('sprawko/wykresy/zad2_y_minus1.csv', y)
% csvwrite('sprawko/wykresy/zad2_u_minus1.csv', u)