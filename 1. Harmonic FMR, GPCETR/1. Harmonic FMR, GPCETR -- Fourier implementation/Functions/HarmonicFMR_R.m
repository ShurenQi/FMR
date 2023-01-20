function [output,RR] = HarmonicFMR_R(R,moments,maxorder,alpha,RNO,TE,BE,B,SZI)
[RN, RM]=size(R);
r=0+1/RN:1/RN:1;
th=(0+1/RM:1/RM:1)*2*pi;
[theta,rho]= meshgrid(th,r);
RR=zeros(RN,RM);
for i=1:1:2*maxorder+1
    order=-maxorder+i-1;
    RBF=sqrt(alpha*(rho.^(alpha-2))/(2*pi)).*exp(-1j*2*pi*order.*(rho.^alpha));      
    for j=1:1:2*maxorder+1
        repetition=-maxorder+j-1;
        moment=moments(i,j);
        pupil =conj(RBF).*exp(1j*repetition * theta);
        RR=RR+moment*pupil;
    end
end
TEMP=zeros(RNO,RM);
TEMP(TE+B:BE-B,:)=RR(B+1:end-B,:);
output = iradon(real(TEMP),0:1:359);
output = imresize(output,SZI);
end

