import 'dart:math';
class QNum {
  dynamic n1;
  dynamic n2;
  dynamic n3;
  dynamic n4;

  QNum([dynamic n1, dynamic n2, dynamic n3, dynamic n4]):
        n1 = n1 ?? -1,
        n2 = n2 ?? 1,
        n3 = n3 ?? 2,
        n4 = n4 ?? 3;

  @override
  String toString() {
    return 'TNum(${n1.toString()}, ${n2.toString()}, ${n3.toString()}, ${n4.toString()})';
  }

}