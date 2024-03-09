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

filename = 'wm';

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
    coeff = [];
    count = 1;
    [spike_trains,bins] = getSpikeTrain(M,1,'negative');
    Time = [bins(1), bins(end)];
    for i = 1:len - 1
        for j = i+1:len
            spike_times1 = T_rastors(spike_trains(i,:),bins);
            spike_times2 = T_rastors(spike_trains(j,:),bins);
            sttc_index = calcSTTC(5, Time, spike_times1, spike_times2);

            coeff = [coeff, sttc_index];
            count = count +1;
            %disp([num2str(count),': ',num2str(coeff)])
        end
    end
    STTC = [STTC,coeff];
    % fieldname = ['fov',num2str(n)];
    % FOV_coeff.(fieldname) = coeff;
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






