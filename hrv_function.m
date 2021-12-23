% This program loads both the audio file and the event marker data file (xdf) 
% 
% By Daniel Lee 7/4/20


clear all
%stream1 = load_xdf('first_experiment.xdf');
stream2 = load_xdf('second_experiment.xdf');
%x1 = stream1{2}.time_series;
x2 = stream2{2}.time_series;
timestamps = stream2{1}.time_stamps;
timeseries = string(stream2{1}.time_series);
L = length(timestamps);

%xlim([30 120]);

%figure(1);
%plot(x2);

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

%figure(2);
%findpeaks(x2);

var = calculate_ECG_features(x2);
disp(var);

%pks = findpeaks(x2);


function [HRV] = calculate_ECG_features(ECG)

    %sampling_rate = 256;
     
    %disp(ECG(1:100));
    %ECG = tsmovavg(ECG,'s',sampling_rate/4,2);
    %disp(ECG(1:100));
    figure(1);
    plot(ECG);
    
    %ECG = tsmovavg(ECG,'s',sampling_rate/4,2);
   % ECG = mat2gray(ECG);
%     figure, findpeaks(ECG(2001:4560),'MinPeakDistance',sampling_rate/2)
%     pause
    
    %sampling_rate = 256;
    sampling_rate = 128;
    
    
    [pks, locs] = findpeaks(ECG,'MinPeakDistance', sampling_rate/2);
    figure(2);
    plot(pks);
    disp(locs);
    
    %[pks, locs] = findpeaks(ECG,'MinPeakDistance', sampling_rate/4);
    %[pks, locs] = findpeaks(ECG,'MinPeakDistance', sampling_rate/2);
    %figure(3);
    %plot(pks);
    %disp(locs);
    
    %locs = floor(locs/4);
    %disp(locs);
    diff_locs = diff(locs);
    disp(diff_locs);
    mean_diff = mean(diff_locs);  % find the mean of peak intervals
    disp(mean_diff);
    
    % set the percentage of allowed variances to 5% of the mean?  5% error
    % allowed?
    allowed_error = round(mean_diff * 5/100); % allow + or - 5% error of the mean value
    
    hrv_val = 0;
        
    for i = 1:length(diff_locs)
       if (diff_locs(i) > mean_diff + allowed_error) || (diff_locs(i) < mean_diff - allowed_error)
           hrv_val = hrv_val + 1;  % count the number of outliers (out of bound peak intervals)
       end
    end
    %for i = 1:length(diff_locs)
    %   if diff_locs(i) >= 50
    %       hrv_val = hrv_val + 1;
    %   end
    %end
    
    disp(allowed_error);
    disp(hrv_val);
    
    HRV = (hrv_val * 100) / length(diff_locs);  % percentage of hrv_val outliers 

end