library;

import 'dart:math' as math;
import '../Funcs.dart' as funcs;
import '../Fertile/DNum.dart';
import '../Fertile/TNum.dart';
import '../Fertile/QNum.dart';
import '../Complex.dart';
import '../Funcs.dart' as funcs;


//计算三角方程的主解 a sin(w t+p)+c=0
DNum solveSinForMainRoot(num a, num w, num p, num c) {
  num ratio = -c / a;
  if (ratio.abs() > 1) { // 无实数解的情况
    return DNum(double.nan, double.nan);
  }
  var u = math.asin(ratio);
  return DNum((u - p) / w, (math.pi - u - p) / w);
}


//计算三角方程的主解 u cos(t)+v sin(t)+c=0
DNum solveCosSinForMainRoot(num u, num v, num c) {
  if (v.abs() > 1e-10) {
    num a = math.sqrt(u * u + v * v) * funcs.sgn(v);
    num p;
    if (v.abs() > 1e-10) {
      p = math.atan(u / v);
    } else {
      p = (u >= 0 ? math.pi / 2 : -math.pi / 2);
    }
    return solveSinForMainRoot(a, 1, p, c);
  } else { // 处理v=0的特殊情况
    if (u.abs() < 1e-10) { // u和v都接近0，方程退化为c=0
      if (c.abs() < 1e-10) { // 无穷多解
        return DNum(0, math.pi); // 返回两个示例解
      } else { // 无解
        return DNum(double.nan, double.nan);
      }
    }
    return solveSinForMainRoot(u, 1, math.pi / 2, c);
  }
}
