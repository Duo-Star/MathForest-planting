library;

import 'dart:math' as math;
import '../Funcs.dart' as funcs;
import '../Fertile/DNum.dart';
import '../Fertile/TNum.dart';
import '../Fertile/QNum.dart';
import '../Complex.dart';
import '../Funcs.dart' as funcs;

DNum solveQuadratic(num a, num b, num c){
  num delta = math.pow(b, 2) - a * c * 4;
  num n1 = (-b + math.sqrt(delta))/(a*2);
  num n2 = (-b - math.sqrt(delta))/(a*2);
  return DNum(n1, n2);
}

DNum solveComplexQuadratic(Complex a, Complex b, Complex c){
  Complex delta = b.pow(2) - a * c * 4;
  var n1 = (-b + delta.sqrt)/(a*2);
  var n2 = (-b - delta.sqrt)/(a*2);
  return DNum(n1, n2);
}

TNum solveCubic(Complex a, Complex b, Complex c, Complex d) {
  // 使用卡尔达诺公式求解一元三次方程: a*x^3 + b*x^2 + c*x + d = 0

  if (a.isZero) {
    // 如果a=0，退化为二次方程
    if (b.isZero) {
      // 如果b=0，退化为一次方程
      if (c.isZero) {
        return d.isZero ? TNum(Complex.zero, Complex.zero, Complex.zero) : TNum.nan;
      }
      return TNum.all(-d/c);
    }
    var quadraticRoots = solveComplexQuadratic(b, c, d);
    return TNum(quadraticRoots.n1, quadraticRoots.n2, quadraticRoots.n2);
  }

  // 归一化方程: x^3 + p*x^2 + q*x + r = 0
  Complex p = b / a;
  Complex q = c / a;
  Complex r = d / a;

  // 消去二次项: 令 x = y - p/3，得到 y^3 + m*y + n = 0
  Complex p2 = p * p;
  Complex m = q - p2 / 3;
  Complex n =  (p2 * p * 2 -  p * q * 9 + r * 27) / 27;

  // 判别式
  Complex delta = (n * n / 4) + (m * m * m / 27);

  // 卡尔达诺公式的核心部分
  Complex sqrtDelta = delta.sqrt;
  Complex u = (-n / 2 + sqrtDelta).pow(1/3);
  Complex v = (-n / 2 - sqrtDelta).pow(1/3);

  // 三个根
  Complex y1 = u + v;
  Complex omega = Complex(-0.5, math.sqrt(3)/2);  // 单位立方根
  Complex omega2 = omega * omega;
  Complex y2 = omega * u + omega2 * v;
  Complex y3 = omega2 * u + omega * v;

  // 转换回 x
  Complex shift = p / 3;
  return TNum( y1 - shift, y2 - shift, y3 - shift);
}


QNum solveQuartic(Complex a, Complex b, Complex c, Complex d, Complex e) {
  // 使用费拉里方法求解一元四次方程: a*x^4 + b*x^3 + c*x^2 + d*x + e = 0

  if (a.isZero) {
    // 如果a=0，退化为三次方程
    TNum cubRoot = solveCubic(b, c, d, e);
    return QNum(cubRoot.n1, cubRoot.n2, cubRoot.n3, cubRoot.n3);
  }

  // 归一化方程: x^4 + p*x^3 + q*x^2 + r*x + s = 0
  Complex p = b / a;
  Complex q = c / a;
  Complex r = d / a;
  Complex s = e / a;

  // 消去三次项: 令 x = y - p/4
  Complex p2 = p * p;
  Complex p3 = p2 * p;
  Complex p4 = p3 * p;

  Complex y4Coeff = Complex.one;  // y^4 系数为1
  Complex y2Coeff = q - (p2 * 3) / 8;
  Complex yCoeff = (p3 / 8) - (p * q / 2) + r;
  Complex constant = (p4 * -3 / 256) + (p2 * q / 16) - (p * r / 4) + s;

  // 现在方程为: y^4 + y2Coeff*y^2 + yCoeff*y + constant = 0

  // 寻找一个三次方程的解作为参数
  Complex cubicA = Complex.one;
  Complex cubicB = -y2Coeff;
  Complex cubicC = constant * -4;
  Complex cubicD = y2Coeff * constant * 4 - yCoeff * yCoeff;

  var cubicRoots = solveCubic(cubicA, cubicB, cubicC, cubicD);
  Complex m =  cubicRoots.n1;

  // 解两个二次方程
  Complex sqrt2m = (m * 2).sqrt;
  Complex term1 = y2Coeff + m;
  Complex term2 = yCoeff / sqrt2m;

  // 第一个二次方程: y^2 + sqrt(2m)*y + (m + y2Coeff/2 + yCoeff/(2*sqrt(2m))) = 0
  Complex quad1A = Complex.one;
  Complex quad1B = sqrt2m;
  Complex quad1C = (term1 + term2) / 2;

  // 第二个二次方程: y^2 - sqrt(2m)*y + (m + y2Coeff/2 - yCoeff/(2*sqrt(2m))) = 0
  Complex quad2A = Complex.one;
  Complex quad2B = -sqrt2m;
  Complex quad2C = (term1 - term2) / 2;

  // 解两个二次方程
  var roots1 = solveComplexQuadratic(quad1A, quad1B, quad1C);
  var roots2 = solveComplexQuadratic(quad2A, quad2B, quad2C);

  // 合并根并转换回 x
  Complex shift = p / 4;

  return QNum(roots1.n1-shift,
      roots1.n2-shift,
      roots2.n1-shift,
      roots2.n2-shift);
}