% 2023-12-12 15:33:39

clear,clc,close all;

%% preprocessing
Laplacian_matrix; % calculate the Laplacian matrix for each dataset
add_noise; % add random noises for reconstruction

%% reconstruction
mkdir('result');
cDataset='ORL';

% PCA
reco_PCA(cDataset);

% PCA-L1
reco_PCAL1(cDataset);

% RSPCA
lg_sEta1=-5:0.2:3;   % lg(eta_1)
sEta1=10.^lg_sEta1;  % eta_1
nEta1=length(sEta1);

for iEta1=1:nEta1
    reco_RSPCA(cDataset,iEta1);
end

% RSMPCA
lg_sEta2=-2:0.2:3;   % lg(eta_2)
sEta2=10.^lg_sEta2;  % eta_2
nEta2=length(sEta2);

for iEta2=1:nEta2
    reco_RSMPCA(cDataset,iEta2);
end

% RSSPCA
lg_sEta1=-5:0.2:1;  % lg(eta_1)
lg_sEta2=-2:0.2:1;  % lg(eta_2)

sEta1=10.^lg_sEta1;  % eta_1
sEta2=10.^lg_sEta2;  % eta_2

nEta1=length(sEta1);
nEta2=length(sEta2);

for iEta1=1:nEta1
    for iEta2=1:nEta2
        reco_RSSPCA(cDataset,iEta1,iEta2);
    end
end

%% classification
nRep=10;
for iRep=1:nRep
    % PCA
    classify_PCA(cDataset,iRep);

    % PCA-L1
    classify_PCAL1(cDataset,iRep);

    % RSPCA
    lg_sEta1=-6:0.2:6;   % lg(eta_1)
    sEta1=10.^lg_sEta1;  % eta_1
    nEta1=length(sEta1);

    for iEta1=1:nEta1
        classify_RSPCA(cDataset,iRep,iEta1);
    end

    % RSMPCA
    lg_sEta2=-2:0.2:6;   % lg(eta_2)
    sEta2=10.^lg_sEta2;  % eta_2
    nEta2=length(sEta2);

    for iEta2=1:nEta2
        classify_RSMPCA(cDataset,iRep,iEta2);
    end

    % RSSPCA
    lg_sEta1=-3:0.2:1;  % lg(eta_1)
    lg_sEta2=-1:0.2:3;  % lg(eta_2)

    sEta1=10.^lg_sEta1;  % eta_1
    sEta2=10.^lg_sEta2;  % eta_2

    nEta1=length(sEta1);
    nEta2=length(sEta2);

    for iEta1=1:nEta1
        for iEta2=1:nEta2
            classify_RSSPCA(cDataset,iRep,iEta1,iEta2);
        end
    end
end

%% analysis
reco_analysis; % analyze the reconstruction results
classify_analysis; % analyze the classification results
