function y = NormalizeSignal(x)

x = x - mean(x);   % Remove DC Bias

y = x/max(abs(x)); % This should work in theory. 
                   % Guarantees less than 1, at least.