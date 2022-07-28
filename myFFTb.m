function [ Frequency, Yfft ] = myFFTb( y, Fsampling, Side)
% FFT transformaTHOR: One and two sided
% derived from myfft, which only does one sided FFT.
% Written by Matt Szoke, m.szoke@vt.edu
% [ Frequency, Yfft ] = myFFTb( y, Fsampling, Side)

y  = y - mean(y);
dT = 1/Fsampling; % time steps
L  = length(y);   % length of the time array
% L = 2^nextpow2(L);
Y = fft(y,L)/L;
f  = linspace(0.0, 1.0/(2.0*dT), L/2); % frequency vector

switch Side % Construct one or two sided results
    
    case 1 % one sided FFT
        Yfft        = 2*abs(Y(1:L/2));
        Frequency   = f ;
        
    case 2 % two sided FFT
        Yfft        = Y;
        Frequency   = [f, -fliplr(f)] ;
        
    otherwise %
        disp([num2str(Side), ' sided FFT transform?'])
        disp ("What's wrong with you!?")
        Frequency = [];
        Yfft      = [];
        
end

end
