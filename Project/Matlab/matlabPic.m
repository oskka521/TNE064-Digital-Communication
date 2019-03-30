
clc;
clear;
close all;
I = imread('skiOskar.jpg');
I = rgb2gray(I);
I = imresize(I, (1/1));
%I2 = I;
I2 = I/16;

[height,width] = size(I)
figure,imshow(I);
% for i = 1:height
%     for j = 1:width
%       if I2(i,j) > 15
%           I2(i,j) = 15;
%       end
%     end
% end
% fid = fopen('kommigen2.bin','w');
% for row = 1:height
%     for col = 1:width   
%        tmp = I2(row, col); 
%         tmp = dec2bin(tmp);
%         fprintf(fid,'\"%04s\", ', tmp);        
%     end
% end
% fclose(fid);



Iblur = imgaussfilt(I, 3);
b = imsharpen(I,'Radius',2,'Amount',100);
figure,imshow(b);




%%I_ = reshape(I,[height,width]);

%%

for langd = 1:length(I_)
    if langd < (rr)
       
         xx = I_(langd)*1;
         yy =  I_(langd+1)*2 + I_(langd+2)*1;
         xx2 = I_(langd+width)*2 + I_(langd+1+width)*4;
         yy2 = I_(langd+2+width)*2;
         xx3 = I_(langd+2*width)*1 +I_(langd+1+2*width)*2;
         yy3 = I_(langd+2+2*width);
         
          I_SUM_x(langd)  = (xx+yy+xx2+yy2+xx3+yy3);
    else
        I_SUM_x(langd) = 10;
    end
        
    
       I_SUM_z(langd) =  (I_SUM_x(langd));
end 


I_VECTOR_sobel = reshape(I_SUM_x,[height,width]);

figure,imshow(I_VECTOR_sobel);
title('Sobel gradient');


