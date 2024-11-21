% Looper Function
% Jon Fagerström
% 16.2.2021
% Arguments:
%           <sample>: sample to be looped
%           <num_of_reps>: integer number of repetitions
%           <gap>: gap between repetitions>
function audio_loop = loop(sample, num_of_reps, gap)
    Ls = length(sample);
    if gap <= Ls
        sample = sample(1:gap); % cut to length
    else
        sample = [sample; zeros(gap-Ls, 1)]; % extent to length
    end
    w = hann(gap*2); % create window
    w = w(gap+1:end);
    sample = sample .* w; % window
    audio_loop = 0;
    for i = 1:num_of_reps
        audio_loop = [audio_loop; sample];
    end
    audio_loop = audio_loop(2:end);
end