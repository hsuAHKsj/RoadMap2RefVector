function intersectionPoint = findIntersection(line1, line2)
    x1 = line1(1, 1);
    y1 = line1(1, 2);
    x2 = line1(2, 1);
    y2 = line1(2, 2);
    x3 = line2(1, 1);
    y3 = line2(1, 2);
    x4 = line2(2, 1);
    y4 = line2(2, 2);

    x = ((x1*y2 - y1*x2)*(x3 - x4) - (x1 - x2)*(x3*y4 - y3*x4)) / ...
        ((x1 - x2)*(y3 - y4) - (y1 - y2)*(x3 - x4));
    y = ((x1*y2 - y1*x2)*(y3 - y4) - (y1 - y2)*(x3*y4 - y3*x4)) / ...
        ((x1 - x2)*(y3 - y4) - (y1 - y2)*(x3 - x4));

    intersectionPoint = [x, y];
end