% This program loads both the audio file and the event marker data file (xdf) 
%
% By Daniel Lee 6/24/20


clear all
stream = load_xdf('testing_evt2.xdf');
y = stream{2}.time_series(1,:);
%x = stream{2}.time_series(2,:);
timestamps = stream{1}.time_stamps;
timeseries = string(stream{1}.time_series);
L = length(timestamps);
%info = stream{2}.info
%sample_count = info.sample_count;
%runtime_sec = info.last_timestamp - info.first_timestamp;
%Frequency = int8(sample_count/runtime_sec);
Frequency = 128;
%xlim([30 120]);

%adjust the time for event markers to match the ecg data timestamps because it started 2 minutes later
adjustment = floor(1.9*60)  % 2 min in seconds

%for c = 1:L
  %  x = (timestamps(c));
   % t = text(x, -500, timeseries(c)+ timestamps(c));
   % t.FontSize = 10;
   % set(t,'Rotation',90);
%end
x = 1;
index=zeros(2,1)
for b = 1:length(stream{1}.time_stamps)
    for c = x:length(stream{2}.time_stamps)
        if(stream{2}.time_stamps(c)>=stream{1}.time_stamps(b))
            index(b) = c
            x=c+1;
            break
        end
    end
end
figure(1);
plot(y(1:length(y)));

for c = 1:L
    t = text(index(c), 0, timeseries(c)+timestamps(c));
    t.FontSize = 10;
    set(t,'Rotation',90);
end

figure(2);
subplot(2,1,1);
plot(y(1:index(1)));
subplot(2,1,2);
plot(y(index(1):length(y)));

for c = 1:L
    t = text(index(c)-index(1), 0, timeseries(c)+timestamps(c));
    t.FontSize = 10;
    set(t,'Rotation',90);
end
HRV = zeros(2,1);
sampling = 128;

[pks, bz] = findpeaks(y(1:index(1)),'MinPeakDistance', 50, 'MinPeakProminence',50);  
s_int= zeros(9,1);
s_int2 = zeros(9,1);
bz = 1000*bz/sampling;
for q = 2:length(bz) %subtract locations to find heartbeat interval (in milliseconds) between peaks (heartbeat) 
    s_int(q-1)=bz(q)-bz(q-1);
end
for p = 2:length(s_int) %find differences between heartbeat intervals.
    s_int2(p-1)=s_int(p)-s_int(p-1);
end
s_int2 = s_int2.^2; %squares all elements in array
HRV(1) = sqrt(sum(s_int2)/length(s_int2)); %finds mean of squared array, then square root mean

[pks, locs] = findpeaks(y(index(1):length(y)),'MinPeakDistance', 50, 'MinPeakProminence',50);  
s_int= zeros(9,1);
s_int2 = zeros(9,1);
bz = 1000*locs/sampling;
for q = 2:length(bz) %subtract locations to find heartbeat interval (in milliseconds) between peaks (heartbeat) 
    s_int(q-1)=bz(q)-bz(q-1);
end
for p = 2:length(s_int) %find differences between heartbeat intervals.
    s_int2(p-1)=s_int(p)-s_int(p-1);
end
s_int2 = s_int2.^2; %squares all elements in array
HRV(2) = sqrt(sum(s_int2)/length(s_int2)); %finds mean of squared array, then square root mean

figure(3);
bar(HRV) %bar plot of all HRV values