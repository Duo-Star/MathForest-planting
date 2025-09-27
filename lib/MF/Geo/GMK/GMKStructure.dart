import 'GMKProcess.dart';

class GMKStructure {
  List<GMKProcess> step = [];

  GMKStructure(this.step);

  int get stepCount => step.length;

  GMKProcess indexStep(int n){
    return step[n-1];
  }

  bool addStep(GMKProcess gmkProcess){
    step.add(gmkProcess);
    return true;
  }

}
