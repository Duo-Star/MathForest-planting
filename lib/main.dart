import 'dart:async';
import 'dart:ui' as ui;
import 'dart:math' as math;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'MF/main.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      home: const MyHomePage(title: 'MathForest - GeoMKY'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class MyPainter extends CustomPainter {
  final Monxiv monxiv;

  MyPainter({required this.monxiv});



  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawColor(monxiv.bgc, BlendMode.srcOver);
    IntersectionSolver iSolver = IntersectionSolver();
    Circle c = Circle(Vec(), Vec(2.5));//创建圆
    monxiv.drawCircle(c, canvas);//画

  }

  @override
  bool shouldRepaint(covariant MyPainter oldDelegate) {
    return monxiv != oldDelegate.monxiv;
  }
}



class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  // 使用Monxiv管理视图变换
  Monxiv monxiv = Monxiv()
    ..reset()
    ..infoMode = true;


  @override
  void initState() {
    super.initState();

    // 持续重绘
    _animationController = AnimationController(
      duration: const Duration(days: 114514),
      vsync: this,
    )..repeat();

    // 监听
    _animationController.addListener(() {
      setState(() {}); // 每帧重绘
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }





  void _incrementCounter() {
    setState(() {});
    Mambo mambo = Mambo(context, '曼波');
    var dn = EquSolver.solveComplexQuadratic(i, i, i);

    //mambo.ha('曼波${ dn.toString() }');

    //*
    //创建GMK核心
    var gmkCore = GMKCore();

    //手动构建几何结构
    var ags = GMKStructure([
      GMKProcess("P", GMKLabel("A"), [-1, 2, 0]),
      GMKProcess("P", GMKLabel("B"), [1, 3, 0]),
      GMKProcess("midP", GMKLabel("C"), [GMKLabel("A"), GMKLabel("B")])
    ]);

    //加载结构
    gmkCore.loadStructure(ags);

    //运行
    var gmkData = gmkCore.run;

    //获取值
    mambo.ha('${ gmkData.data['C']?.obj.toString() }');

     //*/

    //mambo.ha('${ 1 }');

    //Monxiv monxiv = Monxiv();

    //monxiv.drawGMKData(gmkData);










  }

  void _decrementCounter() {
    setState(() {});
  }

  void _resetCounter() {
    setState(() {});
  }

  void _showInfoDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('应用信息'),
          content: const Text('测试中的MathForest-GeoMKY\n\n使用说明：\n- 拖拽：平移视图\n- 滚轮：缩放视图\n- 双击：重置视图'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('确定'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _decrementCounter,
            tooltip: '减少计数器',
          ),
          IconButton(
            icon: const Icon(Icons.remove),
            onPressed: _decrementCounter,
            tooltip: '减少计数器',
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _resetCounter,
            tooltip: '重置计数器',
          ),
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: _showInfoDialog,
            tooltip: '应用信息',
          ),
          PopupMenuButton<String>(
            onSelected: (String value) {
              switch (value) {
                case 'settings':
                  break;
                case 'help':
                  break;
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'settings',
                child: ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('设置'),
                ),
              ),
              const PopupMenuItem<String>(
                value: 'help',
                child: ListTile(
                  leading: Icon(Icons.help),
                  title: Text('帮助'),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Listener(
        onPointerSignal: monxiv.handlePointerSignal,
        child: GestureDetector(
          onScaleStart: monxiv.handleScaleStart,
          onScaleUpdate: monxiv.handleScaleUpdate,
          onScaleEnd: monxiv.handleScaleEnd,
          onDoubleTap: monxiv.handleDoubleTap,

          child: LayoutBuilder(
            builder: (context, constraints) {
              return CustomPaint(
                painter: MyPainter(monxiv: monxiv),
                size: Size(constraints.maxWidth, constraints.maxHeight),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}