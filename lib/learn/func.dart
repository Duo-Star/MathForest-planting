import 'dart:math';

void Start() {
  void myfirstfunc(String s) {
    print(s);
  }

  num add(num a, num b) {
    return a + b;
  }

  num sub(num a, num b) => a - b;

}



void OptionalParameters(){
  /*
  可选参数 (Optional Parameters) - Dart 特色！
  这是 Dart 函数最灵活和强大的特性之一，Java 中没有直接对应的概念。
    a. 命名可选参数 (Named Optional Parameters)
       用 {} 包裹参数，调用时指定参数名。
   */
  void introduce({String? name, int? age, String country = 'China'}) {
    print('Name: $name, Age: $age, Country: $country');
  }
  // 调用：使用参数名: 值的形式，顺序无关！
  introduce(name: 'Bob', age: 25);
  introduce(age: 30, name: 'Alice'); // 顺序可以改变
  introduce(country: 'USA', name: 'John'); // 可以只传部分参数
  introduce(); // 甚至可以不传（但null安全会警告）
  // 输出：
  // Name: Bob, Age: 25, Country: China
  // Name: Alice, Age: 30, Country: China
  // Name: John, Age: null, Country: USA
  // Name: null, Age: null, Country: China


  /*
  b. 位置可选参数 (Positional Optional Parameters)
     用 [] 包裹参数，按位置传递。
   */
  // 定义函数：[] 内的参数是可选的
  void sayMessage(String from, [String? to, String message = 'Hello']) {
    if (to != null) {
      print('$from says "$message" to $to');
    } else {
      print('$from says "$message" to everyone');
    }
  }
  sayMessage('Alice', 'Bob', 'How are you?');
  sayMessage('Alice', 'Bob'); // 使用默认的message
  sayMessage('Alice'); // 只传必需的参数
  // 输出：
  // Alice says "How are you?" to Bob
  // Alice says "Hello" to Bob
  // Alice says "Hello" to everyone

  /*
  何时使用哪种？
  命名参数：参数较多、有默认值、调用时易混淆时使用（如配置项）。
  位置参数：参数有自然顺序，且可选参数不多时使用。
   */

}

void FunctionsAsFirst_ClassCitizens(){
  /*
  3. 函数作为一等公民 (Functions as First-Class Citizens)
     这是你的 Lua 经验大放异彩的地方！Dart 和 Lua 一样，函数可以像变量一样被传递。
   */

  // 1. 将函数赋值给变量, 在函数中修改传入值
  var loudify = (String msg) => msg.toUpperCase();
  print(loudify('hello')); // 输出: HELLO

  // 2. 函数作为参数传递（高阶函数）
  void processString(String input, String Function(String) processor) {
    var result = processor(input);//调用这个函数
    print('Processed: $result');
  }

  // 3. 函数作为返回值
  String Function(String) createGreeter(String prefix) {
    return (String name) => '$prefix, $name!';
  }

  // 传递函数作为参数
  processString('hello', (s) => s.toUpperCase());
  processString('  trim me  ', (s) => s.trim());

  // 接收函数作为返回值
  var greeter = createGreeter('Hello');
  print(greeter('World')); // 输出: Hello, World!


}

void AnonymousFunctionsAndClosures(){
  /*
  4. 匿名函数与闭包 (Anonymous Functions & Closures)
     和 Lua 一样，Dart 有强大的匿名函数和闭包支持。
   */

  var numbers = [1, 2, 3, 4, 5];

  // 匿名函数：类似Lua的 function(x) ... end
  numbers.forEach( (number) {
    print('Number: $number');
  } );

  // 更简洁的箭头语法
  numbers.forEach((number) => print('Num: $number'));

  // 闭包：函数可以捕获外部变量
  var multiplier = 2;  //外部变量
  var doubled = numbers.map((n) => n * multiplier);
  print(doubled.toList());  // 输出: [2, 4, 6, 8, 10]

  // multiplier改变会影响闭包
  multiplier = 3;
  var tripled = numbers.map((n) => n * multiplier);
  print(tripled.toList()); // 输出: [3, 6, 9, 12, 15]

}




void main() {


}
