clear all
clc
close all

%%
% filename = '231';
% myDir = '/Users/treviyek/Downloads/shuffled_sttc/';
% myFiles = dir(fullfile(myDir,'*.csv'));
% 
% for n = 1:length(myFiles)
%     M = readtable(strcat([myDir,'/',myFiles(n).name]));
%     name = erase(myFiles(n).name,"_sttc.csv");
%     name(regexp(name,'_')) = ' ';
%     sttc1 = M.STTC_plusminus1;
%     sttc5 = M.STTC_plusminus5;
%     sttc10 = M.STTC_plusminus10;
% 
%     len = length(sttc1);
%     figure(1);
%     subplot(2,5,n)
%     hold on
%     swarmchart(ones(1,len),sttc1,3,'filled','MarkerEdgeColor',"#0072BD",'MarkerFaceColor',"#0072BD")
%     xlabel('density jitter')
%     ylabel('STTC values')
%     title(['STTC with \pm\Delta 1s for ',name])
%     ylim([-0.2 1])
%     grid on
% 
%     figure(2);
%     subplot(2,5,n)
%     hold on
%     swarmchart(ones(1,len),sttc5,3,'filled','MarkerEdgeColor',"#D95319",'MarkerFaceColor',"#D95319")
%     xlabel('density jitter')
%     ylabel('STTC values')
%     title(['STTC with \pm\Delta 5s for ',name])
%     ylim([-0.3 1])
%     grid on
% 
%     figure(3);
%     subplot(2,5,n)
%     hold on
%     swarmchart(ones(1,len),sttc10,3,'filled','MarkerEdgeColor',"#77AC30",'MarkerFaceColor',"#77AC30")
%     xlabel('density jitter')
%     ylabel('STTC values')
%     title(['STTC with \pm\Delta 10s for ',name])
%     ylim([-0.4 1])
%     grid on
% 
% end

%%

% filename = 'wm_sttc';
% load([filename,'.mat'])

% STTC1 = [];
% STTC5 = [];
% STTC10 = [];
% for n=1:length(FOV_coeff)
%     STTC1 = [STTC1, FOV_coeff(n).STTC_plusminus1];
%     STTC5 = [STTC5, FOV_coeff(n).STTC_plusminus5];
%     STTC10 = [STTC10, FOV_coeff(n).STTC_plusminus10];
%     disp(['FOV ',num2str(n)])
% end
% 
% len = length(STTC1);
% 
% figure(1);
% subplot(2,3,1)
% swarmchart(ones(1,len),STTC1,3,'MarkerEdgeColor',"#0072BD")
% xlabel('density')
% ylabel('STTC values')
% title('Swarm chart of STTC1 distribution')
% grid on
% subplot(2,3,2)
% swarmchart(ones(1,len),STTC5,3,'MarkerEdgeColor',"#D95319")
% xlabel('density')
% ylabel('STTC values')
% title('Swarm chart of STTC5 distribution')
% grid on
% subplot(2,3,3)
% swarmchart(ones(1,len),STTC10,3,'MarkerEdgeColor',"#77AC30")
% xlabel('density')
% ylabel('STTC values')
% title('Swarm chart of STTC10 distribution')
% grid on
% 
% subplot(2,3,4)
% histogram(STTC1,'FaceColor',"#0072BD",'Normalization','pdf')
% xlabel('STTC values')
% ylabel('probability density')
% title('Histogram of STTC1 distribution')
% subplot(2,3,5)
% histogram(STTC5,'FaceColor',"#D95319",'Normalization','pdf')
% xlabel('STTC values')
% ylabel('probability density')
% title('Histogram of STTC5 distribution')
% subplot(2,3,6)
% histogram(STTC10,'FaceColor',"#77AC30",'Normalization','pdf')
% xlabel('STTC values')
% ylabel('probability density')
% title('Histogram of STTC10 distribution')
