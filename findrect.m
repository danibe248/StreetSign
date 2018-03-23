% Bellani Daniele 780675
%
% funzione che soglia l'area delle regioni connesse in un'immagine binaria
function out = findrect(bordo)
    label = bwlabel(bordo);
    [r,c,ch] = size(bordo);
    out = zeros(r,c);
    for i = 1:max(max(label))
        area = sum(sum(label==i));
        if area <= (r*c)/15 & area > 20
            out = out + (label==i);
        end
    end
end