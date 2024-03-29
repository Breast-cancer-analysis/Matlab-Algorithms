clear all

% import csv file and save file name for plot
file = '../data/468_none_active_tcs_filt';
M = readmatrix(file);
M = M(2:end,4:end);
nlst = split(erase(file,'.csv'),'_');
name = join(nlst,' ');

perplot = 50;
th = 0.007;
total_lines = size(M,1);          % number of voltage lines
istart = 1;                       % starting number of actual voltage line for plotting
n_plot = ceil(total_lines/perplot);   % number of plots (max 100 lines per plot)
s = 0.03;                         % seperation of voltage lines
n_plot = 3;

%% seperate plot for each 50 voltage lines

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
        plot(data,LineWidth=0.7,Color='k');
        hold on
        yline(centres(i)-th,'r',LineWidth=0.7)
    end
    % title(name);
    yticks(flip(centres));
    yticklabels(string(flip(n_pos)));
    axis tight;
    xlabel('time');
    ylabel('voltage lines');
    hold off

    istart = istart+perplot;
end
title(name)
