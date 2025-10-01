import 'dart:math' as math ;
import '../Linear/Line.dart';
import '../Linear/Vec.dart';

class DPoint {
   Vec p1;
   Vec p2;

   DPoint([Vec? p1, Vec? p2]): p1 = p1 ?? Vec(-1), p2 = p2 ?? Vec(1);

  DPoint.newPV([Vec? p, Vec? v])
      : p1 = (p ?? Vec.zero()) + (v ?? Vec(1, 0)),
        p2 = (p ?? Vec.zero()) - (v ?? Vec(1, 0));

  Vec get mid => (p1 + p2) / 2;

  Line get l => Line.new2P(p1, p2);

  @override
  String toString() {
    return 'DPoint(${p1.toString()}, ${p2.toString()})';
  }

}
