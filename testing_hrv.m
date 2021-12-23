clear all
stream = load_xdf('first_experiment.xdf');
x = stream{2}.time_series;
h = x(1:7680)
h_f = fft(h)
p2 = abs(h_f/1000)
plot(h)

hold on
plot(h,'ro')
i = 0;
interval = zeros(10,1);
s_int= zeros(9,1);
HRV =0;
hold off

for k = 2:length(h)
    if(h(k)<h(k-1) && h(k)<h(k+1) && h(k)<-2500)
        i = i+1;
        interval(i) = k/128;
        disp("peak found");
        disp(interval(i));
    end
end

for q = 2:length(interval) 
    s_int(q-1)=interval(q)-interval(q-1);
end
s_int2 = s_int.^2;
HRV = sqrt(sum(s_int2)/length(s_int2))