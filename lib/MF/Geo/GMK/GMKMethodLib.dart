library GMKMethodLib;

import '../Conic/Circle.dart';
import '../Linear/Line.dart';
import '../Linear/Vec.dart';
import 'GMKData.dart';
import 'GMKProcess.dart';

dynamic run(GMKProcess gmkProcess, GMKData gmkData) {
  switch (gmkProcess.method) {
    case 'P':
      return Vec.fromList(gmkProcess.factor);
    case 'midP':
      Vec p1 = gmkData.data[gmkProcess.factor[0]]?.obj;
      Vec p2 = gmkData.data[gmkProcess.factor[1]]?.obj;
      return p1.mid(p2);
    case 'L':
      Vec p1 = gmkData.data[gmkProcess.factor[0]]?.obj;
      Vec p2 = gmkData.data[gmkProcess.factor[1]]?.obj;
      return Line.new2P(p1, p2);
    case 'Cir':
      Vec p1 = gmkData.data[gmkProcess.factor[0]]?.obj;
      Vec p2 = gmkData.data[gmkProcess.factor[1]]?.obj;
      return Circle.new2P2d(p1, p2);

    default:
  }
}
