% Function for computing the variation filtering
% Jon Fagerström
% Updated 28.2.2023

% Inputs:
%       <input>:        signal to be filtered
%       <cutoffs>:      shelf filter cutoff frequencies (Hz)
%       <gains>:        shelf filter gains (dB)
%       <wet>:          wet path gain (lin)
%       <vnParams>:     velvet noise parameters, (num_pulses, length_in_sec, decay_in_dB)
%       <fs>:           sampling frequency
    
% Outputs:
%       <output>:       filtered signal
%       <wetPath>:      wet path signal
%       <vns>:          velvet noise filter

%% V1: DAFx21 - https://www.researchgate.net/publication/354573343_One-to-Many_Conversion_for_Percussive_Samples

function [output, wetPath, vnf] = variationFilter(input, cutoffs, gains, wet, vnParams, fs)
    if numel(cutoffs) == 1
        [b, a] = lowShelf1st(gains(1), cutoffs(1), fs); % low shelf 1st order
        shelf_out = filter(b, a, input); % apply shelf filter
    else
        [b, a] = lowShelf1st(gains(1), cutoffs(1), fs); % low shelf 1st order
        [b2, a2] = highShelf1st(gains(2), cutoffs(2), fs); % high shelf 1st order
        shelf_out = filter(b2, a2, filter(b, a, input)); % apply shelf filter
    end
    
    % GENERATE THE VELVET SEQUENCE
    Ls = round(vnParams(2) * fs); % length in samples
    density = vnParams(1) / vnParams(2);
    decay = vnParams(3);

    vnf = vn(fs, density, Ls, decay);
    % FILTER THE SOURCE SAMPLE 
    wetPath = filter(vnf, 1, shelf_out);
    output = input + wet *wetPath;
end

