function y = FindSignalStart(x)

threshold = (max(x)/2);
y = find(x>threshold,1);