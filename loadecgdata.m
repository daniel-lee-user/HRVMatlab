% This program loads both the audio file and the event marker data file (xdf) 
%
% By Daniel Lee 6/24/20


clear all
%stream1 = load_xdf('first_experiment.xdf');
stream2 = load_xdf('second_experiment.xdf');
%x1 = stream1{2}.time_series;
x2 = stream2{2}.time_series;
timestamps = stream2{1}.time_stamps;
timeseries = string(stream2{1}.time_series);
L = length(timestamps);

%xlim([30 120]);

plot(x2);
%ax1 = gca;
%ax1_pos = ax1.Position; % position of first axes
%ax2 = axes('Position',ax1_pos,...
%    'XAxisLocation','top',...
%    'YAxisLocation','right',...
%    'Color','none');
%figure(2);
for c = 1:L    
    x=timestamps(c)*128;
    % draw the virtical line at x position
    %line([x,x], [1.5, -1.5]);
    %line([x,x], [1.5, -1.5], 'Parent',ax2,'Color','k')
    %line([timestamps(c), timestamps(c)], [1.5, -1.5], 'Parent',ax2,'Color','k')
    %t = text(timestamps(c)-1, 0.5, timeseries(c)+ timestamps(c));
    %t.FontSize = 15;
    t = text(x-10, 0.5, timeseries(c)+ timestamps(c));
    t.FontSize = 10;
    set(t,'Rotation',90);
end
