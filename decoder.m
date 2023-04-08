
function [ImgRec] = decoder(ImgTr,L,Q)
[ligne,colone]=size(ImgTr);
ImgTr = double(ImgTr);

for i=1:L:ligne
    for j=1:L:colone
        ImgTr(i:i+L-1,j:j+L-1)=ImgTr(i:i+L-1,j:j+L-1).*Q;   % unquantize 
        ImgRec(i:i+L-1,j:j+L-1) = idct2(ImgTr(i:i+L-1,j:j+L-1)); % inverse DCT 
    end
end
ImgRec = uint8(ImgRec); 




