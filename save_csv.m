clear all
clc
close all
%%
% 
% filename = 'sttc_data/231_sttc';
% load([filename,'.mat'])
% 
% pm1 = 0;
% pm5 = 0;
% pm10 = 0;
% diff = 0;
% 
% 
% for n=1:length(FOV_coeff)
%     len = length(FOV_coeff(n).STTC_plusminus1);
%     lent = 10;
%     STTC_plusminus1 = sum(FOV_coeff(n).STTC_plusminus1>0.8)/len;
%     STTC_plusminus5 = sum(FOV_coeff(n).STTC_plusminus5>0.8)/len;
%     STTC_plusminus10 = sum(FOV_coeff(n).STTC_plusminus10>0.8)/len;
%     if STTC_plusminus1>pm1 && len>lent
%         pm1 = STTC_plusminus1;
%         N1 = n;
%     end
%     if STTC_plusminus5>pm5 && len>lent
%         pm5 = STTC_plusminus5;
%         N2 = n;
%     end
%     if STTC_plusminus10>pm10 && len>lent
%         pm10 = STTC_plusminus10;
%         N3 = n;
%     end
%     if STTC_plusminus10-STTC_plusminus1>diff
%         diff = STTC_plusminus10-STTC_plusminus1;
%         Ndiff = n;
%     end
% 
% end
% disp(['file1: ',FOV_coeff(N1).filename])
% disp(['file2: ',FOV_coeff(N2).filename])
% disp(['file3: ',FOV_coeff(N3).filename])

 %%
STTC_plusminus1 = [];
STTC_plusminus5 = [];
STTC_plusminus10 = []; 

for n=1:length(FOV_coeff)
    FirstCell = FOV_coeff(n).first_cell';
    SecndCell = FOV_coeff(n).secnd_cell';
    STTC_plusminus1 = FOV_coeff(n).STTC_plusminus1';
    STTC_plusminus5 = FOV_coeff(n).STTC_plusminus5';
    STTC_plusminus10 = FOV_coeff(n).STTC_plusminus10';
    tab = table(FirstCell,SecndCell,STTC_plusminus1,STTC_plusminus5,STTC_plusminus10);
    writetable(tab, ['/Users/treviyek/Downloads/shuffled_sttc/wm/',FOV_coeff(n).filename])
    disp(['FOV ',num2str(n)])
end


%%

% filename = 'wm';
% th_val = 0.0048;
% 
% myDir = join(['/Users/treviyek/Documents/cancer_data/sorted_data/',filename]);
% myFiles = dir(fullfile(myDir,'*.csv'));
% fov_name = {};
% time_stamps = [];
% cell_num = [];
% 
% for n = 1:length(myFiles)
%     M = readtable(strcat([myDir,'/',myFiles(n).name]));
% 
%     name = table2array(M(2:end,3));
%     Num = split(name,"_");
%     Num = str2double(Num(:,end));
% 
%     M = table2array(M(2:end,4:end));
%     len = size(M,1);
%     [spike_trains,bins,th] = getSpikeTrain(M,1,'negative',th_val);
%     for i = 1:len
%         t_rastor = T_rastors(spike_trains(i,:),bins);
%         time_stamps = [time_stamps, t_rastor];
%         for j=1:length(t_rastor)
%             fov_name{end+1} = name(i);
%             cell_num = [cell_num, Num(i)];
%         end
%     end
%     disp(['File number: ',num2str(n)])
% end
% tab = table(fov_name',time_stamps',cell_num','VariableNames',{'FOV_cell_label','Event_time','Cell_number'});
% % writetable(tab, ['/Users/treviyek/Downloads/event_time_list/',filename,'.csv'])
