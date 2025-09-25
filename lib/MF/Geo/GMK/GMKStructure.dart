import 'GMKProcess.dart';

class GMKStructure {
  List<GMKProcess> step = [];

  GMKStructure(this.step);

  int get stepCount => step.length;

  GMKProcess indexStep(int n){
    return step[n-1];
  }

}
