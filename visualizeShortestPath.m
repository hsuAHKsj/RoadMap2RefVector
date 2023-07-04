function visualizeShortestPath(P, intersectionPoints, start_point, end_point, lines, d)
    figure;
    hold on;
    
    % 绘制通道线段和起点、终点
    for i = 1:numel(lines)
        line = lines{i};
        plot(line(:,1), line(:,2), 'b');
    end
    plot(start_point(1), start_point(2), 'go', 'MarkerSize', 10);
    plot(end_point(1), end_point(2), 'ro', 'MarkerSize', 10);

    % 绘制最优路径
    x = [];
    y = [];
    for i = 1:length(P)
        node = P(i);  % 最短路径节点序列号
        disp(node)
        if node == 1 
            point = start_point; 
            text(point(1), point(2), '起点', 'Color', 'g', 'HorizontalAlignment', 'left');
        elseif node == 2+length(intersectionPoints)
            point = end_point;
            text(point(1), point(2), '终点', 'Color', 'r', 'HorizontalAlignment', 'right');
        else
            point = intersectionPoints(node-1,:);
            text(point(1), point(2), num2str(i), 'Color', 'm', 'HorizontalAlignment', 'center');
        end
        x = [x point(1)];
        y = [y point(2)];
        
    end
    plot(x, y, 'm', 'LineWidth', 2);
    text(start_point(1) + end_point(1), start_point(2) + end_point(2), ['总长度: ' num2str(d)], 'Color', 'k', 'HorizontalAlignment', 'left');
    axis equal;
end
