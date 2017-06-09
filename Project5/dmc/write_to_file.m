function [] = write_to_file(filename, A, B)
    f = strcat('../sprawko/wykresy/', filename, '.txt');
    fileID = fopen(f, 'w');
    fprintf(fileID, '%1.4f %1.4f\n', [A;B]);
    fclose(fileID);
end