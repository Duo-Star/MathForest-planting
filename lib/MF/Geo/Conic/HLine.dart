import 'dart:math';
import '../Linear/Vec.dart';
import '../Fertile/DPoint.dart';
import '../../Alg/Fertile/DNum.dart';

class HLine {
  final Vec p1;
  final Vec p2;
  final Vec v;

  HLine([Vec? p1, Vec? p2, Vec? v]):
        p1 = p1 ?? Vec(-1),
        p2 = p2 ?? Vec(1),
        v = v ?? Vec(0, 1);



}