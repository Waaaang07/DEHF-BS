clear all;
close all, clc;

% 打开文件
fileID = fopen('selected_bands.txt', 'r');

% 初始化变量
num_bands_list = [];
bands_list = {};

% 逐行读取文件
while ~feof(fileID)
    line = fgetl(fileID); % 读取一行
    if ~isempty(line)
        % 使用正则表达式提取 num_bands 和 bands
        tokens = regexp(line, 'num_bands:(\d+), \[(.*)\]', 'tokens');
        if ~isempty(tokens)
            % 提取 num_bands
            num_bands = str2double(tokens{1}{1}); % 转换为数字
            % 提取 bands
            bands_str = tokens{1}{2};
            bands = str2num(bands_str); % 转换为数字数组
            
            % 存储 num_bands 和 bands
            num_bands_list = [num_bands_list; num_bands];
            bands_list{end+1} = bands;
        end
    end
end

% 关闭文件
fclose(fileID);

% 显示结果
disp('num_bands:');
disp(num_bands_list);
disp('bands:');
disp(bands_list);

% dataset={'S4P','TGSR','EFDPC','OCF','UBS','ASPS','MVPCA'};
dataset={'my_model'};
excel_name = 'result.xlsx';

% name_dataset='PU103';
% DS = 1;

name_dataset='IP220';
DS = 5;

% name_dataset='DC191';
% DS = 2;


band = 5:5:50;
result = zeros(length(dataset)*5, 10);
for j = 1:length(dataset)

    for i = 1:length(band)
        % k = band(i);
        % k_str = num2str(k);
        band_set = bands_list{i};
        [num_indexes,indexes] = load_indexes(name_dataset);
        for v = 1:5
            [class_results_SVM] = func_SVM(DS,band_set,num_indexes,indexes(:,v));
            result(5*(j-1)+v,i)=class_results_SVM.OA;
        end
    end
end

% 写入到指定工作表和单元格范围
writematrix(result, excel_name, 'Sheet', 'Sheet1', 'Range', 'B2');