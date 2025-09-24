library;

import 'package:learnfl/MF/main.dart';

import '../Linear/Line.dart';
import '../Linear/Plane.dart';
import '../Linear/Vec.dart';

Vec Plane_Line(Plane pl, Line l){
  num lam = -((l.p-pl.p).dot(pl.n) / l.v.dot(pl.n));
  return l.indexPoint(lam);
}

DPoint Plane_XLine(Plane pl, XLine xl){
  return DPoint(Plane_Line(pl, xl.l1), Plane_Line(pl, xl.l2));
}

