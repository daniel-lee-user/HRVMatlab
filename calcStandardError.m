function [st] = calcStandardError(avg, set)
    s1 = sqrt(sum((set-avg).^2)/(length(set)-1));
    st = s1/sqrt(length(set));
end
