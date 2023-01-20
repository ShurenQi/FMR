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
%% INPUT (Nosie)
VAR=0.1;
I=imread('jacobi.tif');
I=imresize(I,[255 255],'bicubic');
NI=imnoise(I,'gaussian',0,VAR);
%% MODE
K = input('Please enter the maximum order K (K>=0): ');
disp('Parameter Setting: p-q>-1, q>0, alpha>0;');
disp('e.g.');
disp('- OFMMR: p=2, q=2, alpha=1;');
disp('- CHFMR: p=2, q=3/2, alpha=1;');
disp('- PJFMR: p=4, q=3, alpha=1;');
p = input('p=');
q = input('q=');
alpha=input('alpha=');
%% COMPUTE
[RI,R,RR,L,DT,RT]=PolynomialFMR(NI,K,p,q,alpha);
%% OUTPUT
figure;
set (gcf,'Position',[400,500,1200,400])
subplot(131);
imshow(uint8(abs(I)));
title('Original');
subplot(132);
imshow(uint8(abs(NI)));
title({'Nosie';['VAR=',num2str(VAR)]});
subplot(133);
imshow(uint8(abs(RI)));
[N,M]=size(I);[X,Y]=meshgrid(-1+1/M:2/M:1-1/M,1-1/N:-2/N:-1+1/N);
[~, r]= cart2pol(X, Y);I(r>=1)=0;RI(r>=1)=0;
different_a = (abs(abs( double(abs(RI))-double(I)))).^2;
different_b = (double(I)).^2;
MSRE = sum(different_a(:))/sum(different_b(:));
SSIM = ssim(uint8(RI),uint8(I));
disp(table([alpha;K;L;DT;RT;MSRE;SSIM],'RowNames',{'alpha';'K';'L';'DT';'RT';'MSRE';'SSIM'},'VariableNames',{'Value'}));
title({'Reconstructed'; ['K=',num2str(K),'  SSIM=',num2str(SSIM),'  MSRE=',num2str(MSRE)]});
figure;
set (gcf,'Position',[400,500,1200,400])
subplot(121);
imshow(abs(R),[]);
title('Original');
subplot(122);
imshow(abs(RR),[]);
title('Reconstructed');
;