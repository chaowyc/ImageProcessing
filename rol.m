function [imgn] = rol(angle)                      %要旋转的角度，旋转方向为顺时针
img=imread('image.jpg');        %这里h为原图像的高度，w为原图像的宽度
img = rgb2gray(img);
img = im2uint8(img);               %这里y为变换后图像的高度，x为变换后图像的宽度
[h w]=size(img);

theta=(angle/180)*pi;
rot=[cos(theta) -sin(theta) 0;sin(theta) cos(theta) 0;0 0 1]; 
pix1=[1 1 1]*rot;               %变换后图像左上点的坐标
pix2=[1 w 1]*rot;               %变换后图像右上点的坐标
pix3=[h 1 1]*rot;               %变换后图像左下点的坐标
pix4=[h w 1]*rot;               %变换后图像右下点的坐标

height=round(max([abs(pix1(1)-pix4(1))+0.5 abs(pix2(1)-pix3(1))+0.5]));     %变换后图像的高度
width=round(max([abs(pix1(2)-pix4(2))+0.5 abs(pix2(2)-pix3(2))+0.5]));      %变换后图像的宽度
imgn=zeros(height,width);

delta_y=abs(min([pix1(1) pix2(1) pix3(1) pix4(1)]));            %取得y方向的负轴超出的偏移量
delta_x=abs(min([pix1(2) pix2(2) pix3(2) pix4(2)]));            %取得x方向的负轴超出的偏移量

for i=1-delta_y:height-delta_y
    for j=1-delta_x:width-delta_x
        pix=[i j 1]/rot;                                %用变换后图像的点的坐标去寻找原图像点的坐标，                                         
                                                            %否则有些变换后的图像的像素点无法完全填充
        float_Y=pix(1)-floor(pix(1)); 
        float_X=pix(2)-floor(pix(2));    
       
        if pix(1)>=1 && pix(2)>=1 && pix(1) <= h && pix(2) <= w     
            
            pix_up_left=[floor(pix(1)) floor(pix(2))];          %四个相邻的点
            pix_up_right=[floor(pix(1)) ceil(pix(2))];
            pix_down_left=[ceil(pix(1)) floor(pix(2))];
            pix_down_right=[ceil(pix(1)) ceil(pix(2))]; 
        
            value_up_left=(1-float_X)*(1-float_Y);              %计算临近四个点的权重
            value_up_right=float_X*(1-float_Y);
            value_down_left=(1-float_X)*float_Y;
            value_down_right=float_X*float_Y;
                                                            
            imgn(i+delta_y,j+delta_x)=value_up_left*img(pix_up_left(1),pix_up_left(2))+ ...
                                        value_up_right*img(pix_up_right(1),pix_up_right(2))+ ...
                                        value_down_left*img(pix_down_left(1),pix_down_left(2))+ ...
                                        value_down_right*img(pix_down_right(1),pix_down_right(2));
        end       
        
    end
end
imgn = uint8(imgn);
end
