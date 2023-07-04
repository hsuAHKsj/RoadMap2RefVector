function isInside = isPointInsideAnySegment(point, lines, intersectionPoint)
    isInside = false;
    epsilon = 1e-9; % 定义 epsilon 值，用于浮点数比较
    
    for i = 1:length(lines)
        line = lines{i};
        if isPointInsideSegment(point, line) && isPointInsideSegment(intersectionPoint, line)
            % 判断点是否在同一条线段上
            if isBetween(line(1,:), line(2,:), point, epsilon) && ...
                    isBetween(line(1,:), line(2,:), intersectionPoint, epsilon)
                isInside = true;
                break;
            end
        end
    end
end

function isBetween = isBetween(a, b, c, epsilon)
    crossproduct = (c(2) - a(2)) * (b(1) - a(1)) - (c(1) - a(1)) * (b(2) - a(2));

    % 与 epsilon 进行比较，如果使用整数则比较是否不等于 0
    if abs(crossproduct) > epsilon
        isBetween = false;
        return;
    end

    dotproduct = (c(1) - a(1)) * (b(1) - a(1)) + (c(2) - a(2)) * (b(2) - a(2));
    if dotproduct < 0
        isBetween = false;
        return;
    end

    squaredlengthba = (b(1) - a(1)) * (b(1) - a(1)) + (b(2) - a(2)) * (b(2) - a(2));
    if dotproduct > squaredlengthba
        isBetween = false;
        return;
    end

    isBetween = true;
end


