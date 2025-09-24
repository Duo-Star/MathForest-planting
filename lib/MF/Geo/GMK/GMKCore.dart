import 'GMKData.dart';
import 'GMKStructure.dart';

class GMKCore {
  GMKStructure structure = GMKStructure([]);

  GMKCore();

  void loadStructure(GMKStructure structure_){
    structure = structure_;
  }

  GMKData get run{
    return GMKData([]);
  }


}