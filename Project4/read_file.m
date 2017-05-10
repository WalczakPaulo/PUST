function [data] = read_file(name)
f = strcat('./sprawko/wykresy/', name, '.txt');

fileID = fopen(f,'r');
data = fscanf(fileID, '%f %f',[2 Inf]);
data = data(2,:);
fclose(fileID);
end