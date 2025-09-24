import 'dart:math';
import 'Vec.dart';

class Mat33 {
  // 矩阵元素，按行主序存储
  final List<num> elements;

  // 构造函数：从9个元素创建矩阵
  Mat33(
      num a11, num a12, num a13,
      num a21, num a22, num a23,
      num a31, num a32, num a33,
      ) : elements = [a11, a12, a13, a21, a22, a23, a31, a32, a33];

  // 从列表创建矩阵
  Mat33.fromList(List<num> list) : elements = List.from(list) {
    if (list.length != 9) {
      throw ArgumentError('列表必须包含9个元素');
    }
  }

  // 单位矩阵
  Mat33.identity()
      : elements = [
    1.0, 0.0, 0.0,
    0.0, 1.0, 0.0,
    0.0, 0.0, 1.0,
  ];

  // 零矩阵
  Mat33.zero()
      : elements = List.filled(9, 0.0);

  // 对角线矩阵
  Mat33.diagonal(num d1, num d2, num d3)
      : elements = [
    d1, 0.0, 0.0,
    0.0, d2, 0.0,
    0.0, 0.0, d3,
  ];

  // 对称矩阵（从上三角部分创建）
  Mat33.symmetric(num a11, num a12, num a13, num a22, num a23, num a33)
      : elements = [
    a11, a12, a13,
    a12, a22, a23,
    a13, a23, a33,
  ];

  // 获取矩阵元素（行和列从1开始）
  num get(int row, int col) {
    return elements[(row - 1) * 3 + (col - 1)];
  }

  // 设置矩阵元素
  void set(int row, int col, num value) {
    elements[(row - 1) * 3 + (col - 1)] = value;
  }

  // 获取行向量
  Vec row(int row) {
    final start = (row - 1) * 3;
    return Vec(elements[start], elements[start + 1], elements[start + 2]);
  }

  // 获取列向量
  Vec column(int col) {
    final index = col - 1;
    return Vec(elements[index], elements[index + 3], elements[index + 6]);
  }

  // 矩阵加法
  Mat33 operator +(Mat33 other) {
    return Mat33(
      elements[0] + other.elements[0],
      elements[1] + other.elements[1],
      elements[2] + other.elements[2],
      elements[3] + other.elements[3],
      elements[4] + other.elements[4],
      elements[5] + other.elements[5],
      elements[6] + other.elements[6],
      elements[7] + other.elements[7],
      elements[8] + other.elements[8],
    );
  }

  // 矩阵减法
  Mat33 operator -(Mat33 other) {
    return Mat33(
      elements[0] - other.elements[0],
      elements[1] - other.elements[1],
      elements[2] - other.elements[2],
      elements[3] - other.elements[3],
      elements[4] - other.elements[4],
      elements[5] - other.elements[5],
      elements[6] - other.elements[6],
      elements[7] - other.elements[7],
      elements[8] - other.elements[8],
    );
  }

  // 矩阵数乘
  Mat33 operator *(num scalar) {
    return Mat33(
      elements[0] * scalar,
      elements[1] * scalar,
      elements[2] * scalar,
      elements[3] * scalar,
      elements[4] * scalar,
      elements[5] * scalar,
      elements[6] * scalar,
      elements[7] * scalar,
      elements[8] * scalar,
    );
  }

  // 矩阵数除
  Mat33 operator /(num scalar) {
    if (scalar == 0.0) {
      throw ArgumentError('除数不能为零');
    }
    return Mat33(
      elements[0] / scalar,
      elements[1] / scalar,
      elements[2] / scalar,
      elements[3] / scalar,
      elements[4] / scalar,
      elements[5] / scalar,
      elements[6] / scalar,
      elements[7] / scalar,
      elements[8] / scalar,
    );
  }



  // 矩阵乘法
  Mat33 multiply(Mat33 other) {
    return Mat33(
      // 第一行
      elements[0] * other.elements[0] + elements[1] * other.elements[3] + elements[2] * other.elements[6],
      elements[0] * other.elements[1] + elements[1] * other.elements[4] + elements[2] * other.elements[7],
      elements[0] * other.elements[2] + elements[1] * other.elements[5] + elements[2] * other.elements[8],

      // 第二行
      elements[3] * other.elements[0] + elements[4] * other.elements[3] + elements[5] * other.elements[6],
      elements[3] * other.elements[1] + elements[4] * other.elements[4] + elements[5] * other.elements[7],
      elements[3] * other.elements[2] + elements[4] * other.elements[5] + elements[5] * other.elements[8],

      // 第三行
      elements[6] * other.elements[0] + elements[7] * other.elements[3] + elements[8] * other.elements[6],
      elements[6] * other.elements[1] + elements[7] * other.elements[4] + elements[8] * other.elements[7],
      elements[6] * other.elements[2] + elements[7] * other.elements[5] + elements[8] * other.elements[8],
    );
  }

