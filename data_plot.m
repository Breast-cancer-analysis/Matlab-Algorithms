clear all
clc
close all
%%

% import csv file and save file name for plot
% file = '../data/SUM159_none_active_tcs_filt';
file = '/Users/treviyek/Documents/cancer_data/sorted_data/468/cancer_cancer20220315_slip1_area3_long_acq_cancer20220315_slip1_area3_long_acq_blue_0.112_green_0.0673_L468_1_data.csv';
M = readtable(file);

cell_num = split(table2array(M(2:end,3)),"_");
cell_num=cell_num(:,end);

M = table2array(M(2:end,4:end));
nlst = split(erase(file,'.csv'),'_');
name = join(nlst,' ');

perplot = 50;
th = 0.0048;
total_lines = size(M,1);          % number of voltage lines
istart = 1;                       % starting number of actual voltage line for plotting
n_plot = ceil(total_lines/perplot);   % number of plots (max 100 lines per plot)
s = 0.03;                         % seperation of voltage lines
time = 0:0.2:(size(M,2)-1)*0.2;

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
        hold on
        yline(centres(i)-th,'r','LineWidth',0.7)
    end
    title(name);
    yticks(flip(centres));
    yticklabels(string(flip(cell_num')));
    axis tight;
    xlabel('time');
    ylabel('voltage lines');
    hold off

    istart = istart+perplot;
end
title(name)
