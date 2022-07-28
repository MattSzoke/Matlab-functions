function yplusSpalding = SpaldingEqn(uplus,k,B)
% yplusSpalding = SpaldingEqn(uplus,k,B);
% default values: k = 0.41; % B = 5.5;
% uplus = linspace(1,max(Velocity/uTau)*0.9,1000);
if nargin<2
  k = 0.41; 
  B = 5.5;
end

k_uplus = k*uplus ;
yplusSpalding = uplus + exp(-k*B)*( exp(k_uplus)- 1.0 - k_uplus - (k_uplus.^2.)/2.0 - (k_uplus.^3.)/6.0 );

end

