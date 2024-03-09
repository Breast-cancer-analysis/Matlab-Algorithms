function [spike_train,time_ax] = getSpikeTrain(signal,bin_width,polarization)
%   Summary: getSpikeTrain takes in a signal matrix and outputs the spike 
%   train & time axis. It is considered a spike when its value is n_std
%   standard deviations away from 1. We only use the negative spike in this
%   case.
%   --------------------------------------------------------------------
%   bin_width in seconds
%   signal: row = signal number , column = signal array
%   polarization: 'negative' = hyperpolarisations , 
%                 'positive' = depolarisations
%   n_std = number of standard deviation
%   
%   output:
%   spike_train - int array where row is signal number and column is 1
%   or 0 at each bin
%   event - time stamp of each event

n_std = 2.3;
% Set sampled time axis in seconds
samp_t = 0.2;
time = 0:samp_t:samp_t*(length(signal)-1); % original signal is 1000s

% Define time bins
bins = 0:bin_width:max(time);

% Create binary spike train with time bins
spiketrain = zeros([size(signal,1) length(bins)]);

% negative spikes
if strcmp(polarization,'negative')
    % For each row of signals
    for n = 1:size(signal,1)
        % Set a threshold
        sd = std(signal(n,:));
        threshold = 1-n_std*sd;
    
        % Identify spikes in each time bin
        for i = 1:length(bins)
            bin_start = bins(i);
            bin_end = bin_start + bin_width;
            
            over_threshold = sum(signal(n, time >= bin_start & time < bin_end) < threshold, 2);
            p = over_threshold/numel(time(time >= bin_start & time < bin_end));
    
            % Check if any signal values in the current time bin exceed the threshold
            if p>0.5
                spiketrain(n,i) = 1;
            end
        end
    end
% positive spikes
elseif strcmp(polarization,'positive')
    % For each row of signals
    for n = 1:size(signal,1)
        % Set a threshold
        sd = std(signal(n,:));
        threshold = 1+n_std*sd;
    
        % Identify spikes in each time bin
        for i = 1:length(bins)
            bin_start = bins(i);
            bin_end = bin_start + bin_width;
            
            over_threshold = sum(signal(n, time >= bin_start & time < bin_end) > threshold, 2);
            p = over_threshold/numel(time(time >= bin_start & time < bin_end));
    
            % Check if any signal values in the current time bin exceed the threshold
            if p>0.5
                spiketrain(n,i) = 1;
            end
        end
    end 
else
    error(['input must be either positive or negative, not ',polarization])
end

% events = event_times;
spike_train = spiketrain;
time_ax = bins;
end

