function spike_num = getNumSpikes(spike_trains)
%   getNumSpikes takes in a binary (1 or 0) spike train and outputs the 
%   number of spikes per cell / line of signal
%   -----------------------------------------------------------------------
%   spike_trains: matrix where row = signal number , column = signal array
%   spike_num: vector array (spikes per signal)
spike_num = zeros(1,size(spike_trains,1));

for n = 1:size(spike_trains,1)
    count = 0;
    prev_n = 0;

    for m = 1:size(spike_trains,2)
        if (prev_n==0) && (spike_trains(n,m)==1)
            count = count+1;
        end
        prev_n = spike_trains(n,m);
    end
    spike_num(n) = count;
end

end