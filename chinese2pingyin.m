% 获取所有要重命名的文件路径
folder = 'C:\Users\39281\Desktop\2023_1_30\zhengding\';
old_names = dir(fullfile(folder, '20230224正定恒州北街*.iprb')); % 所有以 'old_prefix' 开头的文件
old_names = {old_names.name}; % 转为 cell 类型，方便后续处理

% 按照规则修改名称，比如给所有文件加上前缀 'new_prefix_'（也可以自定义其他规则）
for ii = 1:length(old_names)
   old_name = fullfile(folder, old_names{ii});
   new_name = fullfile(folder, ['20230224zhengdinghengzhoubeijie_001_A', num2str(ii),'.iprb']);
   movefile(old_name, new_name);
end


