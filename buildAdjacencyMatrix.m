function adjMatrix = buildAdjacencyMatrix(start_point, intersectionPoints, end_point, lines)
    %% 根据 已知通道信息， 起始点，终止点坐标 得到邻接矩阵 
    numVertices = length(intersectionPoints) + 2; % 交点数加上起点和终点
    numPoints = size(intersectionPoints, 1);      % 通道交点的数目

    adjMatrix = zeros(numVertices); % 邻接矩阵初始化为无穷大
    
    adjMatrix(1, 2:end-1) = calculateDistances(start_point, intersectionPoints, lines);
    adjMatrix(2:end-1, end) = calculateDistances(end_point, intersectionPoints, lines);


    % 对称性
    adjMatrix(2:end-1, 1) = adjMatrix(1, 2:end-1)';
    adjMatrix(end, 2:end-1) = adjMatrix(2:end-1, end)';

    adjMatrix(1,end) = calculateDistances(start_point, end_point, lines); 
    adjMatrix(end,1) = adjMatrix(1,end) ; 
    

    
    for i = 1:numPoints
        point = intersectionPoints(i, :);
        distances = calculateDistances(point, intersectionPoints(i:numPoints, :), lines);
        adjMatrix(1+i, 1+i:1+numPoints) = distances;
        adjMatrix(1+i:1+numPoints, 1+i) = distances;
    end

end


function distances = calculateDistances(point, points_list, lines)
    %% 判断点 跟 其它点列表 的距离， 并且满足特定的距离约束，如果不在任何线段内，则距离为inf，如果在其中某个线段内，则距离为空间中欧氏距离 
    num_points = size(points_list, 1);
    distances = inf(1, num_points);
    for i = 1:num_points
        if isPointInsideAnySegment(point, lines, points_list(i, :))
            distances(i) = norm(point - points_list(i, :));
        end
    end
end