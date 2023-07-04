function writePathToFile(xyThetaList, filename)
    % �ҵ����� 'i' ���Եĵ������
    valid_indices = find(xyThetaList.prop ~= 'i');
    
    % ��ȡ��Ч����
    data = [xyThetaList.x(valid_indices), xyThetaList.y(valid_indices), xyThetaList.theta(valid_indices)*180/pi];
    
    % ������ת��Ϊ�ַ����飬��ʹ�ÿո���Ϊ�ָ���
    data_str = sprintf('%f %f %f\n', data');
    
    % д���ı��ļ�
    fid = fopen(filename, 'w');
    if fid == -1
        error('�޷����ļ�����д�롣');
    end
    
    fprintf(fid, data_str);
    fclose(fid);
end