import 'dart:math';

class RandomMaster {
  String type_;
  dynamic data;

  RandomMaster(this.type_, this.data);

  // 模拟 __call 行为
  static RandomMaster call(String type_, dynamic data) {
    return RandomMaster(type_, data);
  }

  // 模拟 __index 和 new 方法
  static RandomMaster new_(String type_, dynamic data) {
    data['type_'] = type_;
    return RandomMaster(type_, data);
  }

  static double random_(double a, double b, [double s = 0.1]) {
    Random random = Random();
    int min = (a / s).floor();
    int max = (b / s).floor();
    return random.nextInt(max - min + 1) * s + min * s;
  }

  static double rand() {
    return random_(0, 1, 1e-10);
  }

  double compute() {
    if (type_ == "uniform") {
      Map<String, dynamic> rm = data as Map<String, dynamic>;
      return RandomMaster.random_(rm['from'], rm['to'], rm['step']);
    } else if (type_ == "normal_unit") {
      double U1 = RandomMaster.rand();
      double U2 = RandomMaster.rand();
      double Z0 = sqrt(-2 * log(U1)) * cos(2 * pi * U2);
      return Z0;
    } else if (type_ == "normal") {
      Map<String, dynamic> rm = data as Map<String, dynamic>;
      double U1 = RandomMaster.rand();
      double U2 = RandomMaster.rand();
      double Z0 = sqrt(-2 * log(U1)) * cos(2 * pi * U2);
      return Z0 * rm['stddev'] + rm['mean'];
    }
    return 0.0;
  }
}

// 使用示例
void main() {
  // 创建 uniform 分布
  var uniform = RandomMaster.new_("uniform", {
    'from': 0.0,
    'to': 10.0,
    'step': 0.1
  });
  print(uniform.compute());

  // 创建 normal 分布
  var normal = RandomMaster.new_("normal", {
    'mean': 5.0,
    'stddev': 2.0
  });
  print(normal.compute());
}