function y = FindSignalEnd(x)

threshold = (max(x)/2);
y = find(x>threshold,1, 'last');