function I1 = imattack(I0)

I0=uint8(I0);

% I1=imrotate(I0,2,'bicubic');
% I1=imresize(I1,[512,512]);

% I1=imrotate(I0,45,'bicubic','crop');

% I1=imresize(I0,0.5,'bicubic');

% H=fspecial('average',[10 10]);
% I1=imfilter(I0,H);

% SZ=10;
% I1R=medfilt2(I0(:,:,1),[SZ SZ]);
% I1G=medfilt2(I0(:,:,2),[SZ SZ]);
% I1B=medfilt2(I0(:,:,3),[SZ SZ]);
% I1=I0;
% I1(:,:,1)=I1R;
% I1(:,:,2)=I1G;
% I1(:,:,3)=I1B;

% H=fspecial('gaussian',[19,19],1.2);
% I1=imfilter(I0,H);

% I1 = imnoise(uint8(I0),'salt & pepper',0.2);
 
I1 = imnoise(uint8(I0),'gaussian',0,0.1);

% imwrite(uint8(I0),'JPEG.jpg','jpg','Quality',10);
% I1 = imread('JPEG.jpg','jpg');

% H=[0,-1,0;-1,5,-1;0,-1,0];
% I1= imfilter(I0,H,'replicate');

% [SZ1,SZ2,~]=size(I0);
% Q=1/16;
% L1=SZ1*Q;L2=SZ2*Q;
% % L1=64;L2=64;
% I1=I0;
% I1(1:L1,:,:)=0;I1(end-L1:end,:,:)=0;I1(:,1:L2,:)=0;I1(:,end-L2:end,:)=0;

% [SZ1,SZ2,~]=size(I0);
% % Q=1/6;
% L1=64;L2=64;
% I1=I0;
% I1(SZ1/2-L1:SZ1/2+L1,SZ2/2-L2:SZ2/2+L2,:)=0;

% [SZ1,SZ2,~]=size(I0);
% RN=floor(SZ1*rand(1,6));
% RM=floor(SZ2*rand(1,6));
% I1=I0;
% I1(RN,:,:)=[];I1(:,RM,:)=[];
% I1=imresize(I1,[SZ1,SZ2]);

% I1=I0;


end

