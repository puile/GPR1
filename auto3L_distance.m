clc
clear all

dataFolder = 'E:\Mayihang\2023_1_30\zhengding\ASCII';
outputpath='E:\Mayihang\2-28radar\zhengding\10\'
addpath(dataFolder);
file='E:\Mayihang\2023_1_30\zhengding\ASCII\20230224ZHENGDINGHENGZHOUBEIJIE_001_A1';
[Header,Data]=readmala2(file);
start=int32(1);
% 雷达信号道间距
distance = Header.DISTANCE_INTERVAL;
max_value=max(max(abs(Data)))
Data=Data./max_value
d=int32(17/Header.DISTANCE_INTERVAL);

while(int32(20/Header.DISTANCE_INTERVAL)+start<size(Data,2))
if size(Data,2)*distance<20
    Data = imresize(Data, [600 size(Data,2)*distance/20*600]);
    meandata=mean(Data,'all');
    colVector = meandata .* ones(600, 600-size(Data,2));  % 生成 600 行 1 列每个元素都为 4000 的列向量
    Data=[Data colVector]
else
    Data1=Data(:,start:int32(20/Header.DISTANCE_INTERVAL)+start);
    start=start+d;

        Data1 = imresize(Data1, [600 600]);


end
% imwrite(mat2gray(Data1), [outputpath ,[file '_' num2str(start) '.jpg']],"jpg");
% 显示雷达信号
fig=figure;
Data1=1.*Data1;
imagesc(Data1);
caxis([-4000 4000]);
xlabel('Range (m)');
ylabel('Time (s)');
colorbar;
colormap('gray');
axis off
colorbar('off')
set(gca,'Position',[0 0 1 1]);%消除白边
set(fig, 'Units', 'pixels');    % 将单位设置为像素
set(fig, 'Position', [0 0 450 450]);   % 设置图形对象的位置和大小
saveas(gcf,[outputpath,[file '_' num2str(start) '.jpg'],'.jpg'])
close;
end
% % 显示雷达信号
% fig=figure;
% Data=3.*Data;
% imagesc(Data);
% caxis([-4000 4000]);
% xlabel('Range (m)');
% ylabel('Time (s)');
% colorbar;
% colormap('gray');
% axis off
% colorbar('off')
% set(gca,'Position',[0 0 1 1]);%消除白边
% set(fig, 'Units', 'pixels');    % 将单位设置为像素
% set(fig, 'Position', [0 0 450 450]);   % 设置图形对象的位置和大小
% saveas(gcf,[outputpath,file,'.jpg'])