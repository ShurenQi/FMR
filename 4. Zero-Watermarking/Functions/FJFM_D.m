function [ output ] = FJFM_D(img,maxorder,P,Q,alpha)
[NI, MI]  = size(img);
x       = -1+1/MI:2/MI:1-1/MI;
y       = 1-1/NI:-2/NI:-1+1/NI;
[X,Y]   = meshgrid(x,y);
[th, r]  = cart2pol(X, Y);
pz=th<0;
theta =zeros(NI,MI);
theta(pz)     = th(pz) + 2*pi;
theta(~pz)     = th(~pz);
pz=r>1;
rho =zeros(NI,MI);
rho(pz)     = 10;
rho(~pz)  = r(~pz); 
img(pz) = 0;
output=zeros(maxorder+1,2*maxorder+1);
for order=0:1:maxorder
    R=getRP_Recursive(order,rho,P,Q,alpha);
    for repetition=-maxorder:1:maxorder
        pupil =R.*exp(-1j*repetition * theta);
        Product = double(img) .* pupil;
        cnt = nnz(R)+1;
        output(order+1,repetition+maxorder+1)=sum(Product(:))*(4/cnt)*(1/(2*pi));
    end
end
end