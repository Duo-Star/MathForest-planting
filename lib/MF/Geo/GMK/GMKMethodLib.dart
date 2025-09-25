library GMKMethodLib;
import '../Linear/Vec.dart';
import 'GMKData.dart';
import 'GMKProcess.dart';

dynamic run(GMKProcess gmkProcess, GMKData gmkData){
  switch (gmkProcess.method) {
    case 'P':
      return Vec.fromList(gmkProcess.factor);
    case 'midP':
      Vec p1 = gmkProcess.factor[0].getVar(gmkData);
      Vec p2 = gmkProcess.factor[1].getVar(gmkData);
      return p1.mid(p2);
    default:

  }
}
