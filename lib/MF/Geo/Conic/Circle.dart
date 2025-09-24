import 'dart:math';
import '../Linear/Vec.dart';
import '../../Alg/Fertile/DNum.dart';
import '../Fertile/DPoint.dart';

class Circle {
  final Vec p;
  final Vec v;
  final Vec n;

  Circle([Vec? p, Vec? v, Vec? n]): //位置，径向，法向
        p = p ?? Vec(),
        v = v ?? Vec(1),
        n=n ?? Vec(0,0,1);

  get r => v.len;
  get area => pi * r * r ;
  get cir => 2 * pi * r ;
  get u => v.cross(n);


  Vec indexPoint(num theta) => p + u * cos(theta) + v * sin(theta);
  DPoint indexPoints(DNum theta) => DPoint(indexPoint(theta.n1), indexPoint(theta.n2));

@override
  String toString() {
    return "Circle(${p.toString()} , $r})";
  }
}
