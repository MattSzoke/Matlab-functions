function [db_humi] = fx_AtmAbsorption(pres,temp,freq_hum,relh)
% Calculate atmospheric absorption
% pres=94344.8; % atmospheric pressure in pascal
% temp = 301.5; % Temperature in Kelvin
% freq_hum=50000; % Frequency, Hz
% relh=40; % Relative Humidity in percen

pow = @(a,b) a.^b;
pres= pres./101325; % convert to relative pressure
C_humid=4.6151-6.8346.*pow((273.15/temp),1.261);
hum=relh.*pow(10,C_humid).*pres;	
tempr=temp./293.15; % convert to relative air temp (re 20 deg C)
frO=pres.*(24+4.04e4.*hum.*(0.02+hum)./(0.391+hum));
frN=pres.*pow(tempr,-0.5).*(9+280.*hum.*exp(-4.17.*(pow(tempr,-1/3)-1)));
alpha=8.686.*freq_hum.*freq_hum.*(1.84e-11.*(1./pres)*sqrt(tempr)+pow(tempr,-2.5)*(0.01275.*(exp(-2239.1/temp).*1./(frO+freq_hum.*freq_hum./frO))+0.1068.*(exp(-3352./temp).*1./(frN+freq_hum.*freq_hum./frN))));
db_humid=100.*alpha;
% if (db_humid<0.0001) db_humid=0; end
db_humid_ft=0.3048.*db_humid;
db_humi=alpha;

db_humi =round(1000*db_humi)/1000; % dB loss per meter

end

