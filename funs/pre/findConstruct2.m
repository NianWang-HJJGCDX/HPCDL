function [X_temp] = findConstruct(X,index,k)
    if index==0
        index=X;
    end
    if k>=size(X,1)
        k=size(X,1)-1;
    end
    [n,m] = size(X);
    X_temp = zeros(n,m);
    
    distX = EuDist2(index);
%     [idx2,d] = popo(index,8,k);idx2=idx2';
%     disp('step flann done...')
    [~,idx2] = mink(distX,k+1,2);
   
    for i=1:n
        temp_x = X(idx2(i,:),:);
        X_temp(i,:) = mean(temp_x);
    end

end