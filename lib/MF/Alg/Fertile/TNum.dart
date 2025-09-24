import 'dart:math';
class TNum {
  dynamic n1;
  dynamic n2;
  dynamic n3;

  TNum([dynamic n1, dynamic n2, dynamic n3]):
        n1 = n1 ?? -1,
        n2 = n2 ?? 1,
        n3 = n3 ?? 2;

  static TNum nan = TNum(0/0, 0/0, 0/0);
  static TNum all(dynamic n) => TNum(n, n, n);


  @override
  String toString() {
    return 'TNum(${n1.toString()}, ${n2.toString()}, ${n3.toString()})';
  }

}