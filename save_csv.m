clear all
clc
close all
%%

% filename = 'wm_sttc';
% load([filename,'.mat'])
% 
% STTC_plusminus1 = [];
% STTC_plusminus5 = [];
% STTC_plusminus10 = []; 
% 
% for n=1:length(FOV_coeff)
%     FirstCell = FOV_coeff(n).first_cell';
%     SecndCell = FOV_coeff(n).secnd_cell';
%     STTC_plusminus1 = FOV_coeff(n).STTC_plusminus1';
%     STTC_plusminus5 = FOV_coeff(n).STTC_plusminus5';
%     STTC_plusminus10 = FOV_coeff(n).STTC_plusminus10';
%     tab = table(FirstCell,SecndCell,STTC_plusminus1,STTC_plusminus5,STTC_plusminus10);
%     writetable(tab, ['/Users/treviyek/Downloads/shuffled_sttc/wm/',FOV_coeff(n).filename])
%     disp(['FOV ',num2str(n)])
% end


%%
% 231_none_active_tcs_filt   0.006
% 453_none_active_tcs_filt   0.0077
% 468_none_active_tcs_filt    0.007
% MCF10A_none_active_tcs_filt 0.0043
% MCF10A_TGFB_none_active_tcs_filt  0.0026
% SUM159_none_active_tcs_filt  0.0067
% Cal51_none_active_tcs_filt  0.0106
% BT474_none_active_tcs_filt  0.006   has depolarisation peaks
% T47D_none_active_tcs_filt  0.0059    has depolarisation peaks
% wm_none_active_tcs_filt  0.0048

filename = 'wm';
th_val = 0.0048;

myDir = join(['/Users/treviyek/Documents/cancer_data/sorted_data/',filename]);
myFiles = dir(fullfile(myDir,'*.csv'));
fov_name = {};
time_stamps = [];
cell_num = [];

for n = 1:length(myFiles)
    M = readtable(strcat([myDir,'/',myFiles(n).name]));

    name = table2array(M(2:end,3));
    Num = split(name,"_");
    Num = str2double(Num(:,end));

    M = table2array(M(2:end,4:end));
    len = size(M,1);
    [spike_trains,bins,th] = getSpikeTrain(M,1,'negative',th_val);
    for i = 1:len
        t_rastor = T_rastors(spike_trains(i,:),bins);
        time_stamps = [time_stamps, t_rastor];
        for j=1:length(t_rastor)
            fov_name{end+1} = name(i);
            cell_num = [cell_num, Num(i)];
        end
    end
    disp(['File number: ',num2str(n)])
end
%%
tab = table(fov_name',time_stamps',cell_num','VariableNames',{'FOV_cell_label','Event_time','Cell_number'});
writetable(tab, ['/Users/treviyek/Downloads/event_time_list/',filename,'.csv'])
