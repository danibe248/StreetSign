% Bellani Daniele 780675
%
% funzione per il caricamento dell'immagine e la suddivisione dei canali
% necessari
function [rgb,gray,hsv,r,g,b,h,s,v] = load_image(image)
    rgb = imread(image);
    rgb = imresize(rgb,[648 864]);
    rgb = im2double(rgb);
    gray = rgb2gray(rgb);
    hsv = rgb2hsv(rgb);
    r = rgb(:,:,1);
    g = rgb(:,:,2);
    b = rgb(:,:,3);
    h = hsv(:,:,1);
    s = hsv(:,:,2);
    v = hsv(:,:,3);
end
