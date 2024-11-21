% Velve Noise Generator
% Author: Jon Fagerström
% Date: 28.9.2022
%   Inputs:
%       <Fs>:       Sampling rate
%       <density>:  Density (pulses/second)
%       <Ls>:       Sequence length (samples)
%   Outputs:
%       <seq>:      velvet noise sequence
%       <k>:        pulse locations with shape (M,1)
%       <s>:        pulse signs with shape (M,1)


function [seq, k, s] = vn(Fs, density, Ls, decay)
    Td = Fs/density;                        % average spacing between impulses = grid size
    M = round(Ls/Td);                       % Total number of impulses in the sequence
    r1 = rand(M,1);                         % random number sequence
    r2 = rand(M,1);                         % random number sequence
    
    s = 2 * round(r1) - 1;                  % signs
    k = ceil((0:M-1)'.*Td + r2.*(Td-1));    % pulse locations
    k(1) = 1;                               % force first pulse at first sample
    
    alpha = (-log(10.^(-decay/20)))/Ls;     % decay constant
    D = exp(-alpha*k);                      % decay envelope

    seq = zeros(Ls,1);                      % init sequence
    seq(k) = s .* D;                        % generate sequence
   
    if numel(seq)>Ls
        seq = seq(1:Ls)';                   % make sure the sequence length is not exceeded
    end
end
