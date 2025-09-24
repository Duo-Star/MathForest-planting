// ignore_for_file: unnecessary_library_name

//数学 森林
library MathForest;


import 'dart:math' as math;

//代数
export 'Alg/main.dart';

//几何
export 'Geo/main.dart';

//物理
export 'Phy/main.dart';

//统计
export 'Sta/main.dart';




import 'package:learnfl/MF/Alg/Complex.dart';

import  'Alg/Funcs.dart' as funcs;

String Version = '1.0.1';
String Author = 'Duo';
String Tree = 'Nature(Duo) -#153V[Forest].Math';
int N_CODE = 516498410835724;


num nan = 0/0;
num inf = 1/0;
num pi = math.pi;
Complex i = Complex.i;

acos(x) => funcs.acos(x);
asin(x) => funcs.asin(x);
atan(x) => funcs.atan(x);
atan2(x,y) => funcs.atan2(x,y);
sin(x) => funcs.sin(x);

factorial(n) => funcs.factorial(n);
fibonacci(n) => funcs.fibonacci(n);
sgn(n) => funcs.sgn(n);

