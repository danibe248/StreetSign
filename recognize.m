% Bellani Daniele 780675
%
% funzione che localizza i cartelli stradali e si occupa di preparare
% l'input per la lettura
function [text,final]=recognize(rgb,gray,hsv,r,g,b,h,s,v)
    [bordo,area] = findBlueEdge(h,s,r,b);

    [H,theta,rho] = hough(bordo);
    H(:,30:150)=0;
    peaks = houghpeaks(H,2,'Threshold',1);
    r1 = abs(rho(1,peaks(1,1)));
    r2 = abs(rho(1,peaks(2,1)));
    if r1>=r2
        rlf = r1;
        rli = r2;
        alfaf = peaks(1,2);
        alfai = peaks(2,2);
    else
        rli = r1;
        rlf = r2;
        alfai = peaks(1,2);
        alfaf = peaks(2,2);
    end
    if (alfaf<90)
        rri = rli+round(864*tand(alfai));
        rrf = rlf+round(864*tand(alfaf));
    else
        rri = rli+round(864*tand(alfai));
        rrf = rlf+round(864*tand(alfaf));
    end
    roi = roipoly(v,[0,864,864,0],round([rli*0.95,rri*0.95,rrf*1.05,rlf*1.05]));
    bordo2 = bordo.*roi;
    
    label = bwlabel(bordo2);
    mask = zeros(size(v));
    for i = 1:max(max(label))
        current = label==i;
        if sum(sum(current)) >= 5
            mask = mask + current;
        end
    end
    bordo2=mask;

    cxh = bwconvhull(bordo2);
    [ci, cf] = verticalbounds(cxh);
    points = [];
    i = 1;
        while roi(i,ci)==0
            i=i+1;
        end
        points = [points,ci,i-1];
        while roi(i,ci)==1
            i=i+1;
        end
        points = [points,ci,i-1];
    i = size(rgb,1);
        while roi(i,cf)==0
            i=i-1;
        end
        points = [points,cf,i-1];
        while roi(i,cf)==1
            i=i-1;
        end
        points = [points,cf,i-1];
    points=[points,points(1,1),points(1,2)];
    final = insertShape(rgb, 'line', points, 'LineWidth', 7, 'Color', [255,0,0]);
    imshow(final)

    cxh = cxh - area;
    if var(var(cxh.*v)) > 0.001
        mask = cxh.*localotsu(gray,5,10);
    else
        mask = cxh.*v;
    end
    
    label = bwlabel(1-im2bw(mask,otsumask(mask)));
    mask = zeros(size(gray));

    for i = 2:max(max(label))
        current = label==i;
        if sum(sum(current)) > 7
            mask = mask + current;
        end
    end
    
    count = 0;
    if alfai > 90
        alfai = 180-alfai;
        count = count+1;
    end
    if alfaf > 90
        alfaf = 180-alfaf;
        count = count+1;
    end
    if count ==2
        sheared=shear(mask,0,degtorad((alfaf+alfai)/2));
    else
        sheared=shear(mask,0,-degtorad((alfaf+alfai)/2));
    end
    [hy text] = linetext(sheared);
end

function [bordo,area] = findBlueEdge(h,s,r,b)
    thresh = medfilt2((h>0.45 & h<0.75)&(s>0.35),[5 5]);
    rb = medfilt2(ratio(r,b));
    final = thresh&rb;
    area = findrect(final);
    bordo=bwmorph(area,'skel',Inf);
end