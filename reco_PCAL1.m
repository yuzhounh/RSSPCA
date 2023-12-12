function reco_PCAL1(cDataset)
% Calculate the reconstruction errors of PCA-L1. 
% 2022-6-26 00:34:45

% load data
load(sprintf('data/%s_noise',cDataset));
nImage=size(x_noise,3);
x_noise=reshape(x_noise,[numel(x_noise)/nImage,nImage]);
x_mean=mean(x_noise,2);
x_centered=x_noise-repmat(x_mean,1,nImage);

% PCA-L1
nPV=30;
[W,iter]=PCAL1(x_centered,nPV);

% calculate the reconstruction error
err=zeros(nPV,1);
tic;
for iPV=1:nPV
    w=W(:,1:iPV);
    
    % reconstructed images
    x_reco=zeros(size(x_noise));
    for iImage=1:nImage
        x_reco(:,iImage)=w*w'*x_centered(:,iImage)+x_mean;
    end
    temp=x_noise-x_reco;
    
    % residual errors
    rsd=0;
    for iImage=nImage/5+1:nImage
        rsd=rsd+norm(temp(:,ix_noise(iImage)));
    end
    err(iPV)=rsd/(nImage*4/5);
    
    perct(toc,iPV,nPV);
end
time=toc/60;

% save the reconstruction errors
save(sprintf('result/reco_PCAL1_%s.mat',cDataset),'err','iter','time');
