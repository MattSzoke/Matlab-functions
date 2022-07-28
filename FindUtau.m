function [uTau,yOffset] = FindUtau(YPositions, Velocity, U_infinity, yPlusMin, yPlusMax, Nu,uTauArray,yOffsetArray, k, B)
% Ustar = 2.0; % This is an initial guess
% uTauArray = linspace(0.5,3.50,3001);
% yOffsetArray = yOffset; % linspace(0.6,2.1,20);
% yPlusMin = 200.0;
% yPlusMax = 500.0;

%%
Diff = (10^6)*ones([length(uTauArray), length(yOffsetArray) ]);
%Diff = [];
for i = 1:length(uTauArray)
    for j = 1:length(yOffsetArray)
        Utau = uTauArray(i);
        yOffset = yOffsetArray(j);
        Diff(i,j) = MyUtauError (Utau,YPositions,yOffset,Nu,Velocity, U_infinity, yPlusMin, yPlusMax, k, B);
        %[ Diff(i,j), i ,j];
        % fprintf('Utau = %3.2e && yOffset = %3.2f && Error = %3.2e\n', Utau, yOffset ,Diff(i,j))
    end
end

MinErr = min(min(Diff));
[uTauArrayIDX, yOffsetArrayIDX] = find(MinErr == Diff);

Ustar = uTauArray(uTauArrayIDX);
yOffset = yOffsetArray(yOffsetArrayIDX);

if length(Ustar) > 1
    Ustar = mean(Ustar);
end

if length(yOffset) > 1
    yOffset = mean(yOffset);
end

uTau = Ustar;

end

%%
function Diff = MyUtauError (Utau,invPosY,yOffset,Nu,invMeanVelocity,U_infinity, yPlusMin, yPlusMax, k, B)

uplus = invMeanVelocity/Utau;
yplusMeasured = (invPosY+yOffset)*Utau/Nu;
a = yplusMeasured > yPlusMin;
b = yPlusMax > yplusMeasured;
indices = a & b   ;

if ~any(indices)
    yplusMeasured = yplusMeasured ;
    uplus = uplus;
    %disp('oh no')
else
    yplusMeasured = yplusMeasured ( indices );
    uplus = uplus ( indices );
end
% k = 0.41;
% B = 5.5;
k_uplus = k*uplus ;
yplusSpalding = uplus + exp(-k*B)*( exp(k_uplus)- 1.0 - k_uplus - (k_uplus.^2.)/2.0 - (k_uplus.^3.)/6.0 );

% Log layer
% LogLayerAnalitical = (1.0/0.41)*np.log(yplusMeasured)+5.0
% yplusSpalding = LogLayerAnalitical
% Diff =  np.abs( np.trapz(uplus,x = yplusSpalding) - np.trapz(uplus,x = yplusMeasured)) / float(len(yplusMeasured))
Diff =  sum( abs(yplusSpalding - yplusMeasured) ) / length(yplusMeasured);

if isnan(Diff)
    Diff = 10^10;
    %     disp('NaN')
end

if isinf(Diff)
    Diff = 10^10;
    %     disp('inf')
end

end

%%
function Diff = MyUtauError_OLD(Utau,invPosY,yOffset,Nu,invMeanVelocity,U_infinity, yPlusMin, yPlusMax)

uplus = invMeanVelocity/Utau;
yplusMeasured = (invPosY+yOffset)*Utau/Nu;
a = yplusMeasured > yPlusMin;
b = yPlusMax > yplusMeasured;
indices = a & b   ; 

if ~any(indices)
    yplusMeasured = yplusMeasured ;
    uplus = uplus;
    %disp('oh no')
else
    yplusMeasured = yplusMeasured ( indices );
    uplus = uplus ( indices );
end

k = 0.41;
B = 5.5;
k_uplus = k*uplus ;
yplusSpalding = uplus + exp(-k*B)*( exp(k_uplus)- 1.0 - k_uplus - (k_uplus.^2.)/2.0 - (k_uplus.^3.)/6.0 );

% Log layer
% LogLayerAnalitical = (1.0/0.41)*np.log(yplusMeasured)+5.0
% yplusSpalding = LogLayerAnalitical
% Diff =  np.abs( np.trapz(uplus,x = yplusSpalding) - np.trapz(uplus,x = yplusMeasured)) / float(len(yplusMeasured))
Diff =  sum( abs(yplusSpalding - yplusMeasured) ) / length(yplusMeasured);

if isnan(Diff)
    Diff = 10^10;
    %disp('NaN')
end

if isinf(Diff)
    Diff = 10^10;
    %disp('inf')
end 

end