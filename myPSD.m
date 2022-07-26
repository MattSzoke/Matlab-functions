function [ F, Pxx ] = myPSD(x, Finterest, Fsampling)
% Power Spectral Density
% [ F, Pxx ] = myPSD(x, Finterest, Fsampling)

x = x-mean(x);
% Finterest (Hz), the lowest freq we want to resolve accurately

WindowSize = 4 * Fsampling / Finterest;
NumOfWindows = length(x)/WindowSize;

WindowLength = length(x) / NumOfWindows;
overlap = WindowLength / 2;

[pxx , f] = pwelch(x, WindowLength, overlap, Fsampling/2, Fsampling);

Pxx = pxx;
F = f;

end
