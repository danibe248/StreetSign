% Bellani Daniele 780675
%
% funzione che scorre verticalmente una maschera binaria per trovare i
% limiti orizzontali della regione
function [ci,cf] = verticalbounds(image)
    [r,c,channel] = size(image);
    found_i = 0; found_f = 0;
    i = 1; j = 1; ci = 0; cf = 0;
    while (j <= c) && (found_i == 0 || found_f == 0)
        while (i <= r) && (found_i == 0 || found_f == 0)
            if not(image(i,j)==0) && found_i == 0
                ci = j;
                found_i = 1;
            end
            if not(image((r+1)-i,(c+1)-j)==0) && found_f == 0
                cf = (c+1)-j;
                found_f = 1;
            end
            i = i + 1;
        end
        i = 1;
        j = j + 1;
    end
end