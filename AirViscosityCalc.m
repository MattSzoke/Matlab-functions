function Mu = AirViscosityCalc(T,TempUnit)
% Air Viscosity Calculation
% Mu=AirViscosityCalc(T,TempUnit)
% TempUnit = 'C', 'F' or 'K'
% Mu is given in kg / (m * s)

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

Mu = 1.4578*(10^-6)*(Temp^1.5) ./ (Temp+110.4) ;

end
