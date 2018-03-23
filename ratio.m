% Bellani Daniele 780675
%
% funzione che esamina i livelli di blu e rosso in un'immagine rgb e
% ritorna una maschera con i pixel che soddisfano un erto criterio
function out = ratio(r,b)
    [row,col,ch] = size(r);
    out = zeros(row,col,ch);
    for i = 1:row
        for j = 1:col
            if (b(i,j)/r(i,j))>2 
                out(i,j) = 1;
            end
        end
    end    
end