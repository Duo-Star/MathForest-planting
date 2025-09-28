library;

import 'dart:math' as math;
import '../../Alg/EquSolver/EquSolver.dart' as EquSolver;
import '../../Alg/Fertile/DNum.dart';
import '../Conic/XLine.dart';
import '../Linear/Plane.dart';
import '../Linear/Vec.dart';
import '../Linear/Line.dart';
import '../Conic/Circle.dart';
import '../Conic/Conic0.dart';
import '../Fertile/DPoint.dart';

import 'Plane_Line.dart' as _Plane_Line;

Vec Line_Line(Line la, Line lb) {
  (num, num) xy = EquSolver.solve2x2LinearSystem(
    la.v.x,
    -lb.v.x,
    lb.p.x - la.p.x,
    la.v.y,
    -lb.v.y,
    lb.p.y - la.p.y,
  );
  return lb.indexPoint(xy.$2);
}

DNum Circle_Line_theta(Circle c, Line l) {
  if (l.v.x == 0) {
    //排除分母为零的情况
    return EquSolver.solveCosSinForMainRoot(c.r, 0, c.p.x - l.p.x);
  } else {
    //下面屎山不要动
    return EquSolver.solveCosSinForMainRoot(
      0 - (c.r * l.v.y) / l.v.x,
      c.r,
      c.p.y - ((c.p.x - l.p.x) * l.v.y) / l.v.x - l.p.y,
    );
  }
}

DPoint Circle_Line(Circle c, Line l) {
  DNum theta12 = Circle_Line_theta(c, l);
  return c.indexPoints(theta12);
}

DNum Circle_Circle_theta(Circle c1, Circle c2) {
  DNum theta = EquSolver.solveCosSinForMainRoot(
    2 * c2.p.x * c2.r - 2 * c1.p.x * c2.r,
    2 * c2.p.y * c2.r - 2 * c1.p.y * c2.r,
    math.pow(c1.p.x - c2.p.x, 2) +
        math.pow(c1.p.y - c2.p.y, 2) +
        c2.r * c2.r -
        c1.r * c1.r,
  );
  return theta; //注意这里获取的theta是c2的
}

DPoint Circle_Circle(Circle c1, Circle c2) {
  DNum theta = Circle_Circle_theta(c1, c2);
  return c2.indexPoints(theta);
}

DPoint Conic0_Line(Conic0 c, Line l) {
  if (l.v.x == 0) {
    DNum thetas = EquSolver.solveCosSinForMainRoot(c.u.x, c.v.x, c.p.x - l.p.x);
    return c.indexPoints(thetas);
  } else {
    DNum thetas = EquSolver.solveCosSinForMainRoot(
      c.u.y - (c.u.x * l.v.y) / l.v.x,
      c.v.y - (c.v.x * l.v.y) / l.v.x,
      c.p.y - ((c.p.x - l.p.x) * l.v.y) / l.v.x - l.p.y,
    );
    return c.indexPoints(thetas);
  }
}

Plane_Line(Plane pl, Line l) => _Plane_Line.Plane_Line(pl, l);
DPoint Plane_XLine(Plane pl, XLine xl) => _Plane_Line.Plane_XLine(pl, xl);
