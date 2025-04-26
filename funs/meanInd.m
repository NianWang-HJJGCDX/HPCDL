function [means] = meanInd(X, label, m)

Class = unique(label);

means = zeros(size(X,1), m);
for i=1:length(Class)
    sub_idx = (label==Class(i));
    means(:,i) = mean(X(:,sub_idx),2); % the means of the pixles in one cluster
end

end
