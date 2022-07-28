function [NumOfChannels,Fsampling,Tsampling,timeStamps,data] = LoadPULSEmat(fileName)
% [NumOfChannels,Fsampling,Tsampling,timeStamps,data] = LoadPULSEmat(fileName)
% Load mat files exported from B&K PULSE
load(fileName)

NumOfChannels = str2num(File_Header.NumberOfChannels);
Fsampling  = str2num(File_Header.SampleFrequency);
if length(Fsampling) > 1
    Fsampling = Fsampling(1);
end
Nsamples = str2num(File_Header.NumberOfSamplesPerChannel);
Tsampling = Nsamples/Fsampling;
timeStamps = [0 : 1/Fsampling : (Nsamples-1)/Fsampling];

for i = 1:NumOfChannels
    eval(sprintf('data(:,%d) = Channel_%d_Data;\n', i, i))
    eval(sprintf('clear Channel_%d_Data;\n',i))
end

end

