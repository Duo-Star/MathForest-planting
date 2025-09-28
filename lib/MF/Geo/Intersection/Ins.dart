library;

import 'IntersectionSolver.dart';

dynamic Ins(dynamic obj1, dynamic obj2) {
  String obj1T, obj2T;
  obj1T = obj1.type;
  obj2T = obj2.type;

  switch ((obj1T, obj2T)) {
    case ("Line", "Line"):
      return Line_Line(obj1, obj2);
    case ("Line", "Circle"):
      return Circle_Line(obj2, obj1);
    case ("Circle", "Line"):
      return Circle_Line(obj1, obj2);



    default:
    // 默认情况
  }
}
