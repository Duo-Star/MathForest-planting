library;

import '../Linear/Vec.dart';
import 'IntersectionSolver.dart';


// return Vec or DPoint
dynamic Ins(dynamic obj1, dynamic obj2) {
  String obj1T, obj2T;
  obj1T = obj1.type;
  obj2T = obj2.type;
  switch ((obj1T, obj2T)) {
    case ("Line", "Line"):
      return Line_Line(obj1, obj2);
    case ("Line", "Cir2"):
      return Cir2_Line(obj2, obj1);
    case ("Cir2", "Line"):
      return Cir2_Line(obj1, obj2);
    case ('Cir2', 'Cir2'):
      return Cir2_Cir2(obj1, obj2);
    default:
     return Vec.nan();
  }
}
