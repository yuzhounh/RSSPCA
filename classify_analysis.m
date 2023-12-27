% 2023-12-27 16:00:19

clear,clc,close all;

cDataset='ORL';
nRep=10;

%% PCA
accs=zeros(30,nRep);
for iRep=1:nRep
    load(sprintf('result/classify_PCA_%s_iRep_%d.mat',cDataset,iRep));
    accs(:,iRep)=accuracy;
end
fprintf('PCA, %0.4f\n',mean(accs(:)));

figure;
plot(1:30,mean(accs,2),'-o','linewidth',1);
xlabel('Number of projection vectors');
ylabel('Classification accuracy');
ylim([0,1]);
title('PCA','FontSize',12);

% scale
pos=get(gcf,'Position');
scale=0.7;
set(gcf,'Position',[pos(1),pos(2),pos(3)*scale,pos(4)*scale]);


%% PCA-L1
accs=zeros(30,nRep);
for iRep=1:nRep
    load(sprintf('result/classify_PCAL1_%s_iRep_%d.mat',cDataset,iRep));
    accs(:,iRep)=accuracy;
end
fprintf('PCA-L1, %0.4f\n',mean(accs(:)));

figure;
plot(1:30,mean(accs,2),'-o','linewidth',1);
xlabel('Number of projection vectors');
ylabel('Classification accuracy');
ylim([0,1]);
title('PCA-L1','FontSize',12);

% scale
pos=get(gcf,'Position');
scale=0.7;
set(gcf,'Position',[pos(1),pos(2),pos(3)*scale,pos(4)*scale]);


%% RSPCA
lg_sEta1=-6:0.2:6;  % lg(eta_1)
sEta1=10.^lg_sEta1;  % eta_1
nEta1=length(sEta1);
accs=zeros(nEta1,nRep);
for iEta1=1:nEta1
    for iRep=1:nRep
        load(sprintf('result/classify_RSPCA_%s_iRep_%d_iEta1_%d.mat',cDataset,iRep,iEta1));
        accs(iEta1,iRep)=mean(accuracy);
    end
end
accs=mean(accs,2);

% find the max
[a,b]=find(max(accs)==accs);
para_opt=lg_sEta1(a);
fprintf('\nRSPCA\n');
fprintf('Maximal classfication accuracy: %0.4f.\n',max(accs));
fprintf('lg(eta_1): %0.2f\n',para_opt);

figure;
plot(lg_sEta1,accs,'-o','linewidth',1);
xlabel('lg(\eta_1)');
ylabel('Classification accuracy');
ylim([0.67,0.87]);
title('RSPCA');

% scale
pos=get(gcf,'Position');
scale=0.7;
set(gcf,'Position',[pos(1),pos(2),pos(3)*scale,pos(4)*scale]);


%% RSMPCA
lg_sEta2=-2:0.2:6;  % lg(eta_2)
sEta2=10.^lg_sEta2;  % eta_2
nEta2=length(sEta2);
accs=zeros(nEta2,nRep);
for iEta2=1:nEta2
    for iRep=1:nRep
        load(sprintf('result/classify_RSMPCA_%s_iRep_%d_iEta2_%d.mat',cDataset,iRep,iEta2));
        accs(iEta2,iRep)=mean(accuracy);
    end
end
accs=mean(accs,2);

% find the max
[a,b]=find(max(accs)==accs);
para_opt=lg_sEta2(a);
fprintf('\nRSMPCA\n');
fprintf('Maximal classfication accuracy: %0.4f.\n',max(accs));
fprintf('lg(eta_2): %0.2f\n',para_opt);

figure;
plot(lg_sEta2,accs,'-o','linewidth',1);
xlabel('lg(\eta_2)');
ylabel('Classification accuracy');
title('RSMPCA');

% scale
pos=get(gcf,'Position');
scale=0.7;
set(gcf,'Position',[pos(1),pos(2),pos(3)*scale,pos(4)*scale]);


%% RSSPCA
lg_sEta1=-3:0.2:1;  % lg(eta_1)
lg_sEta2=-1:0.2:3;  % lg(eta_2)

sEta1=10.^lg_sEta1;  % eta_1
sEta2=10.^lg_sEta2;  % eta_2

nEta1=length(sEta1);
nEta2=length(sEta2);

accs=zeros(nEta1,nEta2,nRep);
for iEta1=1:nEta1
    for iEta2=1:nEta2
        for iRep=1:nRep
            load(sprintf('result/classify_RSSPCA_%s_iRep_%d_iEta1_%d_iEta2_%d.mat',cDataset,iRep,iEta1,iEta2));
            accs(iEta1,iEta2,iRep)=mean(accuracy);
        end
    end
end
accs=mean(accs,3);

% find the max
[a,b]=find(max(accs(:))==accs);
para_opt=[lg_sEta1(a)',lg_sEta2(b)'];
n=size(para_opt,1);
fprintf('\nRSSPCA\n');
fprintf('The number of optimal parameter pairs: %d.\n',n);
fprintf('Maximal classfication accuracy: %0.4f.\n',max(accs(:)));
fprintf('[lg(eta_1), lg(eta_2)]:\n');
for i=1:n
    fprintf('[%0.4f, %0.4f]', para_opt(i,1), para_opt(i,2));
end
fprintf('\n');

figure1=figure;
axes1 = axes('Parent',figure1);
accs=matrix_to_figure(accs);
imagesc(accs);
xlabel('lg(\eta_1)');
ylabel('lg(\eta_2)')
title('RSSPCA');
set(axes1,'Layer','top','XTick',[1 6 11 16 21],'XTickLabel',...
    {'-3','-2','-1','0','1'},'YTick',[1 6 11 16 21],'YTickLabel',...
    fliplr({'-1','0','1','2','3'}));
colorbar;

% resize
pos=get(gcf,'Position');
scale=0.7;
set(gcf,'Position',[pos(1),pos(2),pos(3)*scale,pos(4)*scale]);
