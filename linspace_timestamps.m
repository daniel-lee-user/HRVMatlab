x = load_xdf("session_1_timmy.xdf");
timestamps = x{2}.time_series(2,:);
L = length(timestamps);
ls = zeros(2,1);
for i=1:9:L
  var = x{2}.time_series(2,1:i);
  ls = linspace(min(var),max(var),9);
end
disp(ls)

%x = load_xdf("session_1_timmy.xdf");
%timestamps = x{2}.time_series(2,:);
%L = length(timestamps);
%ls = zeros{2,1};
%c = 1;
%for i=9:9:L
%  var = x{2}.time_series(2,i-8:i);
 % ls = [ls, linspace(min(var),max(var),9)];
  %celldisp(ls(c))
  %c = c+1;
%end
