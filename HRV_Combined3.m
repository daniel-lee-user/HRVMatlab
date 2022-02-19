%This file takes an xdf data file recorded from Lab Streaming Layer and
%find the heart rate variability (HRV) across multiple sections of the data
%separated by event markers.
%This file plots the ECG with Event Markers from playing the VR game
%Made by Andrew Chu 01/16/2022

clear;  
string = "2022-01-17-andrew-4-medium.xdf"; %change this to change data
sequence = ["medium"];

disp(string)

stream = load_xdf(string);
y = stream{2}.time_series(1,:);

plot(y)

timestamps = stream{1}.time_stamps;

debug_times = []; %will hold the start end end times for sequence

for s  = 1:length(sequence)
    [split] = event_marker_with_function2(string, sequence(s));
    %index is real index of ktne time_series in terms of timestamps
    %split is the array holding all the start and end times of each segment
    if(all(split))
        yRelevant = y(split(1):split(2));
        debug_times(end+1) = split(1);
        debug_times(end+1) = split(2);

        %debug_times

        disp(sequence(s))
        HRV = hrvCalcFunction(yRelevant) %calculate HRV function
        disp("**********")
    end
end
