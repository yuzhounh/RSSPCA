function classify_RSPCA(cDataset,iRep,iEta1)
% Calculate the classification accuracy of RSPCA. 
% 2022-6-26 00:34:45

% parameters
lg_sEta1=-6:0.2:6;  % lg(eta_1)
sEta1=10.^lg_sEta1;  % eta_1
cEta1=sEta1(iEta1);

% load face dataset
load(sprintf('data/%s.mat',cDataset));
[image_height,image_width,n_image]=size(x);
dim=image_height*image_width;
x=reshape(x,[dim,n_image]); % 2D to 1D

% Laplacian matrix
load(sprintf('data/%s_Laplacian.mat',cDataset),'L');

% randomly choose a subset for trainning
% rng(iRep);
ix_train=zeros(n_image,1);
tmp=randperm(n_image);
ix_train(tmp(1:ceil(n_image*2/3)))=1;   
ix_test=1-ix_train;

ix_train=find(ix_train);
ix_test=find(ix_test);

n_train=length(ix_train);
n_test=length(ix_test);

x_train=x(:,ix_train);
x_test=x(:,ix_test);

label_train=label(ix_train);
label_test=label(ix_test);

% subtract the mean
x_mean=mean(x_train,2);
x_train=x_train-repmat(x_mean,[1,n_train]);
x_test=x_test-repmat(x_mean,[1,n_test]);

% RSPCA, a special case of RSSPCA when eta_2=0
sPV=1:30;  % projection vectors
nPV=length(sPV);
[W,iter]=RSSPCA(x_train,L,cEta1,0,nPV);  

% reserve the projection results
x_train_reserve=W'*x_train;
x_test_reserve=W'*x_test;

% classification
accuracy=zeros(nPV,1);
for iPV=1:nPV
    x_train_proj=x_train_reserve(1:iPV,:);
    x_test_proj=x_test_reserve(1:iPV,:);
    
    % nearest neighbor classifier
    dxx=pdist2(x_train_proj',x_test_proj');
    [~,ix]=min(dxx);
    label_predict=label_train(ix);
    
    accuracy(iPV)=mean(label_predict==label_test);
end

% save the classification accuracies
save(sprintf('result/classify_RSPCA_%s_iRep_%d_iEta1_%d.mat',cDataset,iRep,iEta1),'accuracy','iter');