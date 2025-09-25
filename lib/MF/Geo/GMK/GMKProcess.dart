import 'GMKLabel.dart';

class GMKProcess {
  //..[name] = tool.method(factor)
  String method = "";
  GMKLabel label = GMKLabel("");
  List<dynamic> factor = [];

  GMKProcess(String method, GMKLabel label, List<dynamic> factor):
      method = method,
      label = label,
      factor = factor;



}
/*
..GMKProcess("midP", gmkLabel("C"),
 [GMKLabel("A"), GMKLabel("B")])
 */
