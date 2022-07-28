function [DeltaMax, yHalf,  DeltaStar, Theta] = fx_BL_WJTBLPropsCalc(WallNormal, Velocity, Perc)
% This function calculates boundary layer properties: thickness, momentum
% thickness, displacement thickness and shape factor
% input: 
%    Perc determines U_peak = Perc*U_infty;
%    Velocity is the BL data in m/s (must be monotonously increasing)
%    WallNormal is the wall distance in meters where Velocity is measured (must be monotonously increasing)
% output:
    % DeltaMax is where max velocity is observed
    % yHalf is where the velocity drops to half of the peak
    % DeltaStar is BL displacement thickness until DeltaMax
    % Theta is BL momentum thickness until DeltaMax
% Everything is in SI metric units (m/s and m)

%% BL PROPS
[~, MaxIdx] = max(Velocity);
DeltaMax = WallNormal(MaxIdx);
U_e = (Perc/100)*max(Velocity);

% U_e = (Perc/100)*U_infty;
try
    yHalf = interp1(Velocity(MaxIdx:end), WallNormal(MaxIdx:end),max(Velocity)/2);
    if isnan(yHalf)
        error()
    end
catch
    yHalf = DeltaMax*2;
    disp('Cannot determine yHalf!')
end

%% Integral quantities: first guess.
idxs = find(WallNormal < DeltaMax);
yTmp = [0, WallNormal(idxs), DeltaMax];
uTmp = [0, Velocity(idxs), U_e];
DeltaStar = trapz(1-fliplr(uTmp)/U_e, fliplr(yTmp));
Theta = trapz((1-fliplr(uTmp)/U_e).*(fliplr(uTmp)/U_e), fliplr(yTmp));

end

