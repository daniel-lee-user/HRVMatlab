% This program loads both the audio file and the event marker data file (xdf) 
%
% By Daniel Lee 2/23/20


clear all
stream = load_xdf('test2.xdf');
sp = audioread('Recording.m4a');
timestamps = stream{1}.time_stamps;
timeseries = string(stream{1}.time_series);

L = length(timestamps);
xlim([30 120])
plot(sp);
ax1 = gca;
ax1_pos = ax1.Position; % position of first axes
ax2 = axes('Position',ax1_pos,...
    'XAxisLocation','top',...
    'YAxisLocation','right',...
    'Color','none');
for c = 1:L
    line([timestamps(c), timestamps(c)], [1.5, -1.5], 'Parent',ax2,'Color','k')
    t = text(timestamps(c)-1, 0.5, timeseries(c));
    t.FontSize = 15;
    set(t,'Rotation',90);
end
