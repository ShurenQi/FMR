function [It,R,RR,L,DT,RT ] =PolynomialFMR(I,K,p,q,alpha)
%% PRE
[N, M]  = size(I);
x       = -1+1/M:2/M:1-1/M;
y       = 1-1/N:-2/N:-1+1/N;
[X,Y]   = meshgrid(x,y);
[~, r]  = cart2pol(X, Y);
I(r>=1)=0;
%% DE
tic;
[X,R,RN,TE,BE,B]=PolynomialFMR_D(I,K,p,q,alpha);
DT=toc;
[L,~]=size(find(X~=0));
%% RE
tic;
[Y,RR]=PolynomialFMR_R(R,X,K,p,q,alpha,RN,TE,BE,B,[N,M]);
RT=toc;
It=abs(Y);
It(r>=1)=0;
end

