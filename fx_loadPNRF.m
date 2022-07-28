function [t,d,Fs,T,N] = fx_loadPNRF(FileName,MyChannels)
% Read Perception's PNRF files into Matlab
% input: 
%  FileName: full path to the file we want to read
%  MyChannels: list of channels  we want to read
% Output
%  t: Timestamps
%  d: data in matix format with size (timestamps,channels)
%  Fs: Sampling frequency
%  T: duration of acquisition (seconds)
%  N: number of timestamps

% Example to read channels 1 through 8 from a file:
% [t,d,Fs,T,N] = fx_loadPNRF('D:\Data\Recording008.pnrf',[1:8]);

%%
FromDisk = actxserver('Perception.Loaders.PNRF');
MyData = FromDisk.LoadRecording(FileName);

% get acquisition properties
ChNum = 1;
ItfData = MyData.Recorders.Item(1).Channels.Item(ChNum).DataSource(1);
T = ItfData.Sweeps.EndTime; % time length of recording
SegmentsOfData = ItfData.Data(0, T);
Fs = 1/SegmentsOfData.Item(1).SampleInterval; % Sampling rate
N = T*Fs;


k = 1;
for ChNum = MyChannels
    ItfData = MyData.Recorders.Item(1).Channels.Item(ChNum).DataSource(1);
    SegmentsOfData = ItfData.Data(0, T);
    WaveformData = SegmentsOfData.Item(1).Waveform(5, 1, N, 1);
    d(k,:) = WaveformData;
    k = k+1;
end

t  = (0:size(d,2))/Fs; % timestamps
d = d';
end

