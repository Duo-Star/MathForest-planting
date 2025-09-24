import 'dart:math' as math ;
import '../Linear/Vec.dart';
import '../../Alg/Fertile/DNum.dart';
import '../Fertile/DPoint.dart';

class Circle {
  final Vec p;
  final num r;

  Circle([Vec? p, num? r]): p = p ?? Vec(), r = r ?? 1;

  get area => math.pi * r * r ;
  get cir => 2 * math.pi * r ;

  Vec indexPoint(num theta) => p + Vec(r*math.cos(theta),r*math.sin(theta));
  DPoint indexPoints(DNum theta) => DPoint(indexPoint(theta.n1), indexPoint(theta.n2));

@override
  String toString() {
    return "Circle(${p.toString()} , $r})";
  }
}
