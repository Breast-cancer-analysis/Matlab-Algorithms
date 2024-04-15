% clear all
% clc
% close all
%%
% file1: cancer_cancer20220308_slip3_area3_long_acq_cancer20220308_slip3_area3_long_acq_blue_0.112_green_0.0673_L468_1_data.csv
% file2: cancer_20201229_slip3_area2_long_acq_corr_long_acq_blue_0.0317_green_0.0664_1_data.csv
% cancer_cancer20220210_slip3_area1_20220210_slip3_area1_long_acq_blue_0.112_green_0.0673_L231_2_data.csv

% import csv file and save file name for plot
% file = '../data/231_none_active_tcs_filt'; 17
filen = erase(FOV_coeff(38).filename,'sttc_');
% filen = 'cancer_cancer20220308_slip3_area3_long_acq_cancer20220308_slip3_area3_long_acq_blue_0.112_green_0.0673_L468_1_data.csv';
file = ['/Users/treviyek/Documents/cancer_data/sorted_data/231/',filen];
M = readtable(file);

cell_num = split(table2array(M(2:end,3)),"_");
cell_num=cell_num(:,end);


M = table2array(M(2:end,4:end));
nlst = split(erase(file,'.csv'),'_');
% name = join(nlst,' ');
name = 'Some cells that show total and partial synchrony';

% cell_num = cell_num([3,4,15,16,18,19,20,21,22,23,24]);
% M = M([3,4,15,16,18,19,20,21,22,23,24],:);


perplot = 50;
% th = 0.0048;
total_lines = size(M,1);          % number of voltage lines
istart = 1;                       % starting number of actual voltage line for plotting
n_plot = ceil(total_lines/perplot);   % number of plots (max 100 lines per plot)
s = 0.02;                         % seperation of voltage lines
time = 0:0.2:(size(M,2)-1)*0.2;

%%

% M1 = M([2,4,3,5,9],:);
% m1 = cell_num([2,4,3,6,9]);
% M2 = M([9,2,1,4],:);
% m2 = cell_num([9,2,1,4]);
% M3 = M([2,4,5,3,9],:);
% m3 = cell_num([2,4,5,3,9]);
% 
% vline = 1:size(M1,1);
% centres = 1-vline*s;
% 
% figure(231);
% subplot(1,3,1)
% for i=1:size(M1,1)
%         data = M1(i,:) - i*s;
%         plot(time,data,'k','Linewidth',0.7);
%         hold on
%         % yline(centres(i)-0.006,'r--','LineWidth',0.7,'Alpha',0.5)
% end
% grid on
% grid minor
% title('observation 1');
% yticks(flip(centres));
% % yticklabels(string(flip(centres)));
% yticklabels(string(flip(m1')));
% xlim([400 500])
% xlabel('time (s)');
% ylabel('voltage lines');
% hold off
% 
% vline = 1:size(M2,1);
% centres = 1-vline*s;
% subplot(1,3,2)
% for i=1:size(M2,1)
%         data = M2(i,:) - i*s;
%         plot(time,data,'k','Linewidth',0.7);
%         hold on
%         % yline(centres(i)-0.006,'r--','LineWidth',0.7,'Alpha',0.5)
% end
% grid on
% grid minor
% title('observation 2');
% yticks(flip(centres));
% % yticklabels(string(flip(centres)));
% yticklabels(string(flip(m2')));
% xlim([600 700])
% xlabel('time (s)');
% ylabel('voltage lines');
% hold off
% 
% vline = 1:size(M3,1);
% centres = 1-vline*s;
% subplot(1,3,3)
% for i=1:size(M3,1)
%         data = M3(i,:) - i*s;
%         plot(time,data,'k','Linewidth',0.7);
%         hold on
%         % yline(centres(i)-0.006,'r--','LineWidth',0.7,'Alpha',0.5)
% end
% grid on
% grid minor
% title('observation 3');
% yticks(flip(centres));
% % yticklabels(string(flip(centres)));
% yticklabels(string(flip(m3')));
% xlim([800 900])
% xlabel('time (s)');
% ylabel('voltage lines');
% hold off



%% seperate plot for each perplot voltage lines

for n=1:n_plot
    R = total_lines-istart;

    if R>(perplot-1)
        vline = 1:perplot;            % line numbers on a specific plot
        centres = 1-vline*s;      % y-values for the centres of the vline
        iend = istart+(perplot-1);
    else
        vline = 1:(R+1);
        centres = 1-vline*s;
        iend = total_lines;
    end

    n_pos = istart:iend;          % index from the actual voltage line matrix

    % plot one figure
    figure(n); hold on;
    for i=1:size(n_pos,2)
        data = M(n_pos(i),:) - i*s;
        plot(time,data,'k','Linewidth',0.7);
        % yline(centres(i)-0.006,'r--','LineWidth',0.7,'Alpha',0.5)
    end
    grid on
    grid minor
    title(name);
    yticks(flip(centres));
    % yticklabels(string(flip(centres)));
    yticklabels(string(flip(cell_num')));
    axis tight;
    xlabel('time (s)');
    ylabel('voltage lines');
    hold off

    istart = istart+perplot;
end
title(name)
