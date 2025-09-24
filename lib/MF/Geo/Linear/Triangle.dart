//Triangle
import 'dart:math';
import 'Vec.dart';

class Triangle{
  Vec a;
  Vec b;
  Vec c;

  Triangle([Vec? a, Vec? b, Vec? c]): //三个点
  a = a ?? Vec.i(),
  b = b ?? Vec.j(),
  c = c ?? Vec.k();

  Vec get u => a-c;
  Vec get v => b-c;

  num get dotUV => u.dot(v);
  num get powU => u.pow2;
  num get powV => v.pow2;

  num get aLen => (b - c).len;// 边a的长度
  num get bLen => (a - c).len;// 边b的长度
  num get cLen => (a - b).len;// 边c的长度

  get area => u.cross(v).len / 2;
  get cir => aLen + bLen + cLen;

  Vec get iO { //内心
    return (a * aLen + b * bLen + c * cLen) / cir;
  }
  Vec get oO { //外心
    num m = 2 * ( pow(dotUV,2) - powV*powU );
    num uL = (powV*(dotUV-powU)) / m;
    num vL = (powU*(dotUV-powV)) / m;
    return c + u*uL + v*vL;
  }
  Vec get hO { //垂心
    num m =  pow(dotUV,2) - powV*powU;
    num uL = (dotUV*(dotUV-powV)) / m;
    num vL = (dotUV*(dotUV-powU)) / m;
    return c + u*uL + v*vL;
  }
  Vec get gO { //重心
    return (a + b + c)*(1/3);
  }


}