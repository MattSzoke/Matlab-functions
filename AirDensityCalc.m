function rho=AirDensityCalc(Patm,PatmUnit,T,TempUnit)
% Air Density Calculation
% rho=AirDensity(Patm,PatmUnit,T,TempUnit)
% PatmUnit = 'Pa' or 'inHg'
% TempUnit = 'C', 'F' or 'K'
% rho is given in kg/m3

R = 287.05; %specific air constant

switch PatmUnit
    case'Pa'
        p0 = Patm;
    case 'inHg'
        p0 = Patm*3.38639e3;
    otherwise
        error('I can only deal with Pa or inHg');
end


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

rho = p0./(R.*Temp);

end