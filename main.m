% 2023-12-12 15:33:39

clear,clc,close all;

mkdir('result');

dataset='ORL';
nRep=3;

%% classification
% PCA
classify_PCA(dataset);

% PCA-L1
classify_PCAL1(dataset);

% RSPCA
lg_sEta1=-6:0.2:6;   % lg(eta_1)
sEta1=10.^lg_sEta1;  % eta_1
nEta1=length(sEta1);

for iEta1=1:nEta1
    classify_RSPCA(dataset,iEta1);
end

% RSMPCA
lg_sEta2=-2:0.1:6;   % lg(eta_2)
sEta2=10.^lg_sEta2;  % eta_2
nEta2=length(sEta2);

for iEta2=1:nEta2
    classify_RSMPCA(dataset,iEta2);
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
        classify_RSSPCA(dataset,iEta1,iEta2);
    end
end

%% reconstruction
for iRep=1:nRep
    % PCA
    reco_PCA(dataset,iRep);

    % PCA-L1
    reco_PCAL1(dataset,iRep);

    % RSPCA
    lg_sEta1=-3:0.2:3;   % lg(eta_1)
    sEta1=10.^lg_sEta1;  % eta_1
    nEta1=length(sEta1);

    for iEta1=1:nEta1
        reco_RSPCA(dataset,iRep,iEta1);
    end

    % RSMPCA
    lg_sEta2=-3:0.2:3;   % lg(eta_2)
    sEta2=10.^lg_sEta2;  % eta_2
    nEta2=length(sEta2);

    for iEta2=1:nEta2
        reco_RSMPCA(dataset,iRep,iEta2);
    end

    % RSSPCA
    lg_sEta1=-3:0.2:3;  % lg(eta_1)
    lg_sEta2=-3:0.2:3;  % lg(eta_2)

    sEta1=10.^lg_sEta1;  % eta_1
    sEta2=10.^lg_sEta2;  % eta_2

    nEta1=length(sEta1);
    nEta2=length(sEta2);

    for iEta1=1:nEta1
        for iEta2=1:nEta2
            reco_RSSPCA(dataset,iRep,iEta1,iEta2);
        end
    end
end