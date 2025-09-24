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

    Circle c = Circle(Vec(), 2.5);//创建圆
    monxiv.drawCircle(c, canvas);//画

    Conic0 c0 = Conic0(Vec(5,5),Vec(2),Vec(1,1));
    //monxiv.drawConic0(c0, canvas);
    //monxiv.drawDPoint(c0.F, canvas);

    monxiv.drawConic(c0.conic, canvas);

    Conic2 c2 = Conic2(Vec(),Vec(1),Vec(0,1));
    //monxiv.drawConic2(c2, canvas);
    //monxiv.drawDPoint(c2.F, canvas);

    monxiv.drawPoint(Vec(), canvas);
    //monxiv.drawPoint(Vec(nan,nan), canvas);

    Line l1 = Line(Vec(1,-5),Vec(-1,1));
    Line l2 = Line(Vec(-1,5),Vec(1,2));
    monxiv.drawLine(l1, canvas);
    monxiv.drawLine(l2, canvas);

    Vec i_l1_l2 = IntersectionSolver.Line_Line(l1, l2);
    //monxiv.drawPoint(i_l1_l2, canvas);

    DPoint i_c0_l1 = IntersectionSolver.Conic0_Line(c0, l1);
    //monxiv.drawDPoint(i_c0_l1, canvas);

    //mambo(i_c0_l1.p1.toString());
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
  List<num>  monxivLamRestriction = [.5,5e3];

  // 用于处理手势
  Offset _startLocalPosition = Offset.zero;
  Vec _startMonxivP = Vec();
  double _startMonxivLam = 1.0;
  bool _isDragging = false;

  @override
  void initState() {
    super.initState();

    // 创建动画控制器，用于持续重绘
    _animationController = AnimationController(
      duration: const Duration(days: 365), // 设置很长的持续时间
      vsync: this,
    )..repeat(); // 持续重复动画

    // 监听动画值变化，触发重绘
    _animationController.addListener(() {
      setState(() {}); // 每帧都重绘
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }



  // 处理缩放开始
  void _handleScaleStart(ScaleStartDetails details) {
    setState(() {
      _isDragging = true;
      _startLocalPosition = details.localFocalPoint;
      _startMonxivP = Vec(monxiv.p.x, monxiv.p.y); // 保存当前平移状态
      _startMonxivLam = monxiv.lam.toDouble(); // 保存当前缩放状态
    });
  }

  // 处理缩放更新（同时处理平移和缩放）
  void _handleScaleUpdate(ScaleUpdateDetails details) {
    setState(() {
      if (details.scale != 1.0) {
        // 缩放操作
        double newScale = _startMonxivLam * details.scale;
        // 限制缩放范围
        monxiv.lam = newScale.clamp(monxivLamRestriction[0], monxivLamRestriction[1]);
      } else if (details.localFocalPoint != _startLocalPosition) {
        // 平移操作（没有缩放，只有位置变化）
        Offset delta = details.localFocalPoint - _startLocalPosition;
        monxiv.p = Vec(
          _startMonxivP.x + delta.dx,
          _startMonxivP.y + delta.dy,
        );
      }
    });
  }

  // 处理缩放结束
  void _handleScaleEnd(ScaleEndDetails details) {
    setState(() {
      _isDragging = false;
    });
  }

  // 处理滚轮缩放
  void _handlePointerSignal(PointerSignalEvent event) {
    if (event is PointerScrollEvent) {
      setState(() {
        double zoomFactor = event.scrollDelta.dy > 0 ? 0.9 : 1.1;
        double newScale = monxiv.lam * zoomFactor;
        monxiv.lam = newScale.clamp(monxivLamRestriction[0], monxivLamRestriction[1]);
      });
    }
  }

  // 双击重置视图
  void _handleDoubleTap() {
    setState(() {
      monxiv.reset();
      monxiv.p = Vec(400, 400); // 重置到初始位置
      monxiv.lam = 100; // 重置到初始缩放
    });
  }

  void _incrementCounter() {
    setState(() {});
    Mambo mambo = Mambo(context, '曼波');
    var dn = EquSolver.solveComplexQuadratic(i, i, i);

    mambo.ha('曼波${ dn.toString() }');
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
        onPointerSignal: _handlePointerSignal,
        child: GestureDetector(
          onScaleStart: _handleScaleStart,
          onScaleUpdate: _handleScaleUpdate,
          onScaleEnd: _handleScaleEnd,
          onDoubleTap: _handleDoubleTap,
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