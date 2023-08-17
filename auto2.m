clc
clear all
% 本自动输出为imwrite输出数据
dataFolder = 'E:\Mayihang\2023_1_30\400MHzrawdata\ASCII';
addpath(dataFolder);
% 列出数据文件夹中的所有文件
fileList = dir(fullfile(dataFolder, '*.RD3'));
outputpath='C:\Users\39281\Desktop\2-28radar\400MHz_radar\'
% 循环读取每个文件并进行操作
for i = 1:numel(fileList)
    
    % 获取文件名
    fileName = fileList(i).name;

    [~, name, ext] =fileparts(fileName)
    % 读取数据
    [Header,Data]=readmala2(name);
    
    % 雷达信号道间距
    distance = Header.DISTANCE_INTERVAL; 
    if size(Data,2)*distance<20
    Data = imresize(Data, [600 size(Data,2)*distance/20*600]);
    colVector = max(max(Data)) .* ones(600, 600-size(Data,2));  % 生成 600 行 1 列每个元素都为 4000 的列向量
    Data=[Data colVector];
    else
        Data=Data(:,1:20/Header.DISTANCE_INTERVAL)
        Data = imresize(Data, [600 600]);
    end
    imwrite(mat2gray(Data), [outputpath ,name '.jpg'],"jpg");
 end
