function [] = result(W,VW,ZW,I0,I1,GT,VT,K)
[SZ1,SZ2]=size(W);
ERR=xor(W,VW)==1;
BER=sum(ERR(:))/(SZ1*SZ2);
AR=1-BER;
[SZ3,SZ4,~]=size(I0);
PSNR=psnr(uint8(I0),uint8(imresize(I1,[SZ3,SZ4])));
figure;
subplot(121);imshow(uint8(I0));title('Original');
subplot(122);imshow(uint8(I1));title({'Attacked';['PNSR= ',num2str(PSNR),' dB']});
figure;
subplot(221);imshow(logical(W));title('Original');
subplot(222);imshow(logical(ZW));title('Zero-watermarking');
subplot(223);imshow(logical(VW));title('Retrieved');
subplot(224);imshow(logical(ERR));title({'Error';['BER= ',num2str(BER*100),'%']});
disp(table([K;GT;VT;BER*100;AR*100;PSNR],'RowNames',{'K';'GT';'VT';'BER';'AR';'PSNR'},'VariableNames',{'Value'}));

% imwrite(uint8(I1),'Output\1.tif');
% imwrite(logical(ZW),'Output\2.tif');
% imwrite(logical(VW),'Output\3.tif');
% imwrite(logical(ERR),'Output\4.tif');
end

