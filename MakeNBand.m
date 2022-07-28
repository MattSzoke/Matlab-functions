function [f_lower, f_middles, f_upper] = MakeNBand(nBand,f_lowest,f_highest)
% [f_lower, f_middles, f_upper] = MakeNBand(nBand,f_lowest,f_highest)

% f_lowest = 100;
% f_highest = 30000;
% nBand = 12;

factor = 2^(1./(2*nBand));
f_middle_0 = 1000;

% Find lower and upper centers
f_middles = f_middle_0;
f_min = f_middle_0;
while f_lowest < f_min
    f_min = f_min./(2^(1./nBand));
    f_middles = [f_min, f_middles];
end

f_max = f_middle_0;
while  f_max < f_highest
    f_max = f_max.*(2^(1./nBand));
    f_middles = [f_middles, f_max];
end

f_lower = f_middles/factor;
f_upper = f_middles*factor;
end

