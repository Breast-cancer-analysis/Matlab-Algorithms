function [time_lags] = getTimeLags(spike_trains, time_bin)
%   Summary: getTimeLags takes in a spike_train and outputs a
%   vector of time difference between each negative spike for the whole
%   signal
%   --------------------------------------------------------------------
%   spike_train - binary matrix (signal each row)
%   time_bin - actual time in seconds per bin
%   time_lags - vector (unit: seconds)

L = size(spike_trains,2);
lags = [];
for i=1:size(spike_trains,1)
    n = 1;
    start = 0;
    stop = 0;
    while n < L
        if (spike_trains(i,n)==1) && n>1 && (start~=0)
            if (spike_trains(i,n-1)==0)
                stop = n;
                lags = [lags, (stop-start)];
            end
        end
        if (spike_trains(i,n)==1) && (spike_trains(i,n+1)==0)
            start = n;
        end
        n=n+1;
    end
end

time_lags = lags*time_bin;
end