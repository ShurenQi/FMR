  %% Rotation
% clc;
% close all;
% clear;
% for i=1:1:20
%     I=imread(['original\coil-20\obj',num2str(i),'__0.png']);
%     for r=0:36:324
%         II=imrotate(I,r+18,'bicubic','crop');
%         imwrite(uint8(II),['testing set\obj',num2str(i),'__',num2str(r/36),'.png'])
%     end
% end
% 
% clc;
% close all;
% clear;
% for i=1:1:20
%     I=imread(['original\coil-20\obj',num2str(i),'__0.png']);
%     for r=0:36:324
%         II=imrotate(I,r,'bicubic','crop');
%         imwrite(uint8(II),['training set\',num2str(i),'\obj',num2str(i),'__',num2str(r/36),'.png'])
%     end
% end

% clc;
% close all;
% clear;
% for i=0:10:999
%     I=imread(['original\corel\',num2str(i),'.jpg']);
%     I=imresize(I,[128,128]);
%     for r=0:10:350
%         II=imrotate(I,r+5,'bicubic','crop');
%         imwrite(uint8(II),['testing set\obj',num2str(i/10+1),'__',num2str(r/10),'.png'])
%     end
% end

% clc;
% close all;
% clear;
% for i=0:10:999
%     I=imread(['original\corel\',num2str(i),'.jpg']);
%     I=imresize(I,[128,128]);
%     for r=0:10:350
%         II=imrotate(I,r,'bicubic','crop');
%         imwrite(uint8(II),['training set\',num2str(i/10+1),'\obj',num2str(i/10+1),'__',num2str(r/10),'.png'])
%     end
% end
ni =0.05:0.05:0.3 ;
for i=0:10:999
    I=imread(['original\corel\',num2str(i),'.jpg']);
    I=imresize(I,[128,128]);
    for n=1:1:36
        II=imnoise(I,'gaussian',0,ni(mod((n-1),6)+1));
        imwrite(uint8(II),['training set\',num2str(i/10+1),'\obj',num2str(i/10+1),'__',num2str(35+n),'.png'])
    end
end
    

