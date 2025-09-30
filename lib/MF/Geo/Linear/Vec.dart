//Vec
import 'dart:math' as math;
import 'dart:ui';
import 'package:learnfl/MF/main.dart';

import 'Angle.dart';

class Vec {
  num x;
  num y;
  num z;

  Vec([num x = 0.0, num y = 0.0, num z = 0.0]) : x = x, y = y, z = z;

  Vec.newAL(Angle a, num l)
    : x = math.cos(a.theta) * math.cos(a.phi) * l,
      y = math.sin(a.theta) * math.cos(a.phi) * l,
      z = math.sin(a.phi) * l;

  Vec.fromList(List ls)
    : x = ls[0] ?? 0.0,
      y = ls[1] ?? 0.0,
      z = (ls.length > 2) ? (ls[2] ?? 0.0) : 0.0;

  Vec.zero() : this(0.0, 0.0, 0.0);

  Vec.i() : this(1.0, 0.0, 0.0);
  Vec.j() : this(0.0, 1.0, 0.0);
  Vec.k() : this(0.0, 0.0, 1.0);
  Vec.inf() : this(1 / 0, 1 / 0, 1 / 0);
  Vec.nan() : this(0 / 0, 0 / 0, 0 / 0);

  Vec operator +(Vec other) => Vec(x + other.x, y + other.y, z + other.z);
  Vec operator -(Vec other) => Vec(x - other.x, y - other.y, z - other.z);
  Vec operator *(num scalar) => Vec(x * scalar, y * scalar, z * scalar);
  Vec operator /(num scalar) => Vec(x / scalar, y / scalar, z / scalar);
  Vec operator -() => Vec(-x, -y, -z);
  num operator ^(num index) =>
      math.pow(x, index) + math.pow(y, index) + math.pow(z, index);

  Vec add(Vec other) => this + other;
  Vec sub(Vec other) => this - other;
  Vec scale(num scalar) => this * scalar;
  Vec div(num scalar) => this / scalar;
  num pow_(num index) => this ^ index;

  //### tips ###  this 可以省略
  //num cosAngle(Vec other)=> this.dot(other)/(this.len * other.len);
  num cosAngle(Vec other) => dot(other) / (len * other.len);
  Vec projectVec(Vec other) => other.unit * project(other);
  num project(Vec other) => dot(other) / (other.len);
  num dot(Vec other) => x * other.x + y * other.y + z * other.z;
  Vec mid(Vec other) => (this + other) * .5;
  num cos(Vec other) => dot(other) / len * other.len;
  num ang(Vec other) =>
      math.acos(cosAngle(other).clamp(-1.0, 1.0)); // 计算与另一个向量的夹角（弧度，范围 0 到 π）

  Vec tp(Vec p, Vec u, Vec v, Vec n) => p + u * x + v * y + n * z;
  Vec tp2d(Vec p, Vec u, Vec v) => p + u * x + v * y;

  Vec roll(Vec n, num w) =>
      scale(math.cos(w)) +
      (n.cross(this)).scale(math.sin(w)) +
      n.scale((n.dot(this)) * (1 - math.cos(w)));

  Vec roll2d(num w) => roll(Vec.k(), w);
  Vec roll2d_90() => Vec(-y, x, 0.0);
  Vec roll2dAround(Vec p, num w) => p + (this - p).roll2d(w);

  Vec get floor => Vec(x.floor(), y.floor(), z.floor());
  Vec get negate => -this;
  Vec get ops => negate;
  num get pow2 => this ^ 2;
  num get len => math.sqrt(x * x + y * y + z * z);
  Vec get unit => len > 0 ? this / len : Vec.zero();
  Offset get offset {
    if (x.isNaN || y.isNaN) {
      return Offset(1/0, 1/0);
    }
    return Offset(x.toDouble(), y.toDouble());
  }

  (num, num) RSV(Vec a, Vec b) {
    Vec p = this;
    num dotPA = p.dot(a);
    num dotPB = p.dot(b);
    num dotAB = a.dot(b);
    num aPow2 = a.pow2;
    num bPow2 = b.pow2;
    num lam =
        (bPow2 * dotPA - dotPB * dotAB) / (aPow2 * bPow2 - math.pow(dotAB, 2));
    num mu =
        (aPow2 * dotPB - dotPA * dotAB) / (aPow2 * bPow2 - math.pow(dotAB, 2));
    return (lam, mu);
  }

  Vec cross(Vec other) => Vec(
    y * other.z - z * other.y,
    z * other.x - x * other.z,
    x * other.y - y * other.x,
  );
  num dis(Vec other) => (this - other).len;

  @override
  String toString() => 'Vec($x, $y, $z)';

  @override
  bool operator ==(Object other) =>
      other is Vec && x == other.x && y == other.y && z == other.z;

  @override
  int get hashCode => Object.hash(x, y, z);
}
