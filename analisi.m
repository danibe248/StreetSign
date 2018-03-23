% Bellani Daniele 780675
%
% script usato per l'analisi dei risultati
edit = [];
edit_n = [];
charac = 0;
for i = 1:52
    if i < 10
        s = strcat('Dataset/000',int2str(i))
    else
        s = strcat('Dataset/00',int2str(i))
    end
    sj = strcat(s,'.jpg');
    [text,~]=street(sj);
    gtext = strcat(fscanf(fopen(strcat(s,'.txt')),'%c'))
    [e,lcs] = EditDistance(text,gtext);
    edit = [edit,e];
    edit_n = [edit_n,e/length(gtext)];
    charac = charac + length(gtext);
end
zero=sum(edit==0);
uno=sum(edit==1);
more=sum(edit>1);
success = zero*100/i;
uno_rate = uno*100/i;
more_rate = more*100/i;
edit_n = edit_n*100;