function sttc_index = calcSTTC(dt, Time, spike_times_1, spike_times_2)
% Takes in spike times (not binary spike train)
% dt - time window size
% Time - start and end times [start, end]
% spike_times_1 - spike train (rastor) A
% spike_times_2 - spike train (rastor) B

    N1 = length(spike_times_1);
    N2 = length(spike_times_2);
    if (N1~=0 && N2~=0)
        TA = run_T(N1, dt, Time(1), Time(2), spike_times_1);
        TA = TA / (Time(2) - Time(1));
        TB = run_T(N2, dt, Time(1), Time(2), spike_times_2);
        TB = TB / (Time(2) - Time(1));
        PA = run_P(N1, N2, dt, spike_times_1, spike_times_2);
        PA = PA / N1;
        PB = run_P(N2, N1, dt, spike_times_2, spike_times_1);
        PB = PB / N2;
    elseif (N1==0 || N2==0)
        TA = 0;
        TB = 0;
        PA = 0;
        PB = 0;
    end
    
    sttc_index = 0.5 * (PA - TB) / (1 - TB * PA) + 0.5 * (PB - TA) / (1 - TA * PB);
end


function getP = run_P(N1, N2, dt, spike_times_1, spike_times_2)
    getP = 0;
    j = 1;
    
    for i = 1:N1
        while j <= N2
            if abs(spike_times_1(i) - spike_times_2(j)) <= dt
                getP = getP + 1;
                break;
            elseif spike_times_2(j) > spike_times_1(i)
                break;
            else
                j = j + 1;
            end
        end
    end
end


function getT = run_T(N1, dt, start, ending, spike_times_1)
    getT = 2 * N1 * dt;
    
    if (N1==1)
        if (spike_times_1(1)) < dt
            getT = getT - start + spike_times_1(1) - dt;
        elseif (spike_times_1(1) + dt) > ending
            getT = getT - spike_times_1(1) - dt + ending;
        end
    else
        i = 1;
        while i < (N1 - 1)
            diff = spike_times_1(i + 1) - spike_times_1(i);
            
            if diff < 2 * dt
                getT = getT - 2 * dt + diff;
            end
            
            i = i + 1;
        end
        
        if (spike_times_1(1) - start) < dt
            getT = getT - start + spike_times_1(1) - dt;
        end
        
        if (ending - spike_times_1(N1)) < dt
            getT = getT - spike_times_1(N1) - dt + ending;
        end
    end
end

