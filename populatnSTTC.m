clear
clc
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

filename = 'MCF10A';
% th_val = 0.007;

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
    % Num = M(2:end,1);
    M = M(2:end,4:end);

    len = size(M,1);

    % variables setup
    coeff1 = [];
    coeff5 = [];
    coeff10 = [];
    % cell1 = [];
    % cell2 = [];

    % count = 1;
    [spike_trains,bins,th] = getSpikeTrain(M,1,'negative',0);
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
             
            % cell1 = [cell1, Num(i)];
            % cell2 = [cell2, Num(j)];
            % count = count +1;
            %disp([num2str(count),': ',num2str(coeff)])
        end
    end
    %------------------------------------%
    % save individually for each FOV %
    FOV_coeff(n).filename = myFiles(n).name;
    % FOV_coeff(n).first_cell = cell1;
    % FOV_coeff(n).secnd_cell = cell2;
    FOV_coeff(n).STTC_plusminus1 = coeff1;
    FOV_coeff(n).STTC_plusminus5 = coeff5;
    FOV_coeff(n).STTC_plusminus10 = coeff10;
    % FOV_coeff(n).sd1 = std(coeff1);
    % FOV_coeff(n).sd5 = std(coeff5);
    % FOV_coeff(n).sd10 = std(coeff10);
    %------------------------------------%

    % STTC = [STTC,coeff1];
    disp(['FOV ',num2str(n)])
end

%%
% F = fieldnames(FOV_coeff);
% indexes = [];
% for f = 1:length(F)
%     indexes = cat(1,indexes,mean(FOV_coeff.(F{f})));
% end

%%
% figure;
% histogram(STTC, 'Normalization','probability','NumBins',20)
% title([filename,' with population average=',num2str(mean(STTC))])
% xlim([-1 1])
% xlabel("STTC coeff")
% ylabel("Probability Density")
% 
% figure;
% swarmchart(ones(1,length(STTC)),STTC,3,'filled','MarkerEdgeColor',"#0072BD",'MarkerFaceColor',"#0072BD")