  // 转置矩阵
  Mat33 transpose() {
    return Mat33(
      elements[0], elements[3], elements[6],
      elements[1], elements[4], elements[7],
      elements[2], elements[5], elements[8],
    );
  }

  // 计算行列式
  num determinant() {
    return elements[0] * (elements[4] * elements[8] - elements[5] * elements[7]) -
        elements[1] * (elements[3] * elements[8] - elements[5] * elements[6]) +
        elements[2] * (elements[3] * elements[7] - elements[4] * elements[6]);
  }

  // 计算逆矩阵
  Mat33 inverse() {
    final det = determinant();
    if (det == 0.0) {
      throw Exception('矩阵不可逆（行列式为零）');
    }

    final invDet = 1.0 / det;

    return Mat33(
      (elements[4] * elements[8] - elements[5] * elements[7]) * invDet,
      (elements[2] * elements[7] - elements[1] * elements[8]) * invDet,
      (elements[1] * elements[5] - elements[2] * elements[4]) * invDet,
      (elements[5] * elements[6] - elements[3] * elements[8]) * invDet,
      (elements[0] * elements[8] - elements[2] * elements[6]) * invDet,
      (elements[2] * elements[3] - elements[0] * elements[5]) * invDet,
      (elements[3] * elements[7] - elements[4] * elements[6]) * invDet,
      (elements[1] * elements[6] - elements[0] * elements[7]) * invDet,
      (elements[0] * elements[4] - elements[1] * elements[3]) * invDet,
    );
  }

  // 计算迹（对角线元素之和）
  num trace() {
    return elements[0] + elements[4] + elements[8];
  }

  // 计算矩阵的Frobenius范数
  num norm() {
    num sum = 0.0;
    for (final element in elements) {
      sum += element * element;
    }
    return sqrt(sum);
  }

  // 判断是否是对称矩阵
  bool isSymmetric([num tolerance = 1e-10]) {
    for (int i = 0; i < 3; i++) {
      for (int j = i + 1; j < 3; j++) {
        if ((get(i + 1, j + 1) - get(j + 1, i + 1)).abs() > tolerance) {
          return false;
        }
      }
    }
    return true;
  }

  // 判断是否是正交矩阵
  bool isOrthogonal([num tolerance = 1e-10]) {
    final product = multiply(transpose());
    final identity = Mat33.identity();

    for (int i = 0; i < 9; i++) {
      if ((product.elements[i] - identity.elements[i]).abs() > tolerance) {
        return false;
      }
    }
    return true;
  }

  // 计算特征值（使用迭代方法，简化版）
  List<num> eigenvalues([int maxIterations = 100, num tolerance = 1e-10]) {
    // 使用QR算法简化版计算特征值
    Mat33 A = this;
    Mat33 Q, R;

    for (int i = 0; i < maxIterations; i++) {
      // QR分解（简化版）
      final qr = A.qrDecomposition();
      Q = qr[0];
      R = qr[1];

      A = R.multiply(Q);

      // 检查是否收敛（下三角元素接近零）
      if (A.elements[3].abs() < tolerance &&
          A.elements[6].abs() < tolerance &&
          A.elements[7].abs() < tolerance) {
        break;
      }
    }

    // 特征值在对角线上
    return [A.elements[0], A.elements[4], A.elements[8]];
  }

  // QR分解（简化版）
  List<Mat33> qrDecomposition() {
    final a1 = column(1);
    final a2 = column(2);
    final a3 = column(3);

    // Gram-Schmidt正交化过程
    final u1 = a1;
    final e1 = u1.unit;

    final u2 = a2 - e1 * (a2.dot(e1));
    final e2 = u2.unit;

    final u3 = a3 - e1 * (a3.dot(e1)) - e2 * (a3.dot(e2));
    final e3 = u3.unit;

    // Q矩阵由正交基组成
    final Q = Mat33(
      e1.x, e2.x, e3.x,
      e1.y, e2.y, e3.y,
      e1.z, e2.z, e3.z,
    );

    // R矩阵是上三角矩阵
    final R = Mat33(
      a1.dot(e1), a2.dot(e1), a3.dot(e1),
      0.0,        a2.dot(e2), a3.dot(e2),
      0.0,        0.0,        a3.dot(e3),
    );

    return [Q, R];
  }

  Vec tranVec2(Vec vector) {
    final x = elements[0] * vector.x + elements[1] * vector.y + elements[2] * 1;
    final y = elements[3] * vector.x + elements[4] * vector.y + elements[5] * 1;
    final w = elements[6] * vector.x + elements[7] * vector.y + elements[8] * 1;

    return Vec(x / w, y / w);
  }

  Vec tranVec3(Vec vector) {
    final x = elements[0] * vector.x + elements[1] * vector.y + elements[2] * vector.z;
    final y = elements[3] * vector.x + elements[4] * vector.y + elements[5] * vector.z;
    final z = elements[6] * vector.x + elements[7] * vector.y + elements[8] * vector.z;

    return Vec(x, y, z);
  }

