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

myDir = '/Users/treviyek/Documents/cancer_data/sorted_data/468'; %gets directory
myFiles = dir(fullfile(myDir,'*.csv'));

Mf = readmatrix('../data/468_none_active_tcs_filt.csv');
Mf = Mf(2:end,4:end);
mf_spiketrain = getSpikeTrain(Mf,1,'negative');
% Shuffle row
scram = mf_spiketrain(randperm(size(mf_spiketrain, 1)),:);
ind=0;

F(length(myFiles))=zeros; %gets all wav files in struct
M_corr = [];
M_corr_scram = [];

%%
for i = 1:length(myFiles)
    M = readmatrix(strcat([myDir,'/',myFiles(i).name]));
    M = M(2:end,4:end);
    new_ind = ind+size(M,1);
    [scram_crosscorr,scram_lags] = populatn_xcorr(mf_spiketrain(ind+1:new_ind,:));
    M_corr_scram(i,:) = scram_crosscorr;

    [spike_trains,bins] = getSpikeTrain(M,1,'negative');
    [crosscorr,lags] = populatn_xcorr(spike_trains);
    M_corr(i,:) = crosscorr;
    ind = new_ind;
end

% Randomise and calculate again in each field of view
% Add the error bars ir error plots?
% Look at papers
%%
popul = sum(M_corr,1)/size(M_corr,1);
scram_popul = sum(M_corr_scram,1)/size(M_corr_scram,1);

% Plot the population cross-correlation
figure;
% plot(lags, M_corr(1:7,:));
plot(lags, popul,'b');
% hold on
% plot(scram_lags, scram_popul,'r');
%legend
title('Population Cross-Correlation of Spike Trains');
xlabel('Time Lag');
ylabel('Averaged Cross-Correlation');

% Plot the population cross-correlation
figure;
% plot(lags, M_corr(1:7,:));
plot(scram_lags, scram_popul,'r');
%legend
title('Scrambled Population Cross-Correlation of Spike Trains');
xlabel('Time Lag');
ylabel('Averaged Cross-Correlation');
