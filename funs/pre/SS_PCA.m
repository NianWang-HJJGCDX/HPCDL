function [dataNew] = SS_PCA(data,k,labels)
% 
[nRow,nCol,dim] = size(data);
Results_segment= seg_im_class(data,labels); % Y:超像素块内的像素值。index:在[m*n,d]中的索引。cor：在3D数据[m,n,d]中的索引

Num = size(Results_segment.Y,2); %锚点数
A = zeros(nRow*nCol,dim); %锚点矩阵

for i=1:Num

    tmpY = findConstruct2(Results_segment.Y{1,i},Results_segment.cor{1,i},k);%（数据，3D中的位置，去噪近邻数）
%      tmpY = findConstruct(Results_segment.Y{1,i},0,k);%（数据，3D中的位置，去噪近邻数）
    A(Results_segment.index{1,i},:) = tmpY;
end

dataNew = reshape(A,[nRow,nCol,dim]);
end

