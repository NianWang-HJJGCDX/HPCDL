%% min_{W>=0,W1=1,W=W'}sum_{i,j=1}^n||x_i-x_j||_2^2w_{ij}+gamma||W||_F^2+2*lambda*trace(F'*L(W)*F)
function  W = DSCAN(X,W,gamma,lambda,c,k)

NITER = 300;
num = size(X,2);
W = (W+W')/2;
D = diag(sum(W));
L0 = D - W;
[F, temp, evs]=eig1(L0, c, 0);

if sum(evs(1:c+1)) < 0.00000000001
    error('The original graph has more than %d connected component', c);
end;
rho = 1.1;
mu = 1;
zeta = zeros(num);
distX = L2_distance_1(X,X);
[~, idx] = sort(distX,2);
index = zeros(num);
for i=1:num
    idxa0 = idx(i,2:k+1);
    index(i,idxa0)= 1;
end;

[~, idx2] = sort(index,1);
for iter = 1:NITER
    % update F
    distF = L2_distance_1(F',F');
    Z = mu*W'-1/2*zeta+1/2*zeta'-1/2*distX-1/2*lambda*distF;
    % update W
    TempW = zeros(num);
    for i=1:num
        c_vec = index(:,i);
        m = find(c_vec==1);
        aa = idx(i,2:k+1);
        cc=setdiff(m,aa)';
        idxa0= [cc,aa];
        ad = Z(i,idxa0)/(gamma+mu);
        TempW(i,idxa0) = EProjSimplex_new(ad);    
    end;
    W = TempW;
    % Update zeta
    h = W-W';
    zeta = zeta+mu*h;
    % Update mu
    mu = rho*mu;
    W = (W+W')/2;
    D = diag(sum(W));
    L = D-W;
    F_old = F;
    [F, temp, ev]=eig1(L, c, 0);
    evs(:,iter+1) = ev;

    fn1 = sum(ev(1:c));
    fn2 = sum(ev(1:c+1));

    I = eye(num);
    Z = D-I; % for a doubly stochastic  graph, the degree matrix D is equal to identity matrix I
    flag = sum(logical(diag(Z)<0.00001)); % control the doubly stochastic property of  graph
    if fn1 > 0.00000000001 
        lambda = 2*lambda;
    elseif fn2 < 0.00000000001
        lambda = lambda/2;  F = F_old;
    elseif fn1 < 0.00000000001 & fn2 > 0.00000000001 & flag == num 
        break;
    end;

end;
 


