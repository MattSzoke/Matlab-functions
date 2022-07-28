function [F,Y] = myWindowedFFT(x,Fsampling,nSide,nWindows)
% [F,Y] = myWindowedFFT(x,Fsampling,nSide,nWindows)
Ysum.real = 0;
Ysum.imag = 0;

L = length(x);
WindowSize = L/nWindows;

for n = 1:nWindows
    xx = x( (n-1)*WindowSize+1 : n*WindowSize);
    [F,Ywin] = myFFTb(xx,Fsampling,nSide);
    Ysum.real = Ysum.real + real(Ywin);
    Ysum.imag = Ysum.imag + imag(Ywin);
end

Yreal = Ysum.real ./ nWindows;

if nSide == 2
    Yimag = Ysum.imag ./ nWindows;
    Y = Yreal + 1i*Yimag;
else
    Y = Yreal;
end

end

