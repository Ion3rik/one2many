% Sequence Function
% Jon Fagerström
% 16.2.2021
% Arguments:
%           <samples>: samples to be concatenated
%           <num_of_reps>: integer number of repetitions
%           <gap>: gap between repetitions>
function [audio_loop, samples_w] = seq(samples, num_of_reps, gap)
    Ls = length(samples);
    N = size(samples,2);
    if gap <= Ls
        samples = samples(1:gap, :); % cut to length
    else
        samples = [samples; zeros(gap-Ls, N)];
    end
    w = hann(gap*2); % create window
    w = w(gap+1:end);
    samples_w = samples .* w; % window
    audio_loop = 0;
    for i = 1:num_of_reps
        audio_loop = [audio_loop; samples_w(:,i)];
    end
    audio_loop = audio_loop(2:end);
end