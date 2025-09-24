import 'Vec.dart';

class Plane {
  Vec p;//平面上一点
  Vec n;//平面法向量

  Plane([Vec? p,Vec? n]):
      p=p??Vec(),
      n=n??Vec(0,0,1);
  
}