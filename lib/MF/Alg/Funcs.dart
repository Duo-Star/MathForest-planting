//library funcs;

import "dart:math" as math;


acos(x) => math.acos(x);
asin(x) => math.asin(x);
atan(x) => math.atan(x);
atan2(x,y) => math.atan2(x,y);

sin(x) => math.sin(x);
cos(x) => math.cos(x);
tan(x) => math.tan(x);

sgn(x){
  if(x>0){ return 1;
  }else if(x==0){ return 0;
  }else if(x<0){ return -1;
  }
}

sinh( x) {// 双曲正弦函数
  return (math.exp(x) - math.exp(-x)) / 2;
}

cosh( x) {// 双曲余弦函数
  return (math.exp(x) + math.exp(-x)) / 2;
}

tanh( x) {// 双曲正切函数
  return sinh(x) / cosh(x);
}

coth( x) {// 双曲余切函数
  return cosh(x) / sinh(x);
}

sech( x) {// 双曲正割函数
  return 1 / cosh(x);
}

csch( x) {// 双曲余割函数
  return 1 / sinh(x);
}

asinh( x) {// 反双曲正弦函数
  return math.log(x + math.sqrt(x * x + 1));
}

acosh( x) {// 反双曲余弦函数
  if (x < 1) { throw ArgumentError('acosh is only defined for x >= 1'); }
  return math.log(x + math.sqrt(x * x - 1));
}

atanh( x) {// 反双曲正切函数
  if (x <= -1 || x >= 1) { throw ArgumentError('atanh is only defined for -1 < x < 1'); }
  return 0.5 * math.log((1 + x) / (1 - x));
}

num floor(num x) => x.floor();
num ceil(num x) => x.ceil();
num mod(num x, num y) => x- floor(x/y)*y;
num pow(num x, num y) => math.pow(x, y);

/// 计算阶乘
int factorial(int n) {
  if (n <= 1) return 1;
  return n * factorial(n - 1);
}

/// 计算斐波那契数列的第 n 项
int fibonacci(int n) {
  if (n <= 2) return 1;
  return fibonacci(n - 1) + fibonacci(n - 2);
}

