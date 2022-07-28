function [timeStamps, volts] = ReadAVECDats(FileName,Fsampling,NumberOfChannels,BlockSize)
% [timeStamps, volts] = ReadAVECDats(FileName,Fsampling,NumberOfChannels,BlockSize)

% blocksize = 8192;
% Fsampling=192000;
% nch=256;

nblocks = 32*Fsampling/BlockSize;
timeStamps=[0:1/Fsampling:nblocks*BlockSize/Fsampling-1/Fsampling];

fid=fopen(FileName,'r');
volts = fread(   fid,[NumberOfChannels,nblocks*BlockSize], 'float32');
fclose(fid);
    
end