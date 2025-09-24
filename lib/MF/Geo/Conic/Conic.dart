// Conic泛类
// 包含 Conic0 1 2 XLine HLine
import 'Circle.dart';
import 'Conic0.dart';
import 'Conic1.dart';
import 'Conic2.dart';
import 'XLine.dart';
import 'HLine.dart';
import '../Linear/Vec.dart';

class Conic {
  Vec p;
  Vec u;
  Vec v;
  Vec p1;
  Vec p2;

  Conic([Vec? p, Vec? u, Vec? v, Vec? p1, Vec? p2]): //中心，共轭方向1，共轭方向2
        p = p ?? Vec(),
        u = u ?? Vec(0,1),
        v = v ?? Vec(1),
        p1 = p1 ?? Vec(1),
        p2 = p2 ?? Vec(1);


  String type = "Conic0";

   get reveal {
     if (type=="Conic0"){
       return Conic0(p, u, v);
     } else if (type=="Conic1") {
       return Conic1(p, u, v);
     } else if (type=="Conic2") {
       return Conic2(p, u, v);
     } else if (type=="XLine") {
       return XLine(p, u, v);
     } else if (type=="HLine") {
       return HLine(p1, p2, v);
     }
   }

  Conic byConic0(Conic0 c0) => Conic(c0.p, c0.u ,c0.v);
  Conic byConic1(Conic1 c1) => Conic(c1.p, c1.u ,c1.v);
  Conic byConic2(Conic2 c2) => Conic(c2.p, c2.u ,c2.v);



}