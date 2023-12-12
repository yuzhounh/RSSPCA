function W=PCA(x,nPV)
% calculate multiple projection vectors for PCA
% 2022-6-25 21:20:17

[W0,~,~]=svd(x,0); 
W=W0(:,1:nPV);