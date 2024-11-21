% Example in generating One2Many variations
% Jon Fagerström
% Updated: 21.11.2024

clear; close all; clf;

%% Load sample
[sample, fs] = audioread('knock1.wav');
L = length(sample); % length of the audio
%% PARAMS
N = 10; % number of repetitions
gap = 0.3; gap = min(length(sample), gap * fs); % gap between sounds in the sequence

cutoffs = [100 5000]; % shelf filter cutoffs in Hz (low-shelf, high-shelf)
gains = [-20 -5]; % shelf filter gains in dB (low-shelf, high-shelf)
wetGain = 0.5; % linear wet path gain of the one2many filter structure
vnParams = [8, 0.004, 20]; % velvet noise params (numPulses, length_in_seconds, decay_in_dB)

%% VARIATION FILTERING

samples = zeros(L,N);
for i = 1:N
    [samples(:,i)] = variationFilter(sample, cutoffs, gains,  wetGain, vnParams, fs); 
end

%% Create loops
% create loops
loop_repetitive = loop(sample, N, gap);
loop_one2many = seq(samples, N, gap);

%% Plots
line_width2 = 2;
% IR
y_lim = 0.5;
figure;
subplot(2,1,1)
plot(loop_repetitive)
ylim([-y_lim y_lim])
title('Repetitive')

subplot(2,1,2)
plot(loop_one2many)
ylim([-y_lim y_lim])
title('One 2 Many')
