
function [ImgTr] = coder(Img,L,Q)
[ligne,colone]=size(Img);

for i=1:L:ligne
    for j=1:L:colone
        ImgTr(i:i+L-1,j:j+L-1) = dct2(Img(i:i+L-1,j:j+L-1));  % DCT Matrix before quantization  lossless !
        ImgTr(i:i+L-1,j:j+L-1)=ImgTr(i:i+L-1,j:j+L-1)./Q;   % quantize   lossy !             %Zigzag
    end
end
ImgTr = int16(ImgTr); %Arrondissement




