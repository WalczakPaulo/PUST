clear

%inicjalizacja stałych i wektorów
kk = 200;
k0 = 9;
[dU,dZ] = meshgrid(-1:0.1:1);
size = length(dZ);
y = zeros(size,size);
U = zeros(1,kk);
Z = zeros(1,kk);

%symulacja obiektu dla kolejnych skoków sterowania i zakłócenia
for i = 1:size
    for j = 1:size
        Y = zeros(1,kk);
        U(k0:kk) = dU(i,j);
        Z(k0:kk) = dZ(i,j);
        for k = k0:kk
            Y(k) = symulacja_obiektu11y(U(k-7),U(k-8),Z(k-3),Z(k-4),Y(k-1),Y(k-2));
        end
        y(i,j) = Y(kk);
    end
end
%wyświetlenie i zapis wykresu do txt
mesh(dU,dZ,y);

dU = reshape(dU,[],1);
dZ = reshape(dZ,[],1);
y = reshape(y,[],1);

fileID = fopen('./sprawozdanie/wykresy/zad2_y_uz.txt', 'w');
fprintf(fileID, '%1.4f %1.4f %1.4f\n', [dU';dZ';y']);
fclose(fileID);

        

