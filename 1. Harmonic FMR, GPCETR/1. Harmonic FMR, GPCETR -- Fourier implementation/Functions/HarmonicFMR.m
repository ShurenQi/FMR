function [RI,R,RR,L,DT,RT ] =HarmonicFMR(I,K,alpha)
%% PRE
[N, M]  = size(I);
x       = -1+1/M:2/M:1-1/M;
y       = 1-1/N:-2/N:-1+1/N;
[X,Y]   = meshgrid(x,y);
[~, r]  = cart2pol(X, Y);
I(r>=1)=0;
%% DE
tic;
[X,R,RN,TE,BE,B]=HarmonicFMR_D(I,K,alpha);
DT=toc;
[L,~]=size(find(X~=0));
%% RE
tic;
[Y,RR]=HarmonicFMR_R(R,X,K,alpha,RN,TE,BE,B,[N,M]);
RT=toc;
RI=abs(Y);
RI(r>=1)=0;
end

