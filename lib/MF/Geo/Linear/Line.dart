
import 'dart:math' as math ;
import 'Vec.dart';

class Line {
  final Vec p;
  final Vec v;
  //line: p + lam * v

  String get type => "Line";

  Line([Vec? p, Vec? v]): p = p ?? Vec(), v = v ?? Vec(1);
  static new2P(Vec p1, Vec p2) => Line(p1, p2-p1);

  Vec indexPoint(num lam) => p + v * lam;


  @override
  String toString() {
    return "Line(${p.toString()}, ${v.toString()})";
  }
}