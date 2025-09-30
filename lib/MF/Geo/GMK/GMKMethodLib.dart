library GMKMethodLib;

import '../Conic/Cir2.dart';
import '../Conic/Conic.dart';
import '../Conic/Conic0.dart';
import '../Linear/Line.dart';
import '../Linear/Vec.dart';
import 'GMKData.dart';
import 'GMKProcess.dart';
import 'GMKCore.dart';
import '../Intersection/Ins.dart' as ins;

dynamic getVar(itemFactor, gmkData) {
  //(gmkProcess.factor[0].runtimeType == String)? gmkData.data[gmkProcess.factor[0]]?.obj : gmkProcess.factor[0];
  if (itemFactor.runtimeType == String) {
    if (itemFactor.startsWith('new')) {
      String method = GMKCore.substringBetween(itemFactor, 'new', '<').trim();
      //List<dynamic> factor = GMKProcess.str2Factor(GMKCore.substringBetween(itemFactor, '<', '>').trim());
      print(method);
      //print(factor[1]);
      return Vec();
    } else {
      switch (itemFactor) {
        case '.o':
          return Vec();
        case '.i':
          return Vec.i();
        case '.j':
          return Vec.j();
        case '.k':
          return Vec.k();
        default:
          return gmkData.data[itemFactor]?.obj;
      }
    }
  } else {
    return itemFactor;
  }
}

dynamic run(GMKProcess gmkProcess, GMKData gmkData) {
  switch (gmkProcess.method) {
    case 'P':
      num x = getVar(gmkProcess.factor[0], gmkData);
      num y = getVar(gmkProcess.factor[1], gmkData);
      num z = gmkProcess.factor.length > 2
          ? getVar(gmkProcess.factor[2], gmkData)
          : 0;
      return Vec(x, y, z);
    case 'MidP':
      Vec p1 = getVar(gmkProcess.factor[0], gmkData);
      Vec p2 = getVar(gmkProcess.factor[1], gmkData);
      return p1.mid(p2);
    case 'L':
      Vec p1 = getVar(gmkProcess.factor[0], gmkData);
      Vec p2 = getVar(gmkProcess.factor[1], gmkData);
      return Line.new2P(p1, p2);
    case 'Cir':
      Vec p1 = getVar(gmkProcess.factor[0], gmkData);
      Vec p2 = getVar(gmkProcess.factor[1], gmkData);
      return Cir2.new2P(p1, p2);
    //return Cir2(Vec(), 2);
    case 'N':
      return gmkProcess.factor[0];
    case 'C0':
      Vec p1 = getVar(gmkProcess.factor[0], gmkData);
      Vec p2 = getVar(gmkProcess.factor[1], gmkData);
      Vec p3 = getVar(gmkProcess.factor[2], gmkData);
      return Conic0(p1, p2, p3);
    case 'Ins':
      dynamic obj1 = getVar(gmkProcess.factor[0], gmkData);
      dynamic obj2 = getVar(gmkProcess.factor[1], gmkData);
      return ins.Ins(obj1, obj2);
    case 'F':
      dynamic obj1 = getVar(gmkProcess.factor[0], gmkData);
      return obj1.F;
    default:
      return null;
  }
}
