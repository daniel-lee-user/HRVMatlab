%This file takes an xdf data file recorded from Lab Streaming Layer and
%find the heart rate variability (HRV) across multiple sections of the data
%separated by event markers.
%This file plots the ECG with Event Markers from playing the VR game
%Made by Daniel Lee 8/1/2020

clear;
string = "old_hp_dan1.xdf"; %change this to change data
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
resting = HRV(1:2:end);
avR = sum(resting)/length(resting);

two_min = {HRV(2), HRV(length(HRV))};
two_min = cell2mat(two_min);
tw_sec = {HRV(4), HRV(6)};
tw_sec = cell2mat(tw_sec);
avM = sum(two_min)/length(two_min);
avS = sum(tw_sec)/length(tw_sec);

f_HRV = cell2mat({avR, avM, avS});
errB = cell2mat({(max(resting)-min(resting))/2, (max(two_min)-min(two_min))/2, (max(tw_sec)-min(tw_sec))/2});

bar(f_HRV) %graph HRV as bar plot
hold on

er = errorbar(f_HRV, errB);
er.Color = [0 0 0];                            
er.LineStyle = 'none';  

hold off

z1 = zeros(2,1);
z2 = zeros(2,1);
z3 = zeros(2,1);

[z1(1),z1(2)] = calcPScore(avM, two_min, avS, tw_sec);
[z2(1),z2(2)] = calcPScore(avM, two_min, avR, resting);
[z3(1),z3(2)] = calcPScore(avS, tw_sec, avR, resting);
disp(z1);
disp(z2);
disp(z3);

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