function [crosscorr,lags] = populatn_xcorr(spike_train)
len = size(spike_train,1);
%com = factorial(len)/(2*factorial(len-2));
populatn = [];
count = 1;

for i = 1:len - 1
    for j = i+1:len
        corr_func = xcorr(spike_train(i,:),spike_train(j,:),'unbiased');
        populatn(count,:) = corr_func;
        count = count +1;
    end
end
crosscorr = sum(populatn,1)/count;
lags = -(size(spike_train,2)-1):(size(spike_train,2)-1);
end