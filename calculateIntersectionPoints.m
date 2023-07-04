function intersectionPoints = calculateIntersectionPoints(lines)
    intersectionPoints = [];
    
    for i = 1:length(lines)-1
        line1 = lines{i};
        
        for j = i+1:length(lines)
            line2 = lines{j};
            intersectionPoint = findIntersection(line1, line2);
            
            % 检查交点是否在线段内部
            if isPointInsideSegment(intersectionPoint, line1) && ...
                    isPointInsideSegment(intersectionPoint, line2) && ...
                    ~isPointAlreadyExists(intersectionPoint, intersectionPoints)
                
                intersectionPoints = [intersectionPoints; intersectionPoint];
            end
        end
    end
end
