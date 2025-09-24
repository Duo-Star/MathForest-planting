import 'dart:math' as math;
import 'Funcs.dart' as funcs;
import 'Fertile/DNum.dart';

class EquSolver {

  EquSolver();

  static (num, num) solve2x2LinearSystem(num a1, num b1, num c1, num a2, num b2, num c2) {
    //[[a1 x + b1 y = c1, a2 x + b2 y = c2 ]]
    num D = a1 * b2 - a2 * b1;
    if (D == 0) {
      return (1 / 0, 1 / 0);
    } else {
      var x = (c1 * b2 - c2 * b1) / D;
      var y = (a1 * c2 - a2 * c1) / D;
      return (x, y); // 有顺序
    }
  }

  static DNum solveQuadraticForReal(dynamic a, dynamic b, dynamic c){

    return DNum();
  }



  static DNum solveSinForMainRoot(num a, num w, num p, num c) {
    // 添加参数验证
    if (a.abs() < 1e-10) {
      throw ArgumentError("参数a不能为0");
    }
    // 检查定义域
    num ratio = -c / a;
    if (ratio.abs() > 1) {// 无实数解的情况
      return DNum(double.nan, double.nan);
    }
    var u = math.asin(ratio);
    return DNum((u - p) / w, (math.pi - u - p) / w);
  }

  static DNum solveCosSinForMainRoot(num u, num v, num c) {
    if (v.abs() > 1e-10) {
      num a = math.sqrt(u * u + v * v) * (v >= 0 ? 1 : -1); // 直接计算符号
      num p;
      if (v.abs() > 1e-10) {
        p = math.atan(u / v);
      } else {
        p = (u >= 0 ? math.pi / 2 : -math.pi / 2);
      }
      return solveSinForMainRoot(a, 1, p, c);
    } else {// 处理v=0的特殊情况
      if (u.abs() < 1e-10) {// u和v都接近0，方程退化为c=0
        if (c.abs() < 1e-10) {// 无穷多解
          return DNum(0, math.pi); // 返回两个示例解
        } else {// 无解
          return DNum(double.nan, double.nan);
        }
      }
      return solveSinForMainRoot(u, 1, math.pi / 2, c);
    }
  }
}

