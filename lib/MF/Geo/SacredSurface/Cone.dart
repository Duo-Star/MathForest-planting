import 'dart:math';
import '../Linear/Vec.dart';
import '../Linear/Line.dart';

class Cone {
  Vec p;
  Vec n;
  Vec v;

  Cone([Vec? p, Vec? n, Vec? v]):
  //顶点向量p，旋转轴向量n，曲面内（直纹）任意直线方向向量v
        p = p ?? Vec(),
        n = n ?? Vec(0,1),
        v = v ?? Vec(1);

  get _u => n.cross(v).unit;
  get _v => n.cross(_u).unit;
  get theta => n.ang(v);



}

