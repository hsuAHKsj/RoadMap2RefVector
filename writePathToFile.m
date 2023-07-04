function writePathToFile(xyThetaList, filename)
    % 找到不是 'i' 属性的点的索引
    valid_indices = find(xyThetaList.prop ~= 'i');
    
    % 提取有效数据
    data = [xyThetaList.x(valid_indices), xyThetaList.y(valid_indices), xyThetaList.theta(valid_indices)*180/pi];
    
    % 将数据转换为字符数组，并使用空格作为分隔符
    data_str = sprintf('%f %f %f\n', data');
    
    % 写入文本文件
    fid = fopen(filename, 'w');
    if fid == -1
        error('无法打开文件进行写入。');
    end
    
    fprintf(fid, data_str);
    fclose(fid);
end