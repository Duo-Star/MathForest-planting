import 'dart:math';
import '../Linear/Vec.dart';
import '../Fertile/DPoint.dart';
import '../../Alg/Fertile/DNum.dart';

class XLine {
  final Vec p;
  final Vec u;
  final Vec v;

  //XLine: Line(p, u) ^^ Line(p, v)
  XLine([Vec? p, Vec? u, Vec? v]):
        p = p ?? Vec(),
        u = u ?? Vec(1,  1),
        v = v ?? Vec(1, -1);


}