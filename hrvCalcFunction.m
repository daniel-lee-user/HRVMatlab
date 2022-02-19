function f = hrvCalcFunction(n)
    min_peak_dist = 50; %50*128/1000 is 50 milliseconds in terms of data point indexes
    [pks, locs] = findpeaks(n,'MinPeakDistance', min_peak_dist, 'MinPeakProminence',150); 
    %[pks, locs] = findpeaks(n,'MinPeakDistance', min_peak_dist, 'MinPeakHeight',100); 
    loc_size = size(locs);
    %disp('loc_size:')
    %disp(loc_size);
    s_int= zeros(9,1);
    s_int2 = zeros(9,1);
    locs = 1000*locs/128; %convert data point indicies to milliseconds
    for q = 2:length(locs) %subtract locations to find heartbeat interval (in milliseconds) between peaks (heartbeat) 
        s_int(q-1)=locs(q)-locs(q-1);
    end
    for p = 2:length(s_int) %find differences between heartbeat intervals.
        s_int2(p-1)=s_int(p)-s_int(p-1);
    end
    s_int2 = s_int2.^2; %squares all elements in array
    f = sqrt(sum(s_int2)/length(s_int2)); %finds mean of squared array, then square root mean 
end
