function testPlot(xyThetaList, arrowLength)
%     figure;
    hold on;
    axis equal;
    grid on;
    
    % 绘制路径点和箭头
    for i = 1:length(xyThetaList.x)
        if i <= length(xyThetaList.x)-1
            x = [xyThetaList.x(i) xyThetaList.x(i+1)];
            y = [xyThetaList.y(i) xyThetaList.y(i+1)];
            plot(x, y, 'b');
        end
        
        if xyThetaList.prop(i) ~= 'i'
            % 绘制箭头
            dx = cos(xyThetaList.theta(i)) * arrowLength;
            dy = sin(xyThetaList.theta(i)) * arrowLength;
            quiver(xyThetaList.x(i), xyThetaList.y(i), dx, dy, 'r', 'MaxHeadSize', 6, 'LineWidth', 3);
        end
    end
    
    xlabel('x');
    ylabel('y');
    title('路径点绘图');
end
