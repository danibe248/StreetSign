% Bellani Daniele 780675
%
% funzione che effettua lo shear dell'immagine con i caratteri da leggere
function out = shear(im,x,y)
    shear_xy = eye(3,3);
    shear_xy(2,1) = x;
    shear_xy(1,2) = y;
    tform = affine2d(shear_xy);
    out = imwarp(im,tform);
end