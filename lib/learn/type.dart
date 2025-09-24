import 'dart:math';

void main() {

  /*
  1. 数字 (Numbers)
    a. int - 整型 表示整数，大小不超过 64 位。
    b. double - 双精度浮点型 表示 64 位的双精度浮点数。
   */

  int age = 18 ;
  double pi = 3.1416 ;
  num a = 1.23;
  // int 和 double 都是 num 类型的子类
  // num 类型包含一些基础操作如 +, -, *, /，以及 abs(), ceil(), floor() 等方法。
  var b = 2 ;
  //类型推断


  /*
  2. 字符串 (String), 表示一串 UTF-16 编码的字符序列。
  与 Java 相似：是一个类，有丰富的方法（如 .length, .substring()）。
  创建方式：单引号 'Hello', 双引号 "World", 三引号（用于多行字符串）'''Multi-line''' 或 """String"""
  核心特性：字符串插值 (String Interpolation)
  这是 Dart 非常方便的特性，远超 Java 的 + 拼接和 Lua 的 ..。
   */

  String name = "Duo" ;
  //字符串插值 (String Interpolation)
  String greeting = 'Hello, $name!'; // Hello, Duo!
  String greeting2 = "He is $age old, and ${ (()=> pi)() }";
  String multiLine = '''
  这是一个
  多行
  字符串
  ''';


  /*
  3. 布尔型 (Bool)
表示逻辑值，只有两个对象：true 和 false。
与 Java 完全相同：bool isActive = true;
与 Lua 不同：Lua 中 false 和 nil 为假，其他所有值都为真
。在 Dart 中，只有 true 被视为 true，其他一切均为 false。这是强类型语言的严格性。
   */

  bool c = false ;
  var cc = true ;

  if (cc) {
    print("cc is $cc");
  }

  // 以下代码在 Dart 中是编译错误，不允许像 Lua 那样用非布尔值做判断
  // var number = 100;
  // if (number) { ... } // 错误！


/*
  4. 列表 (List)
  表示有序的集合（类似于数组）。
  与 Java 相似：List<int> list = new ArrayList<>();
  与 Lua 的 table 类似：但它是类型安全的，并且有更多内置方法。
*/

  // 1. 直接使用字面量（最常用）
  List<int> numbers = [1, 2, 3, 4, 5]; // 明确指定为 int 类型的 List
  var fruits = ['Apple', 'Banana', 'Mango']; // 推断为 List<String>

  // 2. 使用 List 的构造函数
  var fixedLengthList = List<int>.filled(3, 0); // 创建一个固定长度为3，填充0的列表
  var growableList = List<String>.empty(growable: true); // 创建一个可增长的空列表

  // 操作列表
  fruits.add('Orange'); // 添加元素
  print(fruits[0]); // 访问元素: Apple
  print(fruits.length); // 获取长度: 4

  // 强大的 for-in 循环遍历
  for (var fruit in fruits) {
    print(fruit);
  }


  /*
  . 映射 (Map), 表示键值对集合。
与 Java 的 HashMap 相似。
与 Lua 的 table 作为字典使用时类似。
   */
  // 1. 使用字面量（最常用）
  Map<String ,dynamic> person = {
    'name' : '莱西',
    'from' : 'paper lily',
    'age' : 16,
    'love' : true
  };

  // 2. 使用 Map 构造函数
  var capitals = Map<String,String>();
  capitals['China'] = 'Beijing';
  capitals['Japan'] = 'Tokyo';

  print(person['name']); // 通过 key 获取 value
  person['age'] = 26; // 通过 key 修改 value
  capitals.remove('Japan'); // 移除键值对

  // 遍历 Map
  capitals.forEach((key, value) {
    print('$key -> $value');
  });


}