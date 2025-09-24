import 'GMKLabel.dart';

class GMKProcess {
  //..[name] = tool.method(factor)
  String method = "";
  GMKLabel name = GMKLabel("");
  List<dynamic> factor = [];

  GMKProcess(String method,GMKLabel name,List<dynamic> factor):
      method = method,
      name = name,
      factor = factor;

}
/*
..GMKProcess("midP", gmkLabel("C"),
 [GMKLabel("A"), GMKLabel("B")])
 */
