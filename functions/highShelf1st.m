% 1st order high shelf
% Jon Fagerström
% 19.3.2021

function [b, a] =  highShelf1st(G_dB, Fc, Fs)
%High Shelf linear gain 
G = 10.^(G_dB/20);          
%High Shelf cut-off frequency [radians]
Wc = 2*pi*Fc /Fs; 

b0 = sqrt(G)*tan(Wc / 2) + G;   %b'0
b1 = sqrt(G)*tan(Wc / 2) - G;   %b'1
a0 = sqrt(G)*tan(Wc / 2) + 1;   %a'0
a1 = sqrt(G)*tan(Wc / 2) - 1;   %a'1

b = [b0 b1];
a = [a0 a1];
end