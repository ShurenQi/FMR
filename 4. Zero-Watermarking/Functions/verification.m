function [VW,VT]=verification(I,ZW,K,K1,K2,K3,TYPE)
tic;

I=rgb2gray(I);
[IN,IM]=size(I);
[SZ2,~]=size(ZW);

NoIT1=K1(1);a1=K1(2);b1=K1(3);
NoIT2=K2(1);a2=K2(2);b2=K2(3);
N=SZ2;x0=K3(1);mu=K3(2);

mapN=AsymmetricTentMap(N*N,x0,mu);
mapM=AsymmetricTentMap(N*N,mapN(end),mu);
mapAlpha=AsymmetricTentMap(N*N,mapM(end),mu);
mapP=AsymmetricTentMap(N*N,mapAlpha(end),mu);
mapQ=AsymmetricTentMap(N*N,mapP(end),mu);
mapN=round(mapN.*(K-1)); 
mapM=round(mapM.*(K-1)); 
mapAlpha=0.5+mapAlpha*2;
mapP=mapP.*5+1;mapQ=mapQ.*5+1;dif=mapP-mapQ; pz=dif<0;
temp=mapP(pz);mapP(pz)=mapQ(pz);mapQ(pz)=temp;

if TYPE~=7 && TYPE~=8
    x = -1+1/IM:2/IM:1-1/IM; y = 1-1/IN:-2/IN:-1+1/IN;
    [X,Y] = meshgrid(x,y); [th, r] = cart2pol(X, Y);
    pz=th<0; theta =zeros(IN,IM); theta(pz) = th(pz) + 2*pi; theta(~pz) = th(~pz);
    pz=r>1; rho =zeros(IN,IM); rho(pz) = 10; rho(~pz) = r(~pz); I(pz) = 0;
else
    x = -1+1/IM:2/IM:1-1/IM; y = 1-1/IN:-2/IN:-1+1/IN;
    [X,Y] = meshgrid(x,y); [~,rid] = cart2pol(X, Y);
    pz=rid>1; I(pz) = 0;
    [R,~] = radon(I,0:359);
    [RN, RM]=size(R);
    TE=ceil((RN-IN)/2)-10;
    BE=ceil((RN+IN)/2)+10;
    R=R(TE:BE,:);
    LL=BE-TE+1;
    r=0+1/LL:1/LL:1;
    th=(0+1/RM:1/RM:1)*2*pi;
    [theta,rho]= meshgrid(th,r);
end


if TYPE~=7 && TYPE~=8
    Moment=zeros(N,N);
    parfor i=1:N
        for j=1:N
            k=(i-1)*N+j;
            Moment(i,j)=getmoment(TYPE,I,rho,theta,mapN(k),mapM(k),mapAlpha(k),mapP(k),mapQ(k));
        end
    end
else
    Moment=zeros(N,N);
    parfor i=1:N
        for j=1:N
            k=(i-1)*N+j;
            Moment(i,j)=getmoment(TYPE,R,rho,theta,mapN(k),mapM(k),mapAlpha(k),mapP(k),mapQ(k));
        end
    end
end

B=abs(Moment);
melevel=median(B(:));
B=B>melevel;
ZW=logical(ZW);
B=logical(B);
[map]=AsymmetricTentMap(N,x0,mu);
map=uint8(floor(map.*SZ2));
for i=2:1:SZ2
    if mod(i,3)==2
        temp=zeros(1,SZ2);
        temp(1:end-map(i))=B(i,map(i)+1:end);
        B(i,:)=temp;
    elseif mod(i,3)==0
        temp=zeros(1,SZ2);
        temp(end-map(i):end)=B(i,1:map(i)+1);
        B(i,:)=temp;
    elseif mod(i,3)==1 
        temp=circshift(B(i,:)',map(i));
        B(i,:)=temp';
    else
        return;
    end
end
BS = Arnold_Scrambling(B,a2,b2,NoIT2);
VWS=xor(BS,ZW);
VW=Arnold_Recovery(VWS,a1,b1,NoIT1);
VT=toc;
end

