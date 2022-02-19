function [z,a,d] = event_marker_with_function(e)
    stream = load_xdf(e);
    y = stream{2}.time_series(1,:);
    event_timestamps = stream{1}.time_stamps;
    event_markers = string(stream{1}.time_series);
    a = event_markers;
    event_length = length(event_timestamps);

    % find the index of the data timestamp where the event marker's
    % timestamps match to place the event marker into the correct data position
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

    %disp(size(event_index));
    % if data timestamp is smaller than the last event timestamp, let the
    % event index to be the end of data index
    %if (data_timestamps(data_length)<event_timestamps(event_length))
       % event_index(event_length) = data_length;
        
    figure(1);
    plot(y);

    for c = 1:event_length
        if(contains(event_markers(c),"2 min") || contains(event_markers(c),"20 sec"))
            t = text(event_index(c), 0, event_markers(c)+event_timestamps(c));
            t.FontSize = 10;
            set(t,'Rotation',90);
        end
    end
    z = event_index;
    split = zeros(2,1); %split is the array holding all the start and end times of each segment
    i = 1; %counter
    for c = 1:length(event_markers) %finds all the start and end times of segments
        if(contains(event_markers(c),"2 min") || contains(event_markers(c),"20 sec"))
            split(i) = event_index(c);
            i = i +1;
        end
    end
    d = split;
end