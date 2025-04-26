clear; close all; clc;

% add path
currentFolder = pwd;
addpath(genpath(currentFolder));

% choose data set and set optimal hyperparameters
dataset = 'LongKou';
load(dataset);
% paramter setting
r = 54; alpha=100; k = 5; Iter = 12;
%  HSI data preprocessing
gt = double(gt(:));
ind = find(gt>0); 
c = length(unique(gt(ind)));
[X,A,m] = preprocessing(data,20);
% run our method 
y_pred = HPCDL(X, A, m, c, r, k, alpha,Iter);
% report the results
results = evaluate_results_clustering(gt(ind),y_pred(ind)); % the combination of the results
acc_perType = results.p_acc;
acc_o = results.acc_o; 
acc_a =results.acc_a ;
kappa =results.kappa ;
NMI =results.NMI;
Purity =results.Purity;
F1_Measur =results.F1_Measur;
ARI =results.ARI;



