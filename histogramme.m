function [H] = histogramme(ImgTr,L);   %L=8 : la taille de la fenetre 

[row,col] = size (ImgTr);

bins=2^L;

H=zeros(bins);
for k=0:bins
    for i=1:row
            for j=1:col
                if ImgTr(i,j)==k
                    H(k+1)=H(k+1)+1;
                end
        end
    end
end
H = H(1:end, 1:1);  % selectionner seulement la premiere colonne 

