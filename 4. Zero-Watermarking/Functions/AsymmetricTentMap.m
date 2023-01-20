function [map]=AsymmetricTentMap(N,x0,mu)
map=zeros(1,N);
for k=1:1:N
    if x0<=mu
        x0=x0/mu;
    else
        x0=(1-x0)/(1-mu);
    end
    map(k)=x0;
end
end