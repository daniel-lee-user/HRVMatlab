function [h, b, z] =  calcHeartRate(n)
    min_peak_dist = 50; %50*128/1000 is 50 milliseconds in terms of data point indexes
    [pks, locs] = findpeaks(n,'MinPeakDistance', min_peak_dist, 'MinPeakProminence',150); 
    %[pks, locs] = findpeaks(n,'MinPeakDistance', min_peak_dist,
    %'MinPeakHeight',100; 
    x = length(pks);
    b = x;
    dist = locs(length(locs)) - locs(1);
    z = dist/128;
    h = 60*x/(dist/128);
end