function [W,gamma]= iniW(U, k)
%% construct anchor graph Z
% Input:
%       X: data matrix, d by n
%       anchor: anchor matrix, d by m
%       k: Number of neighbors
%%

if nargin < 2
    k = 5;
end

m = size(U,2);
distU = L2_distance_1(U, U);
[distU1, idx] = sort(distU, 2);
% init S
W = zeros(m);
GAMMA = 0;
for i = 1:m
    di = distU1(i,2:k+2); %Exclude itself
    GAMMA = GAMMA + 0.5*(k*di(k+1)-sum(di(1:k)));
    id = idx(i,2:k+2);
    W(i,id) = (di(k+1)-di)/(k*di(k+1)-sum(di(1:k))+eps);
end
gamma = GAMMA/m;

end