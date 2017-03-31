y1 = zeros(500, 1);
y2 = zeros(500, 1);
y1res = zeros(100, 100);
y2res = zeros(100, 100);

for i = 1:100
   for j = 1:100
      u1 = i*ones(500, 1);
      u2 = j*ones(500, 1);
      y1 = zeros(500, 1);
      y2 = zeros(500, 1);
      for k = 9:500
         y1(k) = symulacja_obiektu5y1(u1(k-7), u1(k-8), u2(k-2), u2(k-3), y1(k-1), y1(k-2));
         y2(k) = symulacja_obiektu5y2(u1(k-3), u1(k-4), u2(k-4), u2(k-5), y2(k-1), y2(k-2));
      end
      y1res(i, j) = y1(500);
      y2res(i, j) = y2(500);
   end
end

subplot(2,1,1);
hold on
plot(y1);
subplot(2,1,2);
hold on
plot(y2);