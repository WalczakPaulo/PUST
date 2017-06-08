function [  ] = generateInit( zmienna, wartosci )
%GENERATEINIT Summary of this function goes here
%   Detailed explanation goes here
for i = 0:length(wartosci)-1
    fprintf("%s[%d] := %f;\n", zmienna, i, wartosci(i+1));
end

end

