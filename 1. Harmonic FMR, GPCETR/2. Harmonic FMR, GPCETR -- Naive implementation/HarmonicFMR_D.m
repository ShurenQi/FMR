function [output,R,RN,TE,BE,B] = HarmonicFMR_D(img,maxorder,alpha)
[R,~] = radon(img,0:359);
[RN, RM]=size(R);
[N, ~]=size(img);
B=10;
TE=ceil((RN-N)/2)-B;
BE=ceil((RN+N)/2)+B;
R=R(TE:BE,:);
LL=BE-TE+1;
r=0+1/LL:1/LL:1;
th=(0+1/RM:1/RM:1)*2*pi;
[theta,rho]= meshgrid(th,r);
output=zeros(2*maxorder+1,2*maxorder+1);
%% Naive implementation
for order=-maxorder:1:maxorder
    RBF=sqrt(alpha*(rho.^(alpha-1))/(2*pi)).*exp(-1j*2*pi*order.*(rho.^alpha));
    for repetition=-maxorder:1:maxorder
        pupil =RBF.*exp(-1j*repetition * theta);
        Product = double(R) .* pupil;
        output(order+maxorder+1,repetition+maxorder+1)=sum(Product(:))*((2*pi)/(RM*LL));
    end
end
end
