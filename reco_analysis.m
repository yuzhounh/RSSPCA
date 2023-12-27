% 2023-12-27 15:26:51

clear,clc,close all;

cDataset='ORL';

%% PCA, PCA-L1
figure;
load(sprintf('result/reco_PCA_%s.mat',cDataset));
plot(1:30,err,'-o','linewidth',1); hold on;
fprintf('PCA, %0.2f\n',mean(err));

load(sprintf('result/reco_PCAL1_%s.mat',cDataset));
plot(1:30,err,'-+','linewidth',1);
fprintf('PCA-L1, %0.2f\n',mean(err));

xlabel('Number of projection vectors');
ylabel('Reconstruction error');
legend('PCA','PCA-L1','location','northeast');

% scale
pos=get(gcf,'Position');
scale=0.7;
set(gcf,'Position',[pos(1),pos(2),pos(3)*scale,pos(4)*scale]);


%% RSPCA
lg_sEta1=-5:0.2:3;  % lg(eta_1)
sEta1=10.^lg_sEta1;  % eta_1
nEta1=length(sEta1);
errs=zeros(nEta1,1);
for iEta1=1:nEta1
    load(sprintf('result/reco_RSPCA_%s_iEta1_%d.mat',cDataset,iEta1));
    errs(iEta1)=mean(err);
end

% find the min
[a,b]=find(min(errs)==errs);
para_opt=lg_sEta1(a);
fprintf('\nRSPCA\n');
fprintf('Minimal reconstruction error: %0.2f.\n',min(errs));
fprintf('lg(eta_1): %0.2f\n',para_opt);

figure;
plot(lg_sEta1,errs,'-o','linewidth',1);

xlabel('lg(\eta_1)');
ylabel('Reconstruction error');
xlim([-5,3]);
title('RSPCA','FontSize',12);

% resize
pos=get(gcf,'Position');
scale=0.7;
set(gcf,'Position',[pos(1),pos(2),pos(3)*scale,pos(4)*scale]);

%% RSMPCA
lg_sEta2=-2:0.2:3;  % lg(eta_2)
sEta2=10.^lg_sEta2;  % eta_2
nEta2=length(sEta2);
errs=zeros(nEta2,1);
for iEta2=1:nEta2
    load(sprintf('result/reco_RSMPCA_%s_iEta2_%d.mat',cDataset,iEta2));
    errs(iEta2)=mean(err);
end

% find the min
[a,b]=find(min(errs)==errs);
para_opt=lg_sEta2(a);
fprintf('\nRSMPCA\n');
fprintf('Minimal reconstruction error: %0.2f.\n',min(errs));
fprintf('lg(eta_2): %0.2f\n',para_opt);

figure;
plot(lg_sEta2,errs,'-o','linewidth',1);

xlabel('lg(\eta_2)');
ylabel('Reconstruction error');
title('RSMPCA','FontSize',12);

% resize
pos=get(gcf,'Position');
scale=0.7;
set(gcf,'Position',[pos(1),pos(2),pos(3)*scale,pos(4)*scale]);

%% RSSPCA
lg_sEta1=-5:0.2:1;  % lg(eta_1)
lg_sEta2=-2:0.2:1;  % lg(eta_2)

sEta1=10.^lg_sEta1;  % eta_1
sEta2=10.^lg_sEta2;  % eta_2

nEta1=length(sEta1);
nEta2=length(sEta2);

errs=zeros(nEta1,nEta2);
for iEta1=1:nEta1
    for iEta2=1:nEta2
        load(sprintf('result/reco_RSSPCA_%s_iEta1_%d_iEta2_%d.mat',cDataset,iEta1,iEta2));
        errs(iEta1,iEta2)=mean(err);
    end
end

% find the min
[a,b]=find(min(errs(:))==errs);
para_opt=[lg_sEta1(a)',lg_sEta2(b)'];
n=size(para_opt,1);
fprintf('\nRSSPCA\n');
fprintf('The number of optimal parameter pairs: %d.\n',n);
fprintf('Minimal reconstruction error: %0.2f.\n',min(errs(:)));
fprintf('[lg(eta_1), lg(eta_2)]:\n');
for i=1:n
    fprintf('[%0.2f, %0.2f]', para_opt(i,1), para_opt(i,2));
end
fprintf('\n');

figure1=figure;
axes1 = axes('Parent',figure1);
errs=matrix_to_figure(errs);
imagesc(errs);
xlabel('lg(\eta_1)');
ylabel('lg(\eta_2)')
title('RSSPCA','FontSize',12);
set(axes1,'Layer','top','XTick',[1 6 11 16 21 26 31],'XTickLabel',...
    {'-5','-4','-3','-2','-1','0','1'},'YTick',[1 6 11 16],'YTickLabel',...
    fliplr({'-2','-1','0','1'}));
colormap(axes1,flipud(parula));
colorbar;

% resize
pos=get(gcf,'Position');
scale=0.7;
set(gcf,'Position',[pos(1),pos(2),pos(3)*scale,pos(4)*scale]);