clear

kstart = 9;
kk = 350;
u1 = 0*ones(kk, 1);
u2 = 0*ones(kk, 1);
y1 = zeros(kk, 1);
y2 = zeros(kk, 1);

u1(kstart:end) = 1;
for k = kstart:kk
    y1(k) = symulacja_obiektu5y1(u1(k-7), u1(k-8), u2(k-2), u2(k-3), y1(k-1), y1(k-2));
    y2(k) = symulacja_obiektu5y2(u1(k-3), u1(k-4), u2(k-4), u2(k-5), y2(k-1), y2(k-2));
end

s11 = y1(kstart:end);
s12 = y2(kstart:end);
csvwrite('z3_s11.csv', s11);
csvwrite('z3_s12.csv', s12);

u1 = 0*ones(kk, 1);
u2 = 0*ones(kk, 1);
y1 = zeros(kk, 1);
y2 = zeros(kk, 1);

u2(kstart:end) = 1;
for k = 9:kk
   y1(k) = symulacja_obiektu3y1(u1(k-5),u1(k-6),u2(k-2),u2(k-3),y1(k-1),y1(k-2));
   y2(k)=symulacja_obiektu3y2(u1(k-6),u1(k-7),u2(k-4),u2(k-5),y2(k-1),y2(k-2));
end

s21 = y1(kstart:end);
s22 = y2(kstart:end);
csvwrite('z3_s21.csv', s21);
csvwrite('z3_s22.csv', s22);
