close all;
clear all;
addpath fileOperation;
addpath data;
addpath plot;

% % 读取通道信息文件 创建测试数据 - 多条通道线段
fileName = 'lineInfo.csv';
[start_point,end_point,lines] = readPathInfo(fileName);

% 计算通道线段之间的交点集合
intersectionPoints = calculateIntersectionPoints(lines);

% 构建图的邻接矩阵，顺序是start_point, 主通道交点, start_point  
adjMatrix = buildAdjacencyMatrix(start_point, intersectionPoints, end_point, lines); 

% 创建有向图对象
G = digraph(adjMatrix);

% 使用graphshortestpath函数计算最短路径 （使用的Dijkstra算法）
numVertices = size(adjMatrix, 2);
[P,d] = shortestpath(G, 1, numVertices);

% 进行中间过渡点替换和始末端方向整定
r = 0.6;
arrowLength = 0.3;
xyThetaList = calculateBlendingPoints(P, intersectionPoints, start_point, end_point, r);

visualizeShortestPath(P, intersectionPoints, start_point, end_point, lines, d)
plotRefVector(xyThetaList, arrowLength);
writePathToFile(xyThetaList, './data/refPoints.txt');
