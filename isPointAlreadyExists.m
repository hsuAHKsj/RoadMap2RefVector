function result = isPointAlreadyExists(point, points)
    result = false;
    for i = 1:size(points, 1)
        if isequal(point, points(i, :))
            result = true;
            break;
        end
    end
end