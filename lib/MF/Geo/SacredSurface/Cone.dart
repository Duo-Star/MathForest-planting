import 'dart:math';
import '../Linear/Vec.dart';
import '../Linear/Line.dart';
import '../Conic/Circle.dart';
import '../Conic/XLine.dart';

import '../Fertile/DPoint.dart';



class Cone {
  Vec p;  // 顶点位置向量
  Vec n;  // 旋转轴方向向量（单位向量）
  Vec v;  // 曲面内任意直线方向向量

  Cone({Vec? p, Vec? n, Vec? v})
      : p = p ?? Vec(),  // 默认原点
        n = (n ?? Vec(0, 1)).unit,  // 确保单位向量
        v = (v ?? Vec(1, 0)).unit;  // 确保单位向量

  Circle get unitCircle {
    Vec p2cirP = n * 1/tan(theta);
    Vec v_ = v * 1/sin(theta);
    return Circle(p + p2cirP, v_ - p2cirP, n);
  }

  //构建局部坐标系
  Vec get _u => n.cross(v).unit;
  Vec get _v => n.cross(_u).unit;
  num get theta => n.ang(v);

  Vec indexPoint(double theta, double t) {
    return p + (unitCircle.indexPoint(theta) - p).unit * t;
  }

  DPoint get unitCircleConjugateDPoint {
    Circle c = unitCircle;
    return DPoint(c.indexPoint(0), c.indexPoint(pi/2));
  }

  XLine get unitCircleConjugateXLine {
    return XLine.newPDP(p, unitCircleConjugateDPoint);
  }




}