function dy = kuramoto_eq(d, y, K, N, omega)

%wn = wgn(1,N,0);           % white noise
alpha = 0;                  % frustration parameter
wn = zeros(N,1);
dy = zeros(N,1); 

for i = 1:N
    dy(i) = omega(i) + wn(i) + K/N*sum(sin(y-y(i)-alpha));
end

end

