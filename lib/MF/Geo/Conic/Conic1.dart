import 'dart:math';
import 'package:math_expressions/math_expressions.dart';

import '../../Alg/Fertile/DNum.dart';
import '../Fertile/DPoint.dart';
import 'HLine.dart';
import 'XLine.dart';
import 'Conic.dart';



import '../Linear/Vec.dart';
import '../Linear/Line.dart';


class Conic1 {
  Vec p ;
  Vec u ;
  Vec v ;

  Conic1([Vec? p, Vec? u, Vec? v]): //中心，OF，n
        p = p ?? Vec(),
        u = u ?? Vec(1),
        v = v ?? Vec.k();

  String get type => "Conic1";


  Conic get conic => Conic().byConic1(this);


  @override
  String toString() {
    return 'Conic1(${p.toString()}, ${u.toString()}, ${v.toString()})';
  }

}