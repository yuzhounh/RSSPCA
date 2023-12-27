% Laplacian matrix
% 2022-7-11 23:29:51

clear,clc;

sDataset={'AR','FEI','Feret','GT','ORL','Yale'}';  % image datasets
nDataset=length(sDataset);

for iDataset=1:nDataset
    cDataset=sDataset{iDataset,1};
    load(sprintf('data/%s.mat',cDataset));

    [h,w,~]=size(x);
    d=h*w;
    [I,J]=ind2sub([h,w],(1:d)');
    dst=pdist([I,J]);
    dst=squareform(dst); % distance
    A=sparse(d,d);
    A(dst==1)=1;  % adjacency matrix
    D=diag(ones(1,d)*A); % degree matrix
    L=D-A; % Laplacian matrix

    save(sprintf('data/%s_Laplacian.mat',cDataset),'L');
end