
import 'dart:math' as math ;
import 'Vec.dart';

class Line {
  final Vec p;
  final Vec v;
  //line: p + lam * v
  Line([Vec? p, Vec? v]): p = p ?? Vec(), v = v ?? Vec(1);
  Vec indexPoint(num lam) => p + v * lam;

  @override
  String toString() {
    return "Line(${p.toString()}, ${v.toString()})";
  }
}