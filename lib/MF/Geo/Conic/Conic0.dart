import 'dart:math';


import '../../Alg/Fertile/DNum.dart';
import '../Fertile/DPoint.dart';
//import 'HLine.dart';
//import 'XLine.dart';
import 'Conic.dart';


import '../Linear/Vec.dart';
import '../Linear/Line.dart';

/*
#Conic0 封闭形圆锥曲线
当前位置 MathForest.Geo.Conic.Conic0
#1: Conic0是由方程 p + cos(θ)*u + sin(θ)*v
    所确定的曲线，这里的p,u,v都是向量，θ是参数
    从形状上 不仅有椭圆,圆，还有点,线段类型，
    从位置上 不仅可以在原点处产生，还可以进行任意的平移和旋转，脱离2d平面
    向量p叫位置参数，向量u和向量v叫形状参数
    当u和为平行时(要求模长不同时为零)，则产生一条线段
    当u和v垂直时，分为模相等和模不等
                相等时 产生圆
                不相等时 产生以u和v为长轴和短轴的椭圆
    当u和v模长同时为零时 产生一个点
    当他们的模长不同时为零，且既不平行也不垂直的时候 产生一般的斜椭圆
#2: 在正投影与透视投影变换中类型不变，仍然为Conic0
#3: 创建方法如下
    Conic0() / Conic0(Vector(),Vector(2,1),Vector(1,2))
    也可以使用其他以new作为开头的方法进行创建
    比如 使用两焦点和椭圆上一点建立平面椭圆
         Conic0.newEllipse2dBy3P(F1,F2,P)
    等等
 */

class Conic0 {
  Vec p;
  Vec u;
  Vec v;
  //conic0: p + cos(θ)*u + sin(θ)*v
  Conic0([Vec? p, Vec? u, Vec? v]): //中心，共轭方向1，共轭方向2
        p = p ?? Vec(),
        u = u ?? Vec(0,1),
        v = v ?? Vec(1);

  Vec indexPoint(num theta) => p + u * cos(theta) + v * sin(theta);
  DPoint indexPoints(DNum theta) => DPoint(indexPoint(theta.n1), indexPoint(theta.n2));

  List<num> get ab { //计算长短轴(半)
    num a1 = u.pow2;
    num a2 = (u.dot(v))*2;
    num a3=v.pow2;
    num b1=0.5*(a1+a3);
    num b2=sqrt( pow(0.5*(a1-a3), 2) + pow(0.5*a2, 2) );
    num A=sqrt(b1+b2);
    num B=sqrt(b1-b2);
    return [A,B]; //非骈，有顺序
  }

  num get a => ab[0]; // 长半轴
  num get b => ab[1]; // 短半轴
  num get c => sqrt(pow(a,2)-pow(b,2));

  bool get isDegenerate {// 判断是否退化，如果u和v平行或其中一个为零向量，则曲线退化
    return u.cross(v).len < 1e-10 || (u.len < 1e-10 && v.len < 1e-10);
  }

  num get h { //h 最直接的意义是衡量椭圆的扁平程度（扁率）。
    final a = ab[0];
    final b = ab[1];
    final numerator = pow(a - b, 2);
    final denominator = pow(a + b, 2);
    return numerator / denominator;
  }
  num get e { //e 离心率
    final a = ab[0];
    final b = ab[1];
    return sqrt(1 - pow(b / a, 2));
  }
  num get area { //面积
    return pi * ab[1] * ab[2];
  }
  num get cir { //周长
    return pi * (ab[1] + ab[2]) * (1 + (3 * h) / (10 + sqrt(4 - 3 * h)));
  }

  DNum get thetaA {
    num a1=u.pow2;
    num a2=(u.dot(v))*2;
    num a3=v.pow2;
    num b3=atan((a1-a3)/a2);
    return DNum(pi*( 1 +0.25)-b3/2, pi*( 2 +0.25)-b3/2);
  }

  DNum get thetaB {
    num a1=u.pow2;
    num a2=(u.dot(v))*2;
    num a3=v.pow2;
    num b3=atan((a1-a3)/a2);
    return DNum(pi*( 1 -0.25)-b3/2, pi*( 2 -0.25)-b3/2);
  }

  DPoint get A {
    return indexPoints(thetaA);
  }

  DPoint get B {
    return indexPoints(thetaB);
  }

  Vec get vA => (indexPoints(thetaA).p1 - p).unit;
  Vec get vB => (indexPoints(thetaB).p1 - p).unit;

  DPoint get F => DPoint.newPV(p, vA * c);

  Vec der(theta) => u * (-sin(theta)) + v * (cos(theta));

  Vec tangentVec(theta) => der(theta);

  Line tangentLine(theta){
    return Line(indexPoint(theta), tangentVec(theta));
  }

  num disP2P(Vec P, num theta){
    return P.dis(indexPoint(theta));
  }

  num derDisP2P(Vec P, num theta){
    num dx=2 * (-u.x*sin(theta) + v.x*cos(theta)) * (p.x + u.x*cos(theta) + v.x*sin(theta)-P.x);
    num dy=2 * (-u.y*sin(theta) + v.y*cos(theta)) * (p.y + u.y*cos(theta) + v.y*sin(theta)-P.y);
    return dx + dy ;
  }

  //
  num thetaClosestP2P(Vec P){
    num t0 ;
    if (u.len>=v.len) {
      if ((P-p).dot(v)>0 ){ t0=pi/2; }else{ t0=-pi/2; }
    } else {
      if ((P-p).dot(u)>0) { t0=0; }else{ t0=pi; }
    }
    num t=t0;
    num k=-0.05;
    for (var i = 0; i < 12; i++) {
      t = t + k * derDisP2P(P,t);
      k=k/exp(0.0618*i);
    }
    return t;
  }

  Vec pClosestP2P(Vec P){
    return indexPoint(thetaClosestP2P(P));
  }

  num disClosestP2P(Vec P){
    return P.dis(pClosestP2P(P));
  }

  String get type => "Conic0";

  Conic get conic => Conic().byConic0(this);

  @override
  String toString() {
    return 'Conic0(${p.toString()}, ${u.toString()}, ${v.toString()})';
  }
  

   //*/




/*
  (Vec, num) findClosestPoint(Vec P, {double tolerance = 1e-8}) {
    // 方法1：使用多个初始点确保找到全局最优
    final initialGuesses = [0.0, pi/2, pi, 3*pi/2];
    num bestTheta = 0.0;
    num bestDistance = double.infinity;

    for (final guess in initialGuesses) {
      final theta = _gradientDescent(P, guess, tolerance);
      final distance = disP2P(P, theta);

      if (distance < bestDistance) {
        bestTheta = theta;
        bestDistance = distance;
      }
    }

    return (indexPoint(bestTheta), bestTheta);
  }

  num _normalizeAngle(num theta) {
    // 将角度归一化到[-π, π]范围
    while (theta > pi) theta -= 2 * pi;
    while (theta < -pi) theta += 2 * pi;
    return theta;
  }

  num _gradientDescent(Vec P, num initialTheta, double tolerance) {
    var theta = initialTheta;
    var learningRate = 0.1;

    for (var i = 0; i < 100; i++) {
      final derivative = der_disP2P(P, theta);

      if (derivative.abs() < tolerance) {
        break;
      }

      // 自适应学习率
      theta -= learningRate * derivative;
      learningRate *= 0.95; // 缓慢衰减

      theta = _normalizeAngle(theta);
    }

    return theta;
  }

 */


}