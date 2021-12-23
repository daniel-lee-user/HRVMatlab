%This file takes an xdf data file recorded from Lab Streaming Layer and
%find the heart rate variability (HRV) across multiple sections of the data
%separated by event markers.
%This file plots the ECG with Event Markers from playing the VR game
%Made by Daniel Lee 8/1/2020

clear;  
string = "4_sessions_dan2.xdf"; %change this to change data
stream = load_xdf(string);
y = stream{2}.time_series(1,:);
timestamps = stream{1}.time_stamps;

[index, timeseries, split] = event_marker_with_function(string);
%index is real index of ktne time_series in terms of timestamps
%split is the array holding all the start and end times of each segment

rest = y(1:split(1));
HR = zeros(2,1);
HR(1) = calcHeartRate(rest); %calculate HRV function
for z = 2:length(split)
    HR(z) = calcHeartRate(y(split(z-1):split(z))); %calculate HRV function
end

resting = HR(1:2:end);

two_min = {HR(2), HR(8), HR(12),HR(14)};
two_min = cell2mat(two_min);
tw_sec = {HR(4), HR(6), HR(10), HR(16)};
tw_sec = cell2mat(tw_sec);

string = "4_sessions_tim1.xdf"; %change this to change data
stream = load_xdf(string);
y = stream{2}.time_series(1,:);
timestamps = stream{1}.time_stamps;

[index, timeseries, split] = event_marker_with_function(string);
%index is real index of ktne time_series in terms of timestamps
%split is the array holding all the start and end times of each segment

rest = y(1:split(1));
HR3 = zeros(2,1);
[HR3(1), p, q] = calcHeartRate(rest); %calculate HRV function
for z = 2:length(split)
    HR3(z) = calcHeartRate(y(split(z-1):split(z))); %calculate HRV function
end

resting2 = HR3(1:2:end);
resting = [resting resting2];
resting = reshape(resting,1,16,[]);
avR = sum(resting)/length(resting);

two_min = [two_min {HR3(2), HR3(8), HR3(12),HR3(14)}];
two_min = cell2mat(two_min);
%tw_sec = {HRV(4), HRV(6), HRV(10), HRV(16)};
tw_sec = [tw_sec  {HR3(4), HR3(6), HR3(10)}];
tw_sec = cell2mat(tw_sec);
avM = sum(two_min)/length(two_min);
avS = sum(tw_sec)/length(tw_sec);

f_HR = cell2mat({avR, avM, avS});
%errB = cell2mat({(max(resting)-min(resting))/2, (max(two_min)-min(two_min))/2, (max(tw_sec)-min(tw_sec))/2});
errB3  = cell2mat({calcStandardError(avR, resting), calcStandardError(avM, two_min),calcStandardError(avS, tw_sec)});
figure(1)

bar(f_HR)
hold on

er2 = errorbar(f_HR, errB3);
%er2.Marker = '*';
%er2.MarkerSize = 20;
er2.Color = 'red';
er2.CapSize = 50;
er2.LineStyle = 'none';  

hold off

figure(2)

bar(HR);

%{
s1 = (sum(two_min-avM)).^2/(length(two_min)-1);
s2 = (sum(tw_sec-avS)).^2/(length(tw_sec)-1);
stdE = sqrt(s1/length(two_min)+s2/length(tw_sec));
t1 = (avM-avS)/stdE;
f1 = length(two_min)+length(tw_sec)-2;
%}
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