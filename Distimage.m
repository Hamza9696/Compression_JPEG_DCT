
function [D]=Distimage(Img,Imgrec)
D=sqrt(abs(realpow(double(Img),2)-realpow(double(Imgrec),2)));
