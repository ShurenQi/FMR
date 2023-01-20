function output = getmoment(TYPE,input,rho,theta,order,repetition,alpha,P,Q)
    %% 1.RHFM
if TYPE == 1
    R=getRHFM_RBF(order,rho);
    pupil =R.*exp(-1j*repetition * theta);
    Product = double(input) .* pupil;
    cnt = nnz(R)+1;
    output=sum(Product(:))*(4/cnt)*(1/(2*pi));
    %% 2.EFM
elseif TYPE == 2
    R=getEFM_RBF(order,rho);
    pupil =R.*exp(-1j*repetition * theta);
    Product = double(input) .* pupil;
    cnt = nnz(R)+1;
    output=sum(Product(:))*(4/cnt)*(1/(2*pi));
    %% 3.PCET
elseif TYPE == 3
    R=getPCET_RBF(order,rho);
    pupil =R.*exp(-1j*repetition * theta);
    Product = double(input) .* pupil;
    cnt = nnz(R)+1;
    output=sum(Product(:))*(4/cnt)*(1/(2*pi));
    %% 4.BFM
elseif TYPE == 4
    R=getBFM_RBF(order,rho,1);
    pupil =R.*exp(-1j*repetition * theta);
    Product = double(input) .* pupil;
    cnt = nnz(R)+1;
    output=sum(Product(:))*(4/cnt)*(1/(2*pi));
    %% 5.FJFM or 7.FJFMR
elseif TYPE == 5 ||  TYPE == 7
    R=getFJFM_RBF(order,rho,P,Q,alpha);
    pupil =R.*exp(-1j*repetition * theta);
    Product = double(input) .* pupil;
    cnt = nnz(R)+1;
    output=sum(Product(:))*(4/cnt)*(1/(2*pi));
    %% 6.GPCET or 8.GPCETR
elseif TYPE == 6 ||  TYPE == 8
    R=getGPCET_RBF(order,rho,alpha);
    pupil =R.*exp(-1j*repetition * theta);
    Product = double(input) .* pupil;
    cnt = nnz(R)+1;
    output=sum(Product(:))*(4/cnt)*(1/(2*pi));
end
end