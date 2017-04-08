u1 = 0*ones(500, 1);
u2 = 0*ones(500, 1);
y1 = zeros(500, 1);
y2 = zeros(500, 1);


u1(9:end) = 1;
for k = 9:500
   y1(k) = symulacja_obiektu5y1(u1(k-7), u1(k-8), u2(k-2), u2(k-3), y1(k-1), y1(k-2));
	y2(k) = symulacja_obiektu5y2(u1(k-3), u1(k-4), u2(k-4), u2(k-5), y2(k-1), y2(k-2));
end

csvwrite('z3_y1_u1.csv', y1);
csvwrite('z3_y2_u1.csv', y2);

u1 = 0*ones(500, 1);
u2 = 0*ones(500, 1);
y1 = zeros(500, 1);
y2 = zeros(500, 1);

u2(9:end) = 1;
for k = 9:500
   y1(k) = symulacja_obiektu5y1(u1(k-7), u1(k-8), u2(k-2), u2(k-3), y1(k-1), y1(k-2));
	y2(k) = symulacja_obiektu5y2(u1(k-3), u1(k-4), u2(k-4), u2(k-5), y2(k-1), y2(k-2));
end

csvwrite('z3_y1_u2.csv', y1);
csvwrite('z3_y2_u2.csv', y2);
