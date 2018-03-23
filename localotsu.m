% Bellani  Daniele 780675
%
% funzione che effettua la binarizzazione con il metodo di otsu localmente
% a e b specificano in quante parti dividere l'immagine rispettivamente
% per righe e per colonne
function out = localotsu(im,a,b)
    if size(im,3) > 1
        im = rgb2gray(im);
    end

    result = zeros(size(im));

    x = floor(size(im,1)/a);
    y = floor(size(im,2)/b);

    xf=x; yf=y; i = 1; j = 1;

    while (xf <= size(im,1))
        while (yf <= size(im,2))
            %disp([i j xf yf]);
            T = graythresh(im(i:xf,j:yf));
            result(i:xf,j:yf) = im2bw(im(i:xf,j:yf),T);
            yf = yf+y;
            j = j+y;
        end
        yf = y;
        j = 1;
        xf = xf+x;
        i = i+x;
    end

    out = result;
end