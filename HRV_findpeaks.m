%made by Daniel Lee
%finds HRV values for each minute

clear all
stream = load_xdf('second_experiment.xdf'); %load experiment data
x = stream{2}.time_series;
L = length(x); %length of experiment
sampling = 128;  %128 is sampling frequency, change it as needed
one_min = sampling*60; %1 minute
ten_min = one_min*10; %10 minutes
x_10 = x(1:ten_min); %10 minute data
x_10_mat = reshape(x_10,[one_min,10]); %split into matrix
threshold = 30; %100 is threshold for peak, change if necessary
%plot(x)

%hold on
%plot(x,'ro')

HRV = zeros(10,1);
%hold off
for b = 1:10
    [pks, locs] = findpeaks(x_10_mat(:,b),'MinPeakDistance', 50, 'MinPeakProminence',50);  
    s_int= zeros(9,1);
    s_int2 = zeros(9,1);
    locs = 1000*locs/sampling;
    for q = 2:length(locs) %subtract locations to find heartbeat interval (in milliseconds) between peaks (heartbeat) 
        s_int(q-1)=locs(q)-locs(q-1);
    end
    for p = 2:length(s_int) %find differences between heartbeat intervals.
        s_int2(p-1)=s_int(p)-s_int(p-1);
    end
    s_int2 = s_int2.^2; %squares all elements in array
    HRV(b) = sqrt(sum(s_int2)/length(s_int2)); %finds mean of squared array, then square root mean
end

figure(1);
bar(HRV) %bar plot of all HRV values
figure(2);
for z = 1:10 
    subplot(10,1,z)
    plot(x_10_mat(:,z)) %plots all minute ecg data
end

