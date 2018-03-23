% Bellani Daniele 780675
%
% funzione principale
function [text,image]=street(photo)
    [rgb,gray,hsv,r,g,b,h,s,v] = load_image(photo);
    try 
        [text,image]=recognize(rgb,gray,hsv,r,g,b,h,s,v);
    catch
        disp('lettura non riuscita')
        text = '';
        image = zeros(size(rgb));
    end
    disp(text)
end