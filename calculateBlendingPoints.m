function xyThetaList = calculateBlendingPoints(P, intersectionPoints, start_point, end_point, r)
    % ��������·��
    x = [];
    y = [];
    theta = [];
    prop = [];
    
    % ����·��������
    for i = 1:length(P)
        node = P(i);  % ���·���ڵ����к�
        if node == 1 
            point = start_point; 
            prop_value = 's';  % ��ʼ������Ϊ's'
        elseif node == 2+length(intersectionPoints)
            point = end_point;
            prop_value = 'e';  % ��ֹ������Ϊ'e'
        else
            point = intersectionPoints(node-1,:);
            prop_value = 'i';  % �м������Ϊ'i'
        end
        
        x = [x point(1)];
        y = [y point(2)];
        prop = [prop prop_value];
    end
    
    % ����ÿ������������Ƕ�
    for i = 1:length(x)
        if i == 1
            theta_value = calculateTheta(start_point, [x(i+1), y(i+1)]);
        elseif i == length(x)
            theta_value = calculateTheta([x(i-1), y(i-1)], end_point);
        else
            theta_value = calculateTheta([x(i-1), y(i-1)], [x(i+1), y(i+1)]);
        end

        theta = [theta theta_value];
    end
    
    % �����µ�·����
    new_x = [];
    new_y = [];
    new_theta = [];
    new_prop = [];
    
    for i = 1:length(x)
        if i == 1 || i == length(x)
            new_x = [new_x x(i)];
            new_y = [new_y y(i)];
            new_theta = [new_theta theta(i)];
            new_prop = [new_prop prop(i)];
        else
            prev_point = [x(i-1), y(i-1)];
            current_point = [x(i), y(i)];
            next_point = [x(i+1), y(i+1)];
            
            if norm(current_point - prev_point) < 2*r
                % ȡ�м����Ϊ�����
                new_x = [new_x x(i)];
                new_y = [new_y y(i)];
                new_theta = [new_theta theta(i)];
                new_prop = [new_prop prop(i)];
            else
                % ����ǰ�����˾���Ϊr�ĵ���Ϊ�����
                prev_insertion = calculateInsertion(current_point,prev_point, r);
                next_insertion = calculateInsertion(current_point, next_point, r);
                
                new_x = [new_x prev_insertion(1) x(i) next_insertion(1)];
                new_y = [new_y prev_insertion(2) y(i) next_insertion(2)];
                new_theta = [new_theta calculateTheta(prev_insertion, current_point) theta(i) calculateTheta(current_point, next_insertion)];
                new_prop = [new_prop 't' prop(i) 't'];
            end
        end
    end

    xyThetaList = struct('x', new_x', 'y', new_y', 'theta', new_theta', 'prop', new_prop');
    xyThetaList = adjustThetaList(xyThetaList);
end


% ��������֮����������ĽǶ�
function theta = calculateTheta(point1, point2)
theta = atan2(point2(2)-point1(2), point2(1)-point1(1));
end

function corrected_xyThetaList = adjustThetaList(xyThetaList)
    corrected_theta = xyThetaList.theta;
    
    % �ҵ���ʼ�� s ����һ�� 'i' ��֮ǰ�ĵ�
    i = find(xyThetaList.prop == 'i', 1);
    if ~isempty(i)
        for j = 1:i-1
            corrected_theta(j) = adjustTheta(corrected_theta(j), false, xyThetaList.theta(j));
        end
    end
    
    % �ҵ�������һ�� 'i' �����ֹ�� e
    last_i = find(xyThetaList.prop == 'i', 1, 'last');
    if ~isempty(last_i)
        for j = last_i+1:length(xyThetaList.theta)
            corrected_theta(j) = adjustTheta(corrected_theta(j), true, xyThetaList.theta(j));
        end
    end
    
    corrected_xyThetaList = xyThetaList;
    corrected_xyThetaList.theta = corrected_theta;
end

function corrected_theta = adjustTheta(theta, is_acute_angle, prev_theta)
    if is_acute_angle
        % �����˶�����ͬ��ĽǶ�תΪ180��
        if abs(theta - prev_theta) > pi/2
            corrected_theta = theta + pi;
        else
            corrected_theta = theta;
        end
    else
        % �����˶�����ͬ��ĽǶ�תΪ180��
        if abs(theta - prev_theta) < pi/2
            corrected_theta = theta + pi;
        else
            corrected_theta = theta;
        end
    end
end


% �����߶��Ͼ���Ϊr�Ĳ����
function insertion = calculateInsertion(start_point, end_point, r)
vec = end_point - start_point;
vec_length = norm(vec);
unit_vec = vec / vec_length;
insertion = start_point + r * unit_vec;
end