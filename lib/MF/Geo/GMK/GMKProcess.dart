
class GMKProcess {
  //..[name] = tool.method(factor)
  String method = "";
  String label = "";
  List<dynamic> factor = [];

  GMKProcess(this.method, this.label, this.factor);


}

/*
..GMKProcess("midP", gmkLabel("C"),
 [GMKLabel("A"), GMKLabel("B")])
 */
