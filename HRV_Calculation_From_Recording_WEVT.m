%This file takes an xdf data file recorded from Lab Streaming Layer and
%find the heart rate variability (HRV) across multiple sections of the data
%separated by event markers.
%This file plots the ECG with Event Markers from playing the VR game
%Made by Daniel Lee 8/1/2020

string = "4_sessions_dan2.xdf"; %change this to change data
stream = load_xdf(string);
y = stream{2}.time_series(1,:);
timestamps = stream{1}.time_stamps;

[index, timeseries, split] = event_marker_with_function(string);
%index is real index of ktne time_series in terms of timestamps
%split is the array holding all the start and end times of each segment

rest = y(1:split(1));
HRV = zeros(2,1);
HRV(1) = hrvCalcFunction(rest); %calculate HRV function
for z = 2:length(split)
    HRV(z) = hrvCalcFunction(y(split(z-1):split(z))); %calculate HRV function
end
figure(2)
bar(HRV) %graph HRV as bar plot

figure(3) %graph entire data set with event markers, x axis is in seconds
x_axis = 1:length(y);
plot(x_axis/128, y(1:length(y)))
for c = 1:length(timeseries)
    if(contains(timeseries(c),"2 min") || contains(timeseries(c),"20 sec"))
        t = text(index(c)/128, 0, timeseries(c)+timestamps(c));
        t.FontSize = 10;
        set(t,'Rotation',90);
    end
end