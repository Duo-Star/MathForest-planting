import 'dart:math';
import '../Linear/Vec.dart';
import '../../Alg/Fertile/DNum.dart';
import '../Fertile/DPoint.dart';

class Cir2 {
  Vec p = Vec();
  num r = 1;

  String get type => "Cir2";

  Cir2(this.p, this.r);

  Cir2.new2P(Vec p1, Vec p2):
        p = p1,
        r = (p2 - p1).len;

  get area => pi * r * r ;
  get cir => 2 * pi * r ;


  Vec indexPoint(num theta) => p + Vec(r) * cos(theta) + Vec(0,r) * sin(theta);
  DPoint indexPoints(DNum theta) => DPoint(indexPoint(theta.n1), indexPoint(theta.n2));

  @override
  String toString() {
    return "Cir2(${p.toString()} , $r})";
  }

}
