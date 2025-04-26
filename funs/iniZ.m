function Z = iniZ(X, A, k)
%% construct anchor graph Z
% Input:
%       X: data matrix, d by n
%       anchor: anchor matrix, d by m
%       k: Number of neighbors
%%

if nargin < 3
    k = 5;
end

[~, num] = size(X);
[~,numAnchor] = size(A);

distX = L2_distance_1(X, A);
[~, idx] = sort(distX, 2);

Z = zeros(num, numAnchor);
for i = 1:num
    id = idx(i,1:k +1);
    di = distX(i,id);
    Z(i,id) = (di(k+1)-di)/(k*di(k+1)-sum(di(1:k))+eps);
end

end