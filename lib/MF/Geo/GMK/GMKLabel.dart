import 'GMKData.dart';

class GMKLabel {
  String name = '';
  GMKLabel(String name): name = name;

  getVar(GMKData gmkData)=> gmkData.data[name]?.obj;
}