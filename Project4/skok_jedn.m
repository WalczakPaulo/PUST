clear
Ypp = 0;
dU = 1;
[y, u] = skok(dU);
s = (y - Ypp)/dU;
s = s(7:end);
save('s.mat', 's')