  // 创建平移变换矩阵
  static Mat33 translation(num tx, num ty) {
    return Mat33(
      1.0, 0.0, tx,
      0.0, 1.0, ty,
      0.0, 0.0, 1.0,
    );
  }

  // 创建旋转变换矩阵（绕原点，角度为弧度）
  static Mat33 rotation(num angle) {
    final cosA = cos(angle);
    final sinA = sin(angle);
    return Mat33(
      cosA, -sinA, 0.0,
      sinA,  cosA, 0.0,
      0.0,   0.0,  1.0,
    );
  }

  // 创建缩放变换矩阵
  static Mat33 scaling(num sx, num sy) {
    return Mat33(
      sx,  0.0, 0.0,
      0.0, sy,  0.0,
      0.0, 0.0, 1.0,
    );
  }

  // 创建绕x轴旋转的3D旋转矩阵
  static Mat33 rotationX(num angle) {
    final cosA = cos(angle);
    final sinA = sin(angle);
    return Mat33(
      1.0, 0.0,  0.0,
      0.0, cosA, -sinA,
      0.0, sinA, cosA,
    );
  }

  // 创建绕y轴旋转的3D旋转矩阵
  static Mat33 rotationY(num angle) {
    final cosA = cos(angle);
    final sinA = sin(angle);
    return Mat33(
      cosA,  0.0, sinA,
      0.0,   1.0, 0.0,
      -sinA, 0.0, cosA,
    );
  }

  // 创建绕z轴旋转的3D旋转矩阵
  static Mat33 rotationZ(num angle) {
    final cosA = cos(angle);
    final sinA = sin(angle);
    return Mat33(
      cosA, -sinA, 0.0,
      sinA,  cosA, 0.0,
      0.0,   0.0,  1.0,
    );
  }

  // 字符串表示
  @override
  String toString() {
    return 'Mat33:\n'
        '[${elements[0].toStringAsFixed(4)}, ${elements[1].toStringAsFixed(4)}, ${elements[2].toStringAsFixed(4)}]\n'
        '[${elements[3].toStringAsFixed(4)}, ${elements[4].toStringAsFixed(4)}, ${elements[5].toStringAsFixed(4)}]\n'
        '[${elements[6].toStringAsFixed(4)}, ${elements[7].toStringAsFixed(4)}, ${elements[8].toStringAsFixed(4)}]';
  }

  // 相等性比较
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! Mat33) return false;

    for (int i = 0; i < 9; i++) {
      if (elements[i] != other.elements[i]) return false;
    }
    return true;
  }

  @override
  int get hashCode => Object.hashAll(elements);
}


/*
// 示例用法
void main() {
  // 创建矩阵
  final matrixA = Mat33(
    1.0, 2.0, 3.0,
    4.0, 5.0, 6.0,
    7.0, 8.0, 9.0,
  );

  final matrixB = Mat33(
    9.0, 8.0, 7.0,
    6.0, 5.0, 4.0,
    3.0, 2.0, 1.0,
  );

  final identity = Mat33.identity();
  final symmetric = Mat33.symmetric(1.0, 2.0, 3.0, 4.0, 5.0, 6.0);

  print('矩阵 A:');
  print(matrixA);
  print('\n对称矩阵:');
  print(symmetric);

  // 基本运算
  print('\n=== 基本运算 ===');
  print('A + B:');
  print(matrixA + matrixB);

  print('\nA - B:');
  print(matrixA - matrixB);

  print('\nA * 2:');
  print(matrixA * 2);

  print('\nA / 2:');
  print(matrixA / 2);

  print('\nA × B (矩阵乘法):');
  print(matrixA .multiply(matrixB));

  print('\nA 的转置:');
  print(matrixA.transpose());

  print('\nA 的行列式: ${matrixA.determinant().toStringAsFixed(4)}');

  // 高级运算
  print('\n=== 高级运算 ===');
  print('A 的迹: ${matrixA.trace()}');
  print('A 的范数: ${matrixA.norm().toStringAsFixed(4)}');
  print('A 是否对称: ${matrixA.isSymmetric()}');
  print('对称矩阵是否对称: ${symmetric.isSymmetric()}');
  print('单位矩阵是否正交: ${identity.isOrthogonal()}');

  // 逆矩阵
  try {
    final inv = identity.inverse();
    print('\n单位矩阵的逆:');
    print(inv);
  } catch (e) {
    print('\n无法计算逆矩阵: $e');
  }

  // 特征值
  try {
    final eigenvals = symmetric.eigenvalues();
    print('\n对称矩阵的特征值:');
    print(eigenvals.map((v) => v.toStringAsFixed(4)).toList());
  } catch (e) {
    print('\n特征值计算错误: $e');
  }

  // 变换测试
  final point = Vec(1.0, 2.0);
  final translate = Mat33.translation(3.0, 4.0);
  final rotated = translate.tranVec3(point);
  print('\n点 (1, 2) 平移 (3, 4) 后: $rotated');
}
 */