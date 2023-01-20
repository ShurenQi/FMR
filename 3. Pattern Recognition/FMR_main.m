%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This code was developed by Shuren Qi
% https://shurenqi.github.io/
% i@srqi.email / shurenqi@nuaa.edu.cn
% All rights reserved.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
close all;
clear all;
clc;
warning('off'); 
addpath(genpath(pwd));
% dbstop if error
%% METHOD
MD={'1.Polynomial FMR, FJFMR';'2.Harmonic FMR, GPCETR';};             % Fractional-order moments in Radon
for i=1:1:2, disp(MD{i}); end
MODE = input('Please select a mode (1~2): ');
K = input('Please enter the maximum order K (K>=0): ');
SZ1=129; SZ2=129; 
OBJ=100; ROT=36;
VARrange=0:0.05:0.3;
p=3; q=3;
alpha_PolynomialFMR=2;
alpha_HarmonicFMR=1.5;
%% COMPUTE
clc;
if MODE==1
    L=(K+1)*(2*K+1);
else
    L=(2*K+1)^2;
end
if MODE==1
    disp([MD{MODE},':    p=',num2str(p),', q=',num2str(q),', alpha=',num2str(alpha_PolynomialFMR),';']);
else
    disp([MD{MODE},':    alpha=',num2str(alpha_HarmonicFMR),';']);
end
disp(table([K;L],'RowNames',{'K';'L'},'VariableNames',{'Value'}));
disp('~~~~~~~~~~~~~~~~~~~~~~~~~~');
disp('CCP(%)');
UCCP=zeros(size(VARrange,2),1);
parfor idx=1:7
VAR=VARrange(idx);
% training
[r,o]=ro(SZ1,SZ2);
pz=r>1;
trainLabels =zeros(OBJ,1);
trainData=zeros(OBJ,L);
for i=1:1:OBJ
        I=imread(['Dateset\training set\',num2str(i),'\obj',num2str(i),'__0.png']);
        I=imresize(I,[SZ1,SZ2]);
        I=rgb2gray(I);
        I(pz)=0;
        trainLabels(i,1)=i;
        if MODE==1
            [X,~,~,~,~,~] = PolynomialFMR_D(double(I),K,p,q,alpha_PolynomialFMR);
            trainData(i,:)=reshape(abs(X),1,[]);
        else
            [X,~,~,~,~,~] = HarmonicFMR_D(double(I),K,alpha_HarmonicFMR);
            trainData(i,:)=reshape(abs(X),1,[]);
        end
end
% testing
testLabels =zeros(OBJ*ROT,1);
testData=zeros(OBJ*ROT,L);
for i=1:1:OBJ
    for j=0:1:ROT-1
        I=imread(['Dateset\testing set\obj',num2str(i),'__',num2str(j),'.png']);
        I=imresize(I,[SZ1,SZ2]);
        I=rgb2gray(I);
        NI=imnoise(I,'gaussian',0,VAR);
        NI(pz)=0;
        k=(i-1)*ROT+j+1;
        testLabels(k,1)=i;
        if MODE==1
            [X,~,~,~,~,~] = PolynomialFMR_D(double(NI),K,p,q,alpha_PolynomialFMR);
            testData(k,:)=reshape(abs(X),1,[]);
        else
            [X,~,~,~,~,~] = HarmonicFMR_D(double(NI),K,alpha_HarmonicFMR);
            testData(k,:)=reshape(abs(X),1,[]);
        end
    end
end
%% OUTPUT
Mdl = fitcknn(trainData,trainLabels,'NumNeighbors',1);
label = predict(Mdl,testData);
accuracy = length(find(label == testLabels))/(OBJ*ROT)*100;
UCCP(idx,1) = accuracy;
close all;
end
disp(UCCP);
