import 'dart:math';
import '../Linear/Vec.dart';
import '../Linear/Line.dart';

import '../../Alg/Fertile/DNum.dart';
import '../Fertile/DPoint.dart';
import 'HLine.dart';
import 'XLine.dart';
import 'Conic.dart';

class Conic2 {
  Vec p;
  Vec u;
  Vec v;
  //conic2: p + t*u + ( 1/t )*v

  Conic2([Vec? p, Vec? u, Vec? v]): //中心，共轭方向1，共轭方向2
        p = p ?? Vec(),
        u = u ?? Vec(0, 1),
        v = v ?? Vec(1);

  factory Conic2.newPX(Vec P, XLine X) { //由一点及渐近线决定
    (num, num) rsv = P.RSV(X.u, X.v);
    num lamOrMu = sqrt(rsv.$1 * rsv.$2);
    return Conic2(X.p, X.u * lamOrMu, X.v * lamOrMu);
  }

  Vec indexPoint(num t) => p + u * t + v * (1/t);
  DPoint indexPoints(DNum t) => DPoint(indexPoint(t.n1),indexPoint(t.n2));

  Vec get vA => (u.unit + v.unit).unit; //实轴方向
  Vec get vB => (u.unit - v.unit).unit; //虚轴方向
  DNum get t0 { //顶点参数
    num t = pow(v.pow2 / u.pow2, 1/4) ;
    return DNum(t, -t);
  }
  DPoint get A => indexPoints(t0); //两个顶点
  Vec get O => p; //中心
  num get halfAngTan { //半角正切
    num c2 = u.cos(v);
    return sqrt( (1-c2) / (1+c2) );
  }

  num get a => sqrt(2 * sqrt(u.pow2 * v.pow2) + 2 * u.dot(v));
  num get b => a * halfAngTan;
  num get c => sqrt(pow(a,2)+pow(b,2));
  num get e => sqrt( 2 / (1+u.cos(v)) ); //离心率

  DPoint get F => DPoint.newPV(p, vA * c); //焦点
  HLine get L { //准线
    num w = pow(a, 2)/c;
    return HLine(p + vA * w, p - vA * w, vB);
  }
  XLine get X => XLine(p, u, v); //渐近线

  Vec der(t) => u + v * -pow(t, -2); //切方向
  Vec tangentVec(t) => der(t); //切方向
  Line tangentLine(t) => Line(indexPoint(t), der(t)); //切线

  num get ji => u.len * v.len;//积
  num get mJi => (u.cross(v)).len;//面积
  num get mian => mJi / ji;//面

  Conic2 get bro => Conic2(p, u, -v);//共轭双曲线

  Vec get pP => indexPoint(1);//正标
  Vec get nP => indexPoint(-1);//负标

  Vec get pV => u + v; //正-标共轭方向
  Vec get nV => u - v; //负-标共轭方向

  String get type => "Conic2";

  Conic get conic => Conic().byConic2(this);

  @override
  String toString() {
    return 'Conic2(${p.toString()}, ${u.toString()}, ${v.toString()})';
  }



}