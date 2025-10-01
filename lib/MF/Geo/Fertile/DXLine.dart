import '../Conic/XLine.dart';

class DXLine {
  XLine xl1;
  XLine xl2;

  DXLine([XLine? xl1, XLine? xl2]) : xl1 = xl1 ?? XLine(), xl2 = xl2 ?? XLine();

  DXLine get angB => DXLine(
    XLine(xl1.p, xl1.u.angB(xl1.v), xl1.u.angB(-xl1.v)),
    XLine(xl2.p, xl2.u.angB(xl2.v), xl2.u.angB(-xl2.v)),
  );


}
