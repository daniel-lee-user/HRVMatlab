function [t, f] = calcPScore(avg, set, avg2, set2)
    s1 = sqrt(sum((set-avg).^2)/(length(set)-1));
    s2 = sqrt(sum((set2-avg2).^2)/(length(set2)-1));
    stdE = sqrt(s1/length(set)+s2/length(set2));
    t = abs(avg-avg2)/stdE;
    f = length(set)+length(set2)-2;
end