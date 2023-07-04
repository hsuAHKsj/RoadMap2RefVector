function isInside = isPointInsideSegment(point, segment)
    x = point(1);
    y = point(2);
    x1 = segment(1, 1);
    y1 = segment(1, 2);
    x2 = segment(2, 1);
    y2 = segment(2, 2);

    isInside = (x >= min(x1, x2) && x <= max(x1, x2) && ...
                y >= min(y1, y2) && y <= max(y1, y2));
end 