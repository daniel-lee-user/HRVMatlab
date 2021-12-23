stream = load_xdf("ECG_with_audio.xdf");
y = stream{2}.time_series(1,:);
event_timestamps = stream{1}.time_stamps;
event_markers = string(stream{1}.time_series);
event_length = length(event_timestamps);
    %disp(size(event_index));
    % if data timestamp is smaller than the last event timestamp, let the
    % event index to be the end of data index
    %if (data_timestamps(data_length)<event_timestamps(event_length))
       % event_index(event_length) = data_length;
    x = 1;  % index of the data timestamp array
    event_index=zeros(2,1);  % event index that keeps track of the position of event markers with respect to the data array
    data_timestamps = stream{2}.time_stamps;
    data_length = length(data_timestamps);
    %disp(data_length);
    for b = 1:event_length
        for c = x:data_length
            if(data_timestamps(c)>=event_timestamps(b))
                event_index(b) = c;
                %disp(b);
                %disp(c);
                %disp(c,data_timestamps(c),b,event_timestamps(b))
                %disp(event_index(b));
                x=c+1;  
                break
            end
        end
    end
figure(1);
subplot(2,1,1);
x_axis = 1:length(y);
plot(x_axis/128, y(1:length(y)))
    for c = 1:event_length
            t = text(event_index(c)/128, 0, event_markers(c)+event_timestamps(c));
            t.FontSize = 10;
            set(t,'Rotation',90);
    end
clear z Fs
subplot(2,1,2);
[z,Fs] = audioread('ECG_Audio_File.m4a');
info = audioinfo('ECG_Audio_File.m4a');
t = 0:seconds(1/Fs):seconds(info.Duration);
t = t(1:end);
plot(t,z)
xlabel('Time')
ylabel('Audio Signal')


figure(2);
subplot(2,1,1);
x_axis = 35*128:length(y);
plot(x_axis/128, y(35*128:length(y)))
    for c = 1:event_length
            t = text(event_index(c)/128, 0, event_markers(c)+event_timestamps(c));
            t.FontSize = 10;
            set(t,'Rotation',90);
    end
clear z Fs
subplot(2,1,2);
[x,Fs] = audioread('ECG_Audio_File.m4a');
[M,N] = size(x);
dt = 1/Fs;
t = dt*(0:M-1)';
idx = (t>35)  ;
plot(t(idx),x(idx));
xlabel('Time')
ylabel('Audio Signal')