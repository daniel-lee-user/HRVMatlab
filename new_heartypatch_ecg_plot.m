% This program loads both the audio file and the event marker data file (xdf) 
%
% By Daniel Lee 6/24/20


clear all
stream = load_xdf('session_1_timmy.xdf');
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
plot(y);

%adjust the time for event markers to match the ecg data timestamps because it started 2 minutes later
adjustment = floor(1.9*60)  % 2 min in seconds

for c = 1:L
    x = (timestamps(c)-adjustment)*Frequency;
    t = text(x-10, -500, timeseries(c)+ timestamps(c));
    t.FontSize = 10;
    set(t,'Rotation',90);
end

