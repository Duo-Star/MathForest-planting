import 'GMKData.dart';

class GMKLabel {
  String name = '';
  GMKLabel(this.name);

  getVar(GMKData gmkData)=> gmkData.data[name]?.obj;
}