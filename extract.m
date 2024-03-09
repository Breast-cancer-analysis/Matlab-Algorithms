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

filename = '468_none_active_tcs_filt';
file = strcat(['../data/',filename,'.csv']);
name = strrep(filename,'_',' ');
M = readmatrix(file);
M = M(2:end,4:end);


% Generate spike train and time bins
% Taking values 2.5 std less than 1
[spike_trains,bins] = getSpikeTrain(M,1,'negative');
%%
n=[2 3];
Time = [bins(1), bins(end)];
spike_times1 = T_rastors(spike_trains(n(1),:),bins);
spike_times2 = T_rastors(spike_trains(n(2),:),bins);
sttc_index = calcSTTC(5, Time, spike_times1, spike_times2);

% Plot the rastor for the whole cell line
figure;
plotSpikeRaster(logical(spike_trains(n,:)),'PlotType','imagesc','TimePerBin',1);
ax = 0:100:1000;
xticks(ax);
xlabel('Time (s)')

%%
coeff = [];
count = 1;
len = size(spike_trains,1);


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
coeff_av = sum(coeff)/count;



