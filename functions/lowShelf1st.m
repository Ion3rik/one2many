% 1st order lowshelf
% Jon Fagerström
% 18.3.2021

function [b, a] =  lowShelf1st(G_dB, Fc, Fs)
%Low Shelf linear gain 
G = 10.^(G_dB/20);          
%Low Shelf cut-off frequency [radians]
Wc = 2*pi*Fc /Fs; 

b0 = G*tan(Wc / 2) + sqrt(G);   %b'0
b1 = G*tan(Wc / 2) - sqrt(G);   %b'1
a0 = tan(Wc / 2) + sqrt(G);        %a'0   
a1 = tan(Wc / 2) - sqrt(G);        %a'1

b = [b0 b1];
a = [a0 a1];
end