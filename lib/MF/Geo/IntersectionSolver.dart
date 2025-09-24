import 'dart:math' as math;
import '../Alg/EquSolver.dart';
import '../Alg/Fertile/DNum.dart';
import 'Linear/Vec.dart';
import 'Linear/Line.dart';
import 'Conic/Circle.dart';
import 'Conic/Conic0.dart';
import 'Fertile/DPoint.dart';

//library Intersection;

class IntersectionSolver {

  IntersectionSolver();

  final EquSolver equSolver = EquSolver();

  static Vec Line_Line(Line la, Line lb) {
    (num, num) xy = EquSolver.solve2x2LinearSystem(
        la.v.x, -lb.v.x, lb.p.x - la.p.x,
        la.v.y, -lb.v.y, lb.p.y - la.p.y);
    return lb.indexPoint(xy.$2);
  }

  static DNum Circle_Line_theta(Circle c, Line l) {
    if (l.v.x == 0) { //排除分母为零的情况
      return EquSolver.solveCosSinForMainRoot(c.r, 0, c.p.x - l.p.x);
    } else { //下面屎山不要动
      return EquSolver.solveCosSinForMainRoot(0 - (c.r * l.v.y) / l.v.x,
          c.r,
          c.p.y - ((c.p.x - l.p.x) * l.v.y) / l.v.x - l.p.y);
    }
  }


  static DPoint Circle_Line(Circle c, Line l) {
    DNum theta12 = Circle_Line_theta(c, l);
    return c.indexPoints(theta12);
  }

  static DNum Circle_Circle_theta(Circle c1, Circle c2) {
    DNum theta = EquSolver.solveCosSinForMainRoot(
        2 * c2.p.x * c2.r - 2 * c1.p.x * c2.r,
        2 * c2.p.y * c2.r - 2 * c1.p.y * c2.r,
        math.pow(c1.p.x - c2.p.x, 2) + math.pow(c1.p.y - c2.p.y, 2) +
            c2.r * c2.r - c1.r * c1.r);
    return theta; //注意这里获取的theta是c2的
  }

  static DPoint Circle_Circle(Circle c1, Circle c2) {
    DNum theta = Circle_Circle_theta(c1, c2);
    return c2.indexPoints(theta);
  }


  static DPoint Conic0_Line(Conic0 c, Line l) {
    if (l.v.x == 0) {
      DNum thetas = EquSolver.solveCosSinForMainRoot(
          c.u.x, c.v.x, c.p.x - l.p.x);
      return c.indexPoints(thetas);
    } else {
      DNum thetas = EquSolver.solveCosSinForMainRoot(
          c.u.y - (c.u.x * l.v.y) / l.v.x,
          c.v.y - (c.v.x * l.v.y) / l.v.x,
          c.p.y - ((c.p.x - l.p.x) * l.v.y) / l.v.x - l.p.y);
      return c.indexPoints(thetas);
    }
  }

  /*
  DPoint Conic0_Line(Conic0 c, Line l) {
    if (l.v.x == 0) {
      // 竖直线情况
      DNum thetas = EquSolver.solveCosSinForMainRoot(
          c.u.x, c.v.x, c.p.x - l.p.x);
      return c.indexPoints(thetas);
    } else {
      // 一般直线情况 - 修正推导
      num k = l.v.y / l.v.x;  // 斜率

      DNum thetas = EquSolver.solveCosSinForMainRoot(
          c.u.y - k * c.u.x,      // cosθ系数
          c.v.y - k * c.v.x,      // sinθ系数
          c.p.y - l.p.y - k * (c.p.x - l.p.x)  // 常数项
      );
      return c.indexPoints(thetas);
    }
  }

   */

}

