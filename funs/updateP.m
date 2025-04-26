function Q = updateQ(X,C,Z,r)
St = X*X';
Q =  St - 2*X*Z*C' + C*diag(sum(Z))*C'; Q = (Q+Q')/2;
invSt = inv(St);
H = invSt*Q;
Q = eig1(H,r,0,0);
Q = Q*diag(1./sqrt(diag(Q'*Q)));
end
