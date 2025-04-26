function [OA, AA, K,IA]=ClassifyAccuracy(true_label,estim_label)
% function ClassifyAccuracy(true_label,estim_label)
% This function compute the confusion matrix and extract the OA, AA
% and the Kappa coefficient.
%http://kappa.chez-alice.fr/kappa_intro.htm

l=length(true_label);
nb_c=max(true_label);

%compute the confusion matrix
confu=zeros(nb_c);
for i=1:l
    confu(true_label(i),estim_label(i))= confu(true_label(i),estim_label(i))+1;
end

OA=trace(confu)/sum(confu(:)); %overall accuracy
IA=diag(confu)./sum(confu,2);  %individual accuracy
IA(isnan(IA))=0;
number=size(IA,1);

AA=sum(IA)/number; % average accuracy
Po=OA;
Pe=(sum(confu)*sum(confu,2))/(sum(confu(:))^2);
K=(Po-Pe)/(1-Pe);%kappa coefficient
end