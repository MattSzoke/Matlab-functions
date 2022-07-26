function [F, GammaSquare] = myCoherence(x, y, Finterest, Fsampling)
% Magnitude Squared Coherence, written by Matt Szoke
% [F, GammaSquare] = myCoherence(x, y, Finterest, Fsampling)
% Finterest is the lowest freq we want to resolve "accurately"
% by choosing the window size to contain 4 wavelengths of this frequency
% also, Finterest is equal to the frequency resolution.

x = x - mean(x); % remove mean value
y = y - mean(y);

WindowSize = 4 * Fsampling / Finterest; % take window size accordingly
NumOfWindows = length(x)/WindowSize; % how many windows we can do

WindowLength = length(x) / NumOfWindows; % recalculate this just to be on the safe side.
overlap = WindowLength / 2; % we take 50% overlap

% coherence estimation
[Cxy,f] = mscohere(x,y,WindowLength, overlap, Fsampling/2, Fsampling);

% Results.
GammaSquare = Cxy;
F = f;

end
