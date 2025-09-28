import 'Monxiv/GraphOBJ.dart';

import 'GMKData.dart';
import 'GMKStructure.dart';
import 'GMKProcess.dart';
import 'GMKMethodLib.dart' as GMKMethodLib;

import 'Monxiv/GraphOBJ.dart';

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
      gmkData.data[itemGMKProcess.label] =
          GraphOBJ( GMKMethodLib.run(itemGMKProcess, gmkData));
    }
    return gmkData;
  }

  String get outputSource{
    String source = '``这是gmk-source``';
    int structureStepCount =structure.stepCount;
    Function factor2Str = GMKProcess.factor2Str;
    for (var i = 1; i <= structureStepCount; i++) {
      GMKProcess igp = structure.indexStep(i);
      source =
      '$source\n@${igp.label} is ${igp.method} of ${factor2Str(igp.factor)}';

    }
    return source;
  }


  String removeComments(String input) {
    // 匹配 ``任意内容`` 格式的注释
    // .*? 表示非贪婪匹配，可以跨行匹配（因为使用了 dotAll: true）
    final regex = RegExp(r'``.*?``', multiLine: true, dotAll: true);
    return input.replaceAll(regex, '');
  }

  String substringBetween(String input, String startChar, String endChar) {
    int startIndex = input.indexOf(startChar);
    int endIndex = input.indexOf(endChar);

    if (startIndex == -1 || endIndex == -1 || startIndex >= endIndex) {
      return ''; // 如果没找到起始或结束字符，返回空字符串
    }

    // 从起始字符的下一个位置开始，到结束字符的位置
    return input.substring(startIndex + startChar.length, endIndex);
  }

  bool loadSourceStructure(String source){
    String source_ = removeComments(source);
    List<String> lines = source_.split('\n');
    Function str2Factor = GMKProcess.str2Factor;
    for (var line in lines) {
      //GMKProcess(this.method, this.label, this.factor);
      if (line.startsWith('@')) {
        //剔除首尾空格 - trim()
        String label = substringBetween(line, '@', ' is ').trim();
        String method = substringBetween(line, ' is ', ' of ').trim();
        List<dynamic> factor = str2Factor(substringBetween(line, ' of ', ';'));
        structure.addStep(GMKProcess(method, label, factor));

      }

    }

    return true;
  }


}