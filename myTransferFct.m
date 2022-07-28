function [ F, Txy ] = myTransferFct(x, y, Finterest, Fsampling)
% transfer function estimate
%  [ F , Pxy ] = myTransferFct(x, y, Finterest, Fsampling)
% 

% Finterest = 100; % [Hz], the lowest freq we want to resolve accurately

x = x - mean(x);
y = y - mean(y);

WindowSize = 4 * Fsampling / Finterest;
NumOfWindows = length(x)/WindowSize;

WindowLength = length(x) / NumOfWindows;
overlap = WindowLength / 2;

[Txy,  F] = tfestimate  (x,y,WindowLength,overlap, Fsampling/2, Fsampling);

end
