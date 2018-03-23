% Bellani Daniele 780675
%
% funzione che passa dei caratteri a un ocr per la lettura, gestendo 
% i casi in cui vengano passate 1, 2, 3 o più righe di testo
function [hy out] = linetext(im)
    hy = sum(im'); 
    hy = hy>6;
    points = [];
    numpeaks = numel(findpeaks(double(hy)));
  %  disp(numpeaks)
    if numpeaks > 3
        out = ocrLine(im);
    end
    if numpeaks==3
        i = 1;
        while hy(1,i)==0
            i=i+1;
        end
        while hy(1,i)>0
            i=i+1;
        end
        label = bwlabel(im(1:i,:));
        if max(max(label))<=1
            i = size(hy,2);
            out = read(im,i,hy,points);
        else
            i = size(hy,2);
            while hy(1,i)==0
                i=i-1;
            end
            while hy(1,i)>0
                i=i-1;
            end
            out = read(im,i,hy,points);
        end
    end
    if numpeaks==2
        out = read(im,size(hy,2),hy,points);
    end
    if numpeaks==1
        count = 0;
        im2 = im;
        while numpeaks == 1 & count < 1
            im2 = imerode(im2,strel('square',3));
            hy = sum(im2');
            hy = hy>0;
            numpeaks = numel(findpeaks(double(hy)));
            count = count + 1;
        end
        if count < 1 & numpeaks == 2
            out = read(im2,size(hy,2),hy,points);
        else
            out = ocrLine(im);
        end
    end
end

function out = read(im,i,hy,points)
%     i = size(hy,2);
        while hy(1,i)==0
            i=i-1;
        end
        points = [points,i];
        while hy(1,i)>0
            i=i-1;
        end
        points = [points,i+1];
        while hy(1,i)==0
            i=i-1;
        end
        points = [points,i];
        points = [points,1];
        mask1 = zeros(size(im));
        mask2 = zeros(size(im));
        mask1(points(1,4):points(1,3),:) = 1;
        mask2(points(1,2):points(1,1),:) = 1;
        line1 = im.*mask1;
        %subplot(1,2,1),imshow(line1)
        line2 = im.*mask2;
        %subplot(1,2,2),imshow(line2)
        txt1 = ocr(line1,'TextLayout','Block','CharacterSet','VviIapzcors');
        box = cell2mat(struct2cell(regionprops(line2,'BoundingBox')));
        charset = '.abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
        txt2 = ocr(line2,box,'TextLayout','Block','CharacterSet',charset);
        out = cell2mat(strtrim(upper(strcat(txt1.Text,{' '},txt2.Text))));
end

function out = ocrLine(im)
    box = cell2mat(struct2cell(regionprops(im,'BoundingBox')));
    charset = '.abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
    txt = ocr(im,box,'TextLayout','Block','CharacterSet',charset);
    out = strtrim(upper(txt.Text));
end