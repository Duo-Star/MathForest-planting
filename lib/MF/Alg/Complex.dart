// Complex.dart
import 'dart:math' as math;
import '../Alg/Funcs.dart' as mffuncs;
import 'dart:ui';
import '../Geo/Linear/Vec.dart';

class Complex {
  num a;
  num b;

  Complex([num? a, num? b])
      : a = a ?? 0,
        b = b ?? 0;

  // 静态常量
  static Complex zero = Complex(0, 0);
  static Complex one = Complex(1, 0);
  static Complex i = Complex(0, 1);
  static Complex get nan => Complex(0/0, 0/0);

  // 获取器
  num get x => a;
  num get y => b;
  num get len => math.sqrt(a * a + b * b);
  num get r => len;
  num get magnitude => len;
  num get argument => math.atan2(b, a); // 辐角/相位
  num get real => a;
  num get imaginary => b;

  // 转换为其他类型
  Vec get vec => Vec(a, b);
  Offset get offset => Offset(a.toDouble(), b.toDouble());

  // 判断方法
  bool get isReal => b == 0;
  bool get isImaginary => a == 0;
  bool get isZero => a == 0 && b == 0;
  bool get isNaN => a.isNaN || b.isNaN;

  // 一元运算
  Complex conjugate() => Complex(a, -b);
  Complex negate() => Complex(-a, -b);
  Complex reciprocal() { //复数的倒数
    final denominator = a * a + b * b;
    return Complex(a / denominator, -b / denominator);
  }

  // 基本二元运算
  Complex operator +(dynamic other) {
    if (other is Complex) {
      return Complex(a + other.a, b + other.b);
    } else if (other is num) {
      return Complex(a + other, b);
    }
    throw ArgumentError('复数只能与复数和数相加');
  }

  Complex operator -(dynamic other) {
    if (other is Complex) {
      return Complex(a - other.a, b - other.b);
    } else if (other is num) {
      return Complex(a - other, b);
    }
    throw ArgumentError('复数只能与复数和数相减');
  }

  Complex operator *(dynamic other) {
    if (other is Complex) {
      return Complex(
        a * other.a - b * other.b,
        a * other.b + b * other.a,
      );
    } else if (other is num) {
      return Complex(a * other, b * other);
    }
    throw ArgumentError('复数只能与复数和数相乘');
  }

  Complex operator /(dynamic other) {
    if (other is Complex) {
      final denominator = other.a * other.a + other.b * other.b;
      return Complex(
        (a * other.a + b * other.b) / denominator,
        (b * other.a - a * other.b) / denominator,
      );
    } else if (other is num) {
      return Complex(a / other, b / other);
    }
    throw ArgumentError('复数只能与复数和数相除');
  }

  Complex operator -() => Complex(-a, -b);

  // 幂运算
  Complex pow(dynamic other) {
    final n = _toComplex(other);
    if (isZero && n.isZero) return Complex(1, 0); // 0^0 = 1
    return (ln() * n).exp();
  }

  // 自然对数
  Complex ln() {
    if (isZero) return Complex.zero; // 或者可以返回负无穷
    return Complex(math.log(r), argument);
  }

  // 指数函数
  Complex exp() {
    final expReal = math.exp(a);
    return Complex(
      expReal * math.cos(b),
      expReal * math.sin(b),
    );
  }

  // 三角函数
  Complex sin() {
    return Complex(
      math.sin(a) * mffuncs.cosh(b),
      math.cos(a) * mffuncs.sinh(b),
    );
  }

  Complex cos() {
    return Complex(
      math.cos(a) * mffuncs.cosh(b),
      -math.sin(a) * mffuncs.sinh(b),
    );
  }

  Complex tan() {
    return sin() / cos();
  }

  // 双曲函数
  Complex sinh() {
    return Complex(
      mffuncs.sinh(a) * math.cos(b),
      mffuncs.cosh(a) * math.sin(b),
    );
  }

  Complex cosh() {
    return Complex(
      mffuncs.cosh(a) * math.cos(b),
      mffuncs.sinh(a) * math.sin(b),
    );
  }

  Complex tanh() {
    return sinh() / cosh();
  }

  // 反三角函数
  Complex asin() {
    final i = Complex.i;
    return -i * ((this * i) + (one - this * this).pow(0.5)).ln();
  }

  Complex acos() {
    final i = Complex.i;
    return -i * (this + i * (one - this * this).pow(0.5)).ln();
  }

  Complex atan() {
    final i = Complex.i;
    return (i / Complex(2, 0)) *
        ((i + this) / (i - this)).ln();
  }

  // 辐角计算（修正版本）
  num get phi {
    if (isZero) return 0/0;
    return math.atan2(y, x);
  }

  // 极坐标转换
  List<num> get polar => [r, phi];
  static Complex fromPolar(num r, num theta) {
    return Complex(
      r * math.cos(theta),
      r * math.sin(theta),
    );
  }

  // 实部和虚部
  num get re => a;
  num get im => b;
  num get abs => len;
  Complex get conj => conjugate();

  // 工具方法
  List<num> salvage() => [a, b];

  Complex _toComplex(dynamic value) {
    if (value is Complex) return value;
    if (value is num) return Complex(value, 0);
    throw ArgumentError('值必须为数字或复数');
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Complex && a == other.a && b == other.b;
  }

  @override
  int get hashCode => Object.hash(a, b);

  // 字符串表示
  @override
  String toString() {
    if (b == 0) return a.toString();
    if (a == 0) {
      if (b == 1) return 'i';
      if (b == -1) return '-i';
      return '${b}i';
    }
    if (b == 1) return '$a + i';
    if (b == -1) return '$a - i';
    final imaginaryPart = b.isNegative ? '${b}i' : '+${b}i';
    return '$a$imaginaryPart';
  }

  // 解析字符串
  static Complex parse(String s) {
    s = s.trim().replaceAll(' ', '');

    if (s == 'i') return Complex.i;
    if (s == '-i') return Complex(0, -1);

    if (s.endsWith('i')) {
      final parts = s.split(RegExp(r'(?=[+-])'));
      if (parts.length == 1) {
        // 纯虚数
        final imagStr = s.substring(0, s.length - 1);
        final imag = imagStr.isEmpty ? 1 : num.parse(imagStr);
        return Complex(0, imag);
      } else {
        // 复数 a + bi
        final realStr = parts[0];
        var imagStr = parts[1].substring(0, parts[1].length - 1);
        if (imagStr.isEmpty) imagStr = '1';
        if (imagStr == '+') imagStr = '1';
        if (imagStr == '-') imagStr = '-1';
        return Complex(num.parse(realStr), num.parse(imagStr));
      }
    }

    // 纯实数
    return Complex(num.parse(s));
  }


}

// 扩展运算符
extension ComplexOperators on num {
  Complex operator +(Complex c) => Complex(this) + c;
  Complex operator -(Complex c) => Complex(this) - c;
  Complex operator *(Complex c) => Complex(this) * c;
  Complex operator /(Complex c) => Complex(this) / c;

  Complex toComplex() => Complex(this);
}

