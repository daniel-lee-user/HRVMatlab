function [d] = event_marker_with_function2(e, level)

    disp(level)

    stream = load_xdf(e);
    
    %heartypatch data
    y = stream{2}.time_series(1,:);
    data_timestamps = stream{2}.time_stamps;
    data_length = length(data_timestamps);
    %disp(data_length);

    %eventmarkers
    event_timestamps = stream{1}.time_stamps; %numbers/time e.g. 1.9145
    event_markers = string(stream{1}.time_series); %text markers e.g. "piano key D Sharp"
    event_length = length(event_timestamps);
    %disp(event_markers)
        
    % find the index of the data timestamp where the event marker's
    % timestamps match to place the event marker into the correct data position
    event_index=zeros(2,1);  % event index that keeps track of the position of event markers with respect to the data array

    x = 1;  % index of the data timestamp array
    for b = 1:event_length
        for c = x:data_length % c is actual time
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
        
    %figure(1);
    %plot(y);

    %disp(event_index)

    split = zeros(2,1); %split is the array holding all the start and end times of each segment
    for c = 1:length(event_markers) %finds all the start and end times of segments
        if(contains(event_markers(c),strcat(level," starts")))
            split(1) = event_index(c);
        end
        if(contains(event_markers(c),strcat(level," ends")))
            split(2) = event_index(c);
        end
    end
    d = split;

    split

end
