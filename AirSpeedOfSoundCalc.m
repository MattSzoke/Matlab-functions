function c0=AirSpeedOfSoundCalc(T,TempUnit)
% Determine speed of sound in air
% TempUnit can be 'C', 'F' or 'K'
% c0 is given as m/s

R = 287.05; %specific air constant

switch TempUnit
    case 'C'
        Temp = T+273.15;
    case 'F'
        Temp = (T-32)*(5/9)+273.15;
    case 'K'
        Temp = T; 
    otherwise
        error('I can only deal with Celsius, Fahrenheit or Kelvin');
end

kappa = 1.4;
c0 = sqrt(kappa*R*Temp);

end