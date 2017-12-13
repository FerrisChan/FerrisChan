% 裂缝检测 crack detect % 陈李锋 14通信 2014081025close all; clear all;%% 输入图像imageOrinal = imread('crackTodo2.PNG'); % 读取原始图像imageGrey = rgb2gray(imageOrinal);   % 将原始图像灰度化figure(1) ;imshow(imageOrinal);title('原始图像');%% 校正不均匀亮度imageExpand = imadjust(imageGrey,[0.30,0.5],[0,1]); % 将0.25 到0.5之间（根据不同图片的亮度）来确定的灰度级扩展到范围[0 1].figure(2);imshow(imageExpand);title('linear expand image')%% 噪声去除% step 1 多次中值滤波imageFliter1 = medfilt2(imageExpand);imageFliter2 = medfilt2(imageFliter1);imageFliter3 = medfilt2(imageFliter2);  figure(3)imshow(imageFliter1);title('image first after remove noise ')figure(4)imshow(imageFliter3);title('final image after remove noise')%% 局部二值化 OTSUlevel = graythresh(imageFliter3);imageOstu = im2bw(imageFliter3,level);figure(4)imshow(imageOstu);title('final image after 局部二值化')%% 修正图像 图像开闭操作se=strel('square',1); % 产生一个正方形结构来进行开闭操作imageClose = imclose(imageOstu, se);  % 先进行闭操作去除毛刺figure(5)imshow(imageClose);title('final image after close')imageOpen = imopen(imageClose, se);   % 进行开操作figure(6)imshow(imageOpen);title('final image after open')imageEdge = bwmorph(imageOpen,'remove');  % 边缘目标提取，查看边缘是否连接figure(7)imshow(imageEdge);title('edge of image ')