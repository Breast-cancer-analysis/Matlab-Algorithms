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

% '../468/cancer_cancer20220308_slip3_area2_long_acq_cancer20220308_slip3_area2_long_acq_blue_0.112_green_0.0673_L468_1_data.csv'
filename = 'wm_none_active_tcs_filt';
file = strcat(['../data/',filename,'.csv']);
name = strrep(filename,'_',' ');
M = readmatrix(file);
M = M(2:end,4:end);

%%

% For original signal
signal = M;
samp_t = 0.2;
time = 0:samp_t:samp_t*(length(signal)-1);


% Generate spike train and time bins
% Taking values 2.5 std less than 1
[spike_trains,bins,th] = getSpikeTrain(signal,1,'negative',0.0048);

%%
% Plot the rastor for the whole cell line
figure; %(1:50,:)
plotSpikeRaster(logical(spike_trains(1:50,:)),'PlotType','imagesc','TimePerBin',1);
ax = 0:100:1000;
xticks(ax);
xlabel('Time (s)')

%% 
% % Distribution of time lags between spikes
% time_lags = getTimeLags(spike_trains,1);
% figure;
% histogram(time_lags,FaceColor="#0072BD")
% xlabel('time lag (s)')
% xlim([0 1000])
% ylabel('number of occurance')
% title(['Distribution of time lags: ',name]);
% 
% % Distribution of the number of spikes (negative spikes here) per cell
% num_spikes = getNumSpikes(spike_trains);
% figure;
% histogram(num_spikes,FaceColor="#A2142F");
% xlabel('spike number per cell')
% ylabel('number of cells with the total spike (within the bins)')
% title(['Distribution of the number of spikes: ',name]);


% % Plot original signal and binary spike train per line of signal
% for i = 3
%     figure(i);
%     subplot(2, 1, 1);
%     plot(time, signal(i,:), 'LineWidth', 2);
%     hold on
%     plot(time, ones(size(signal,2)), 'LineWidth', 1, 'Color','r');
%     xlabel('Time');
%     ylabel('Amplitude');
%     title('Original Signal');
% 
%     subplot(2, 1, 2);
%     stem(bins, spike_trains(i,:), 'r', 'LineWidth', 2, 'Marker', 'none');
%     xlabel('Time');
%     ylabel('Spike Train (0.1s bins)');
%     title('Binary Spike Train');
%     ylim([-0.1 1.1]);
% end
