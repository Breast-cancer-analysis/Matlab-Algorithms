clear
clc
% 231_none_active_tcs_filt
% 453_none_active_tcs_filt
% 468_none_active_tcs_filt
% MCF10A_none_active_tcs_filt
% MCF10A_TGFB_none_active_tcs_filt
% SUM159_none_active_tcs_filt
% Cal51_none_active_tcs_filt
% BT474_none_active_tcs_filt
% T47D_none_active_tcs_filt
% wm_none_active_tcs_filt

filename = '468';

myDir = join(['/Users/treviyek/Documents/cancer_data/sorted_data/',filename]); %gets directory
myFiles = dir(fullfile(myDir,'*.csv'));

% Mf = readmatrix('../data/468_none_active_tcs_filt.csv');
% Mf = Mf(2:end,4:end);
% mf_spiketrain = getSpikeTrain(Mf,1,'negative');
% % Shuffle row
% scram = mf_spiketrain(randperm(size(mf_spiketrain, 1)),:);
% ind=0;
% M_corr_scram = [];

F(length(myFiles))=zeros; %gets all wav files in struct

FOV_coeff = struct();
STTC = [];

%%
for n = 1:length(myFiles)
    M = readmatrix(strcat([myDir,'/',myFiles(n).name]));
    M = M(2:end,4:end);
    % new_ind = ind+size(M,1);
    % ind = new_ind;

    len = size(M,1);

    % variables setup
    coeff1 = [];
    coeff5 = [];
    coeff10 = [];
    cell1 = [];
    cell2 = [];

    count = 1;
    [spike_trains,bins,th] = getSpikeTrain(M,1,'negative',0.007);
    Time = [bins(1), bins(end)];
    for i = 1:len - 1
        for j = i+1:len
            spike_times1 = T_rastors(spike_trains(i,:),bins);
            spike_times2 = T_rastors(spike_trains(j,:),bins);
            sttc_index1 = calcSTTC(1, Time, spike_times1, spike_times2);
            sttc_index5 = calcSTTC(5, Time, spike_times1, spike_times2);
            sttc_index10 = calcSTTC(10, Time, spike_times1, spike_times2);

            coeff1 = [coeff1, sttc_index1];
            coeff5 = [coeff5, sttc_index5];
            coeff10 = [coeff10, sttc_index10];

            cell1 = [cell1, i];
            cell2 = [cell2, j];
            count = count +1;
            %disp([num2str(count),': ',num2str(coeff)])
        end
    end
    %------------------------------------%
    % save individually for each FOV %
    FOV_coeff(n).filename = ['sttc_',myFiles(n).name];
    FOV_coeff(n).first_cell = cell1;
    FOV_coeff(n).secnd_cell = cell2;
    FOV_coeff(n).STTC_plusminus1 = coeff1;
    FOV_coeff(n).STTC_plusminus5 = coeff5;
    FOV_coeff(n).STTC_plusminus10 = coeff10;
    %------------------------------------%

    STTC = [STTC,coeff5];
    disp(['FOV ',num2str(n)])
end

%%
% F = fieldnames(FOV_coeff);
% indexes = [];
% for f = 1:length(F)
%     indexes = cat(1,indexes,mean(FOV_coeff.(F{f})));
% end

%%
histogram(STTC, 'Normalization','probability','NumBins',20)
title([filename,' with population average=',num2str(mean(STTC))])
xlim([-1 1])
xlabel("STTC coeff")
ylabel("Probability Density")






