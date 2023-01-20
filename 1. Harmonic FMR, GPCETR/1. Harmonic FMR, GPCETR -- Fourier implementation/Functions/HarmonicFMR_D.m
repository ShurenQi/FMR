function [output,R,RN,TE,BE,B] = HarmonicFMR_D(img,maxorder,alpha)
[R,~] = radon(img,0:1:359);
[RN, RM]=size(R);
[N, ~]=size(img);
B=10;
TE=ceil((RN-N)/2)-B;
BE=ceil((RN+N)/2)+B;
R=R(TE:BE,:);
LL=BE-TE+1;
r=0+1/LL:1/LL:1;
th=(0+1/RM:1/RM:1)*2*pi;
%% Fourier implementation
M = 4*N;
G = zeros(M,M);
for u = 1:M
    for v = 1:M
        rho = ((u-1)/M)^(1/alpha);
        theta = (2*pi*(v-1))/M;
        [~,k]=min(abs(r-rho));
        [~,l]=min(abs(theta-th));
        G(u,v) = R(k(1),l(1))*sqrt(((u/M)^(2/alpha-1))/(2*pi*alpha));
    end
end
TEMP = fft2(G);
TEMP = 2*pi*TEMP/(M^2);
K = maxorder;
output = zeros(2*K+1,2*K+1);
output(1:K,1:K) = TEMP(M-K+1:M,M-K+1:M);
output(1:K,K+1:2*K+1) = TEMP(M-K+1:M,1:K+1);
output(K+1:2*K+1,1:K) = TEMP(1:K+1,M-K+1:M);
output(K+1:2*K+1,K+1:2*K+1) = TEMP(1:K+1,1:K+1);
end

