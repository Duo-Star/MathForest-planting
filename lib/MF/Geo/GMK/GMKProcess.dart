
//import 'package:flutter/foundation.dart';


class GMKProcess {
  //..[name] = tool.method(factor)
  String method = "";
  String label = "";
  String type = '?';
  List<dynamic> factor = [];

  GMKProcess(this.method, this.label, this.factor);



  static String factor2Str(List<dynamic> factor) {
    String str = '';
    for (int i = 0; i < factor.length; i++) {
      dynamic item = factor[i];
      String division = (i+1 == factor.length)? ";" : ',';
      switch (item.runtimeType) {
        case const (String):
          str = '$str<$item>$division ';
        default :
          str = '$str${item.toString()}$division ';
      }
    }
    return str;
  }

  //注意Factor内部只可能是字符或数或布尔值（布尔值str显示为T or F）
  static List<dynamic> str2Factor(String str) {
    List<dynamic> factors = [];

    // 移除末尾的分号和空格
    str = str.trim();
    if (str.endsWith(';')) {
      str = str.substring(0, str.length - 1).trim();
    }

    // 按逗号分割，但要处理 < > 内的逗号
    List<String> parts = [];
    StringBuffer currentPart = StringBuffer();
    bool inAngleBrackets = false;

    for (int i = 0; i < str.length; i++) {
      String char = str[i];

      if (char == '<') {
        inAngleBrackets = true;
        currentPart.write(char);
      } else if (char == '>') {
        inAngleBrackets = false;
        currentPart.write(char);
      } else if (char == ',' && !inAngleBrackets) {
        // 不在尖括号内的逗号作为分隔符
        String part = currentPart.toString().trim();
        if (part.isNotEmpty) {
          parts.add(part);
        }
        currentPart.clear();
      } else {
        currentPart.write(char);
      }
    }

    // 添加最后一部分
    String lastPart = currentPart.toString().trim();
    if (lastPart.isNotEmpty) {
      parts.add(lastPart);
    }

    // 解析每个部分
    for (String part in parts) {
      part = part.trim();
      if (part.isEmpty) continue;

      if (part.startsWith('<') && part.endsWith('>')) {
        // 字符串类型，去掉尖括号
        String content = part.substring(1, part.length - 1);
        factors.add(content.trim());
      } else {
        // 尝试解析为布尔值、数字或保持原字符串
        dynamic value = _parseValue(part);
        factors.add(value);
      }
    }

    return factors;
  }

  // 解析值：布尔值 -> 数字 -> 字符串
  static dynamic _parseValue(String value) {
    // 检查布尔值
    if (value == 'T') return true;
    if (value == 'F') return false;

    // 尝试解析为 int
    int? intValue = int.tryParse(value);
    if (intValue != null) return intValue;

    // 尝试解析为 double
    double? doubleValue = double.tryParse(value);
    if (doubleValue != null) return doubleValue;

    // 无法解析，返回原始字符串
    return value;
  }

}

/*
..GMKProcess("midP", gmkLabel("C"),
 [GMKLabel("A"), GMKLabel("B")])
 */
