clc 
clear all 
close all 
I = imread('Cameraman.bmp');
figure(1), imshow(I, [0 255]);
L = 8 ;
Q = [16 11 10 16 24 40 51 61;  % Q standard : qualité 50%
12 12 14 19 26 58 60 55;
14 13 16 24 40 57 69 56;
14 17 22 29 51 87 80 62;
18 22 37 56 68 109 103 77;
24 35 55 64 81 104 113 92;
49 64 78 87 103 121 120 101;
72 92 95 98 112 100 103 99];

 Q = [1 4 16 64 256 1024 4096 16384;    % Q dégradé    2**(2p)  
     4 16 64 256 1024 4096 16384 65536;
     16 64 256 1024 4096 16384 65536 262144;
     64 256 1024 4096 16384 65536 262144 1048576;    
     256 1024 4096 16384 65536 262144 1048576 4194304;
     1024 4096 16384 65536 262144 1048576 4194304 16777216;  
     4096 16384 65536 262144 1048576 4194304 16777216 67108864;
     16384 65536 262144 1048576 4194304 16777216 67108864 268435456];
 
% q = q_avg(Q);                       % q le pas moyenne 
% Q= q*ones(L,L);               % Q moyenne


%%%%%%%%%%%%%%%%%%% CODAGE (DCT , ZIGZAG , RLC , HUFFMAN  %%%%%%%%%%%%%%%%%%%%%%%%%

%%
[ImgTr] = coder(I,L,Q);                  %DCT et Quantization
figure(2), imshow(ImgTr, [0 255]); 
[ligne,colone]=size(ImgTr);
table_dict = cell(32);
table_enco = cell(32);
[ImgTr] = coder(I,L,Q);                  %DCT et Quantization
count1 = 0;
count2 = 0;
for i=1:L:ligne    % balayage de haut en bas 
    count1 = count1 + 1;
    count2 = 1;
    for j=1:L:colone   % balayage de gauche à droite 
        Im_dctq = ImgTr(i:i+L-1,j:j+L-1);
        R = Im_dctq(zigzag(L)); %Zigzag
        Re = rle(R); %RLC
        temp=1;
        temp2=0;
        [row, col] = size(Re);
        pixel_count = row*col;
%         symbol = reshape(Re,[1,row*col]);  %redimensionnement "optionel dans de cas" 
        symbol1 = unique(Re);   %sans repetition et en ordre 
        len = length(symbol1);   %combien de symboles
        count = ones(1,len);
        prob_pix = ones(1,len);
        for p = 1:len
            k = Re == symbol1(p);   % 1 si contient le symbole correspondant à l'indince "p"
            count(temp) = sum(k(:)); % compter combine de symbole 
            prob_pix(temp) = double(count(temp)/pixel_count); % la probabilité du symbole 
            temp2 = temp2 + prob_pix(p);
            temp = temp+1;
        end
            [dict,avg_len] = huffmandict(symbol1,prob_pix);
            comp = huffmanenco(Re,dict);   %Codage Huffman         
            table_enco{count1,count2} = comp;
            table_dict{count1,count2} = dict;
            count2 = count2 + 1;
            if count2 > 32    %%%%%  !!! 32  !!!  %%%%%
                count2 = 1;
            end
    end
end


