import 'dart:math';
import '../Linear/Line.dart';
import '../Linear/Vec.dart';
import '../Fertile/DPoint.dart';
import '../../Alg/Fertile/DNum.dart';

class XLine {
  Vec p;
  Vec u;
  Vec v;

  //XLine: Line(p, u) ^^ Line(p, v)
  XLine([Vec? p, Vec? u, Vec? v]):
        p = p ?? Vec(),
        u = u ?? Vec(1,  1),
        v = v ?? Vec(1, -1);

  Line get l1 => Line(p, u);
  Line get l2 => Line(p, v);

  static newPDP(Vec p, DPoint dp) => XLine(p, dp.p1-p, dp.p2-p);


}