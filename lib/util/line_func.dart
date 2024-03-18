import 'dart:ui' show Offset;

// 直线
double straightLine(double x, Offset p0, Offset p1) {
  return (p0.dy - p1.dy) / (p0.dx - p1.dx) * (x - p0.dx) + p0.dy;
}

// 增量直线
double incrementStraightLine(double x, Offset p0, Offset p1) {
  return (p0.dy - p1.dy) / (p0.dx - p1.dx) * x;
}
