%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This code was developed by Shuren Qi
% https://shurenqi.github.io/
% i@srqi.email / shurenqi@nuaa.edu.cn
% All rights reserved.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all;
clear all;
clc;
warning('off'); 
addpath(genpath(pwd));
dbstop if error
%% PARAMETER
K=32;
K1=[10,2,3];
K2=[5,1,2];
K3=[0.5,0.45];
%% METHOD
MD={'1.RHFM';'2.EFM';'3.PCET';'4.BFM';'5.FJFM';'6.GPCET';...   % FM 
    '7.FJFMR';'8.GPCETR'};                                     % FMR
for i=1:1:8, disp(MD{i}); end
TYPE = input('Please select a mode (1~8): ');
disp(MD{TYPE});
%% INPUT
I0=imread('Sailboat on lake.tiff');
W=imread('logo32.bmp');
%% ZERO-WATERMARK GENERATION
[ZW,GT,K]=generation(I0,W,K,K1,K2,K3,TYPE);
%% ZERO-WATERMARK VERIFICATION UNDER ATTACK
I1 = imattack(I0);
[VW,VT]=verification(I1,ZW,K,K1,K2,K3,TYPE);
%% OUTPUT
result(W,VW,ZW,I0,I1,GT,VT,K);