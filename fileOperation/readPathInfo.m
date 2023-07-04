function [start_point,end_point,lines] = readPathInfo(fileName)
%     % ��ȡ�ͽ���CSV�ļ�
%     data = readmatrix(fileName, 'Delimiter', ',');
% 
%     % ��ȡ�����յ�
%     start_point = data(1, 2:3);
%     end_point = data(2, 2:3);
% 
%     % ��ȡͨ���߶�
%     lines = cell(1, size(data, 1) - 2);
%     for i = 3:size(data, 1)
%         lines{i-2} = data(i, 2:5);
%     end

    fileID = fopen(fileName);
    fileData = textscan(fileID, '%s', 'Delimiter', '\n');
    fclose(fileID);

    % ���������յ�
    start_point = [];
    end_point = [];
    line_data = {};
    for i = 1:length(fileData{1})
        line = fileData{1}{i};
        if startsWith(line, 'Start Point')
            values = strsplit(line, ',');
            start_point = [str2double(values{2}), str2double(values{3})];
        elseif startsWith(line, 'End Point')
            values = strsplit(line, ',');
            end_point = [str2double(values{2}), str2double(values{3})];
        elseif startsWith(line, 'Line')
            values = strsplit(line, ',');
            line_coords = [str2double(values{2}), str2double(values{3}); str2double(values{4}), str2double(values{5})];
            line_str = sprintf('[%g, %g]; [%g, %g]', line_coords(1), line_coords(2), line_coords(3), line_coords(4));
            line_data{end+1} = line_coords;
        end
    end

    % ��ͨ���߶����ݴ洢�ڵ�Ԫ��������
    lines = line_data;
end

