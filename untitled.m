dataFolder = 'D:\myh\200MHz_radardata\labels'
fileList = dir(fullfile(dataFolder, '*400.txt'));
destinationFolder = 'D:\myh\400MHz_radardata\labels'
for i = 1:numel(fileList)
    % 获取当前文件的完整路径和文件名
    fullFileName = fullfile(fileList(i).folder, fileList(i).name);
    
    % 将该文件移动到目标文件夹中
    movefile(fullFileName, destinationFolder);
end