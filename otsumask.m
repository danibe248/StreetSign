% Bellani Daniele 780675
%
% funzione che soglia un'immagine a cui è stata applicata una maschera binaria
% secondo il metodo di otsu
function mm = otsumask(mask)
    collect = [];
    [r,c,ch] = size(mask);
    
    for i = 1:r
        for j = 1:c
            if not(mask(i,j)==0)
                collect = [collect,mask(i,j)];
            end
        end
    end
    mm = graythresh(collect);
end