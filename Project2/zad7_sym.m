clear
close all
i = 1;
for zakres_szumu = [0.1 0.3 0.7 1]
    E(i) = zad7(40,100,20,5,0.5,0,0,zakres_szumu);
    i = i+1;
end