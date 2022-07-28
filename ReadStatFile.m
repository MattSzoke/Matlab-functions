function [PortNum, xLoc, yLoc, zLoc, Uref, Temp, Cp, Press, Prms, Patm] = ...
    ReadStatFile(MyStatFile, chord, MeasurementNumber)
% [PortNum xLoc yLoc zLoc Uref Temp Cp Press Prms Patm] =  ReadStatFile(MyStatFile, chord, MeasurementNumber)
% MyStatFile = 'RunNN.stat';
% chord = 1; [in]
% MeasurementNumber = 1

fid=fopen(MyStatFile); 
% disp(['Reading file : ', MyStatFile])

meas=1;
while ~feof(fid)
    com = fgetl(fid);
    p_start = strfind(com,', Patm=')+7;
    p_finish = strfind(com,' in. Hg,')-1;
    patm(meas)=str2double(com(p_start:p_finish))*3.38639e3; % PASCAL, bro
    fgetl(fid);
    fgetl(fid);
    a=fscanf(fid,'%f');

a=reshape(a,[10 length(a)/10]);

pn(meas,:)=a(1,:);
x(meas,:)=a(2,:)*chord*25.4/1000;
y(meas,:)=a(3,:)*chord*25.4/1000;
z(meas,:)=a(4,:)*chord*25.4/1000;
uref(meas,:)=a(5,:);
re(meas,:)=a(6,:);
tf(meas,:)=a(7,:);
cp(meas,:)=a(8,:);
p(meas,:)=a(9,:);
prms(meas,:)=a(10,:);

meas=meas+1;
end
fclose(fid);
meas=meas-1;

% fprintf('You have %d measurements to choose from, bro!\n', meas)
% for i =1:(meas)
%     fprintf('Meas# %02d ::: %3.1f m/s\n' , i, round(mean(uref(i,:)),0))
% end

%% Digest data

if MeasurementNumber > 0 && MeasurementNumber <= meas  
    PortNum = pn(MeasurementNumber,:);
    xLoc  = x(MeasurementNumber,:);%*chord*25.4/1000;
    yLoc  = y(MeasurementNumber,:);%*chord*25.4/1000;
    zLoc  = z(MeasurementNumber,:);%*chord*25.4/1000;
    Uref  = mean(uref(MeasurementNumber,:));
    Temp  = mean(tf(MeasurementNumber,:));
    Cp    = cp(MeasurementNumber,:);
    Press = p(MeasurementNumber,:)*249.0889;
    Prms  = prms(MeasurementNumber,:)*249.0889;
    Patm  = patm(MeasurementNumber);
else
    PortNum = mean(pn(:,:),1);
    xLoc  = x(:,:);
    yLoc  = y(:,:);
    zLoc  = z(:,:);
    Uref  = uref(:,:);
    Temp  = tf(:,:);
    Cp    = cp(:,:);
    Press = p(:,:)*249.0889;
    Prms  = prms(:,:)*249.0889;
    Patm  = patm;
end

