string = "daniel_session_2.xdf"; %change this to change data
stream = load_xdf(string);
%y = stream{2}.time_series(1,:);
y = stream{2}.time_series;
timestamps = stream{1}.time_stamps;

[index, timeseries, split] = event_marker_with_function(string); %index is real index of ktne time_series in terms of timestamps

HRV=zeros(2,1);
rest = y(1:split(1));
HRV(1) = hrvCalcFunction(rest);
for z = 2:length(split)
    HRV(z) = hrvCalcFunction(y(split(z-1):split(z)));
end
figure(2)
bar(HRV)

figure(3)
x_axis = 1:length(y);
plot(x_axis/128, y(1:length(y)))
for c = 1:length(timeseries)
    t = text(index(c)/128, 0, timeseries(c)+timestamps(c));
    t.FontSize = 10;
    set(t,'Rotation',90);
end

% figure(2);
% subplot(2,1,1);
% plot(y(1:index(1)));
% subplot(2,1,2);
% plot(y(index(1):index(length(index))));
% 
% for c = 1:L
% 
%     t = text(index(c)-index(1), 0, timeseries(c)+timestamps(c));
%     t.FontSize = 10;
%     set(t,'Rotation',90);
% end
% 
% HRV = zeros(2,1);
% HRV(1) = hrvCalcFunction(y(1:index(1)));
% HRV(2) = hrvCalcFunction(y(index(1):index(length(index))));
% 
% figure(3);
% bar(HRV)