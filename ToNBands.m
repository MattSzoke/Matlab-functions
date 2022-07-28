function  [F_centre, Freq_Data_out] = ToNBands(Freq_in, Freq_Data, F_lower, F_upper, F_centre)
%  [F_centre, Freq_Data_out] = ToNBands(Freq_in, Freq_Data, F_lower, F_upper, F_centre)
% Interpolate data to limits
Freq_Data_lower = interp1(Freq_in,Freq_Data,F_lower);
Freq_Data_upper = interp1(Freq_in,Freq_Data,F_upper);

if int32(Freq_in(1)) == 0 % get rid of the 0 Hz information
    Freq_in = Freq_in(2:end);
    Freq_Data = Freq_Data(2:end);
end

Freq_Data_out = zeros(length(F_centre),1);

for i = 1:length(F_centre)
    idx0 = find(F_lower(i) < Freq_in);
    idx1 = find(Freq_in < F_upper(i));
    idx0 = int32(idx0(1));
    idx1 = int32(idx1(end));
    y = [Freq_Data_lower(i),Freq_Data(idx0:idx1)];
    y = [y,Freq_Data_upper(i)];
    x = [F_lower(i),Freq_in(idx0:idx1)];
    x = [x, F_upper(i)];
    Freq_Data_out(i) = trapz(x, y) ./ (F_upper(i) - F_lower(i));

%     figure(99), hold on
%     semilogx(Freq_in, Freq_Data,'-k')
%     semilogx(Freq_in(idx0:idx1), Freq_Data(idx0:idx1),'yo')
%     semilogx(F_lower, Freq_Data_lower,'bs')
%     semilogx(F_upper, Freq_Data_upper,'rs')
%     set(gca,'xscale','log')
%     pause(0.1)
end

% plot(F_centre,Freq_Data_out,'-m')
end

