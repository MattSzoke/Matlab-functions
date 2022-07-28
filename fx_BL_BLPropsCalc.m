function [Delta, DeltaStar, Theta, H] = fx_BL_BLPropsCalc(WallNormal, Velocity, U_infty, Perc)
% This function calculates boundary layer properties: thickness, momentum
% thickness, displacement thickness and shape factor
% input: 
%    U_infty is the actual freestream velocity.
%    Perc determines U_edge = (Perc/100)*U_infty;
%    Velocity is the BL data in m/s (must be monotonously increasing)
%    WallNormal is the wall distance in meters where Velocity is measured (must be monotonously increasing)
% output:
    % Delta is BL thickness
    % DeltaStar is BL displacement thickness
    % Theta is BL momentum thickness
    % H is BL shape factor
% Everything is in SI metric units (m/s and m)

%% BL PROPS
%U_infty = max(Velocity);
U_e = (Perc/100)*U_infty;
try
    [Vel,idxs] = unique(Velocity,'stable');
    Delta = interp1(Vel,WallNormal(idxs),U_e);
catch
    error('BEE BOO BEE BOO WRONG DELTA!')
end

%% Integral quantities: first guess.
idxs = find(WallNormal < Delta);
yTmp = [0, WallNormal(idxs), Delta];
uTmp = [0, Velocity(idxs), U_e];
DeltaStar = trapz(1-fliplr(uTmp)/U_e, fliplr(yTmp));
Theta = trapz((1-fliplr(uTmp)/U_e).*(fliplr(uTmp)/U_e), fliplr(yTmp));
H = DeltaStar/Theta;

end

