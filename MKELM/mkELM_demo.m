clear
clc
warning off;
path = '.\';
addpath(genpath(path));
dataName = 'heart'; %%% flower17; flower102; CCV; caltech101_numofbasekernel_10
%% UCI_DIGIT; proteinFold; psortPos
%% washington; wisconsin; texas; cornell
%% AR10P
%% caltech101_10base
load([path,'datasets\',dataName,'_Kmatrix'],'K','Y');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if min(Y)==-1
    Y(Y==-1)=2;
end
numclass = length(unique(Y));
numker = size(K,3);
num = size(K,1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
K = kcenter(K);
% K = knorm(K);

%%%--- Training----%%%%%%%%%
C=1; %% Needing to be tuned 
qnorm = 2; %% 
[gamma1,alpha1,obj1] = mkMulticlassELM(K,C,Y,qnorm);
%%%%----Test-----%%%%%%%%%%%%%%%%%%%%%%
[val1,indx1] = max(sumKbeta(K,gamma1)*alpha1,[],2);
acc(1) = mean(indx1==Y);

%%%%---Radius-Incorporated MK-ELM--%%%%%%%%%%%
[gamma2,alpha2,obj2] = mkMulticlassRadiusELM(K,C,Y,qnorm);
%%%%----Test-----%%%%%%%%%%%%%%%%%%%%%%
[val2,indx2] = max(sumKbeta(K,gamma2)*alpha2,[],2);
acc(2) = mean(indx2==Y);