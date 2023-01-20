function [ output,R,RN,TE,BE,B] = PolynomialFMR_D(img,maxorder,p,q,alpha)
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
output=zeros(maxorder+1,2*maxorder+1);
for order=0:1:maxorder
    RBF=PolynomialRBF(order,rho,p,q,alpha);
    for repetition=-maxorder:1:maxorder
        pupil =RBF.*exp(-1j*repetition * theta).*rho;
        Product = double(R) .* pupil;
        output(order+1,repetition+maxorder+1)=(order+1)*sum(Product(:))/(RM*LL);
    end
end
end
