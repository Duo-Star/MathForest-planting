import 'dart:math';

void IF(){
  int score = 85;
  // 1. 基本的 if
  if (score >= 60) {
    print('及格了！');
  }
  // 2. if-else
  if (score >= 90) {
    print('优秀！');
  } else {
    print('良好或及格');
  }
  // 3. if-else if-else 链
  if (score >= 90) {
    print('等级：A');
  } else if (score >= 80) {
    print('等级：B');
  } else if (score >= 70) {
    print('等级：C');
  } else if (score >= 60) {
    print('等级：D');
  } else {
    print('等级：F（不及格）');
  }
}

void TernaryOperator() {
  int a = 10;
  int b = 15;
  // 代替 if-else 的简洁写法
  String result = a > b ? 'a更大' : 'b更大';
  print(result); // 输出: b更大
}

void Loops(){
  //for
  // 1. 传统的 for 循环（和Java完全相同）
  for (var i = 0; i < 5; i++) {
    print('循环次数: $i');
  }
  // 2. 遍历集合的 for-in 循环（非常常用！）
  var fruits = ['Apple', 'Banana', 'Orange'];
  for (var fruit in fruits) {
    print('水果: $fruit');
  }
  // 3. 带索引的遍历（类似Lua的ipairs）
  for (var i = 0; i < fruits.length; i++) {
    print('${i + 1}. ${fruits[i]}');
  }


  // while
  // 1. 先判断后执行
  var count = 0;
  while (count < 5) {
    print('while循环: $count');
    count++;
  }

  // 2. 先执行后判断（至少执行一次）
  var number = 10;
  do {
    print('do-while循环: $number');
    number++;
  } while (number < 5); // 条件不成立，但已经执行了一次



  //forEach
  var numbers = [1, 2, 3, 4, 5];
  // 使用匿名函数
  numbers.forEach((number) {
    print('数字: $number');
  });

  // 箭头函数更简洁
  numbers.forEach((number) => print('Num: $number'));

  // 遍历Map
  var person = {'name': 'Bob', 'age': 25, 'city': 'Beijing'};
  person.forEach((key, value) {
    print('$key: $value');
  });



  //循环控制语句
  // break: 跳出整个循环
  for (var i = 0; i < 10; i++) {
    if (i == 5) {
      break; // 当i等于5时，跳出循环
    }
    print('break示例: $i');
  }

  // continue: 跳过本次循环，继续下一次
  for (var i = 0; i < 5; i++) {
    if (i == 2) {
      continue; // 跳过i=2的这次循环
    }
    print('continue示例: $i');
  }


  //标签循环 (Labeled Loops)
  // 给外层循环加标签
  outerLoop: for (var i = 0; i < 3; i++) {
    for (var j = 0; j < 3; j++) {
      print('i=$i, j=$j');
      if (i == 1 && j == 1) {
        break outerLoop; // 直接跳出外层循环
      }
    }
  }
  print('循环结束');


}

void SWITCH(){
  var grade = 'B';
  switch (grade) {
    case 'A':
      print('优秀！');
      break; // Dart中break是可选的，但推荐保持习惯
    case 'B':
      print('良好');
      break;
    case 'C':
      print('及格');
      break;
    default:
      print('未知等级');
  }
  // 支持比较复杂的case表达式
  var number = 10;
  switch (number) {
    case 0:
      print('零');
      break;
    case > 0 && < 10: // 支持关系表达式!!!!!
      print('个位数');
      break;
    default:
      print('其他数字');
  }
}


void main(){

}