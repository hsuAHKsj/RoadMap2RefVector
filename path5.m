close all;
clear all;

% 创建测试数据 - 多条通道线段
line1 = [[0, 0]; [0, 5]];
line2 = [[-1, 3]; [5, 3]];
line3 = [[3, 5]; [3, -3]];
line4 = [[2.5, -1]; [6, -1]];
lines = {line1, line2, line3, line4};

% 创建测试数据 - 两个点，point1 代表起点，point2 代表终点
start_point = [0, 0];
end_point = [6, -1];

% 计算通道线段之间的交点集合
intersectionPoints = calculateIntersectionPoints(lines);

% 构建图的邻接矩阵，顺序是start_point, 主通道交点, start_point  
adjMatrix = buildAdjacencyMatrix(start_point, intersectionPoints, end_point, lines); 

% 创建有向图对象
G = digraph(adjMatrix);

% 使用graphshortestpath函数计算最短路径 （使用的Dijkstra算法）
numVertices = size(adjMatrix, 2);
[P,d] = shortestpath(G, 1, numVertices);

visualizeShortestPath(P, intersectionPoints, start_point, end_point, lines, d)
