function y = direct_fourier(x , fs)

h = zeros(size(x));
n = 1;

for q = 1:fs
    for k=1:fs
        h(n) = h(n) + x(k)*exp(-2*pi*j*k*n/(fs));
    end
    n = n+1;
end;

y = h;