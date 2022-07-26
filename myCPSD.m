function [ F , Pxy ] = myCPSD(x, y, Finterest, Fsampling)
% Cross Power Spectral Density
%  [ F , Pxy ] = myCPSD(x, y, Finterest, Fsampling)
% 

% Finterest = 100; % [Hz], the lowest freq we want to resolve accurately

x = x - mean(x);
y = y - mean(y);

WindowSize = 4 * Fsampling / Finterest;
NumOfWindows = length(x)/WindowSize;

WindowLength = length(x) / NumOfWindows;
overlap = WindowLength / 2;

%[pxx , f] = pwelch(x, WindowLength, overlap, Fsampling/2, Fsampling);
[pxy,  f] = cpsd  (x,y,WindowLength,overlap, Fsampling/2, Fsampling);
Pxy = pxy;
F = f;

end
