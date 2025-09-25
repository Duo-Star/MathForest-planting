import 'package:learnfl/MF/Geo/Monxiv/GraphOBJ.dart';

import 'GMKData.dart';
import 'GMKStructure.dart';
import 'GMKProcess.dart';
import 'GMKMethodLib.dart' as GMKMethodLib;

import '../Monxiv/GraphOBJ.dart';


/*

 */

class GMKCore {
  GMKStructure structure = GMKStructure([]);
  GMKData gmkData = GMKData({});

  GMKCore();

  void loadStructure(GMKStructure structure_){
    structure = structure_;
  }


  GMKData get run{
    int structureStepCount =structure.stepCount;
    for (var i = 1; i <= structureStepCount; i++) {
      GMKProcess itemGMKProcess = structure.indexStep(i);
      gmkData.data[itemGMKProcess.label.name] =
          GraphOBJ( GMKMethodLib.run(itemGMKProcess, gmkData));
    }
    return gmkData;
  }




}