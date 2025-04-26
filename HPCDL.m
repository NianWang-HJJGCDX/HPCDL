function pixel_label = HPCDL(X, A, m, c, r,  k, alpha, Iter )
%% 
% Input: 
%       X: data matrix, d by n, each column is a pixel(sample).
%       A: anchor matrix
%       m: anchor number (superpixel number).
%       c: cluster number.
%       r: reduced spectral dimension (after projection).
% Output:
%       pixel_label:the labels of pixels
%       Z: anchor graph, n by m
%       W: anchor-anchor graph, m by m.
%       P: projection matrix.
%       clusternum: the number of connected components of 'W', i.e., the number of clusters.

%% iter...
% init Z
Z = iniZ(X, A, k); 
for iter = 1:Iter
    % update P
    P = updateP(X, A, Z,r);
    % update U
    U = P'*A;
    % update Z
    Z = updateZ(P'*X, U, k);
    % update W
    [W,beta] = iniW(U, k);
    eta = beta;
    W = updateW(U,W,beta, eta,c,k);
    Dw = diag(sum(W)); % degree matrix
    Lw = Dw - W; % Laplace matrix
    % update A
    A = (X*Z)*inv(diag(sum(Z))+2*alpha*Lw);
end

%%
% For older versions of MATLAB
% [clusternum, U_label] = graphconncomp(sparse(S));

% For newer versions of MATLAB 
[anchor_label] = conncomp(graph(sparse(W)));
clusternum = length(unique(anchor_label));

%%
[~, subLabel] = max(Z, [], 2);
pixel_label = anchor_label(subLabel); pixel_label = pixel_label';
end