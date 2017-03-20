clear;

Tp=0.5;
Upp = 0; 
n = 200;
U = zeros(n,1);
Y = zeros(n,1);
Z = zeros(n,1);

for k = 9:n
    Y(k)=symulacja_obiektu11y(U(k-7),U(k-8),Z(k-3),Z(k-4),Y(k-1),Y(k-2));
end

write_to_file('zad1u', 1:length(U), U');
write_to_file('zad1z', 1:length(Z), Z');
write_to_file('zad1y', 1:length(Y), Y');
