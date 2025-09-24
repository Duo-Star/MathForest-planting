import 'dart:math' as math;
import '../Funcs.dart' as funcs;
import '../Fertile/DNum.dart';
import '../Fertile/TNum.dart';
import '../Fertile/QNum.dart';
import '../Complex.dart';
import '../Funcs.dart' as funcs;

import 'Linear.dart' as Linear;
import 'Polynomial.dart' as Polynomial;
import 'Trigonometric.dart' as Trigonometric;

class EquSolver {

  EquSolver();

  static (num, num) solve2x2LinearSystem(num a1, num b1, num c1, num a2, num b2, num c2)
  => Linear.solve2x2LinearSystem(a1, b1, c1, a2, b2, c2);

  static DNum solveQuadratic(num a, num b, num c)
  => Polynomial.solveQuadratic(a, b, c);


  static DNum solveComplexQuadratic(Complex a, Complex b, Complex c)
  => Polynomial.solveComplexQuadratic(a, b, c);


  static TNum solveCubic(Complex a, Complex b, Complex c, Complex d)
  => Polynomial.solveCubic(a, b, c, d);


  static QNum solveQuartic(Complex a, Complex b, Complex c, Complex d, Complex e)
  => Polynomial.solveQuartic(a, b, c, d, e);


  static DNum solveSinForMainRoot(num a, num w, num p, num c)
  => Trigonometric.solveSinForMainRoot(a, w, p, c);


  static DNum solveCosSinForMainRoot(num u, num v, num c)
  => Trigonometric.solveCosSinForMainRoot(u, v, c);

}

