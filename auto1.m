clc
clear all
%本自动处理程序针对每一个输出
dataFolder = 'E:\Mayihang\2023_1_30\zhengding\ASCII';
outputpath='E:\Mayihang\2-28radar\400Mhz_radar2\'
addpath(dataFolder);
file='326LG-PLXL-EW01-001-400';
[Header,Data]=readmala2(file);

% 雷达信号道间距
distance = Header.DISTANCE_INTERVAL; 


if size(Data,2)*distance<20
    Data = imresize(Data, [600 size(Data,2)*distance/20*600]);
    meandata=mean(Data,'all');
%     colVector = meandata.* ones(600, 600-size(Data,2));  % 生成 600 行 1 列每个元素都为 4000 的列向量
%     Data=[Data colVector]
else
    Data=Data(:,1:20/Header.DISTANCE_INTERVAL)
        Data = imresize(Data, [600 600]);

end
  
% 显示雷达信号
fig=figure;
Data=6.*Data;
colVector = meandata.* ones(600, 600-size(Data,2));  % 生成 600 行 1 列每个元素都为 4000 的列向量
     Data=[Data colVector]
imagesc(Data);
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
saveas(gcf,[outputpath,file,'.jpg'])