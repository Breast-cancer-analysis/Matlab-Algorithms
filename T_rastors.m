function time_list = T_rastors(spiketrain,time_ax)
% T_rastors Takes in one spike train and outputs a raster list of
% hyperpolarisation times (in this case, 1)
%   VARIABLES:
%   spiketrain - one line of binary spike train
%   time_ax - the time axis for the spike train
%   time_list - times in s

time_list = [];

for i=1:size(spiketrain,2)
    if spiketrain(i)==1
        time_list = [time_list, time_ax(i)];
    end
end

end