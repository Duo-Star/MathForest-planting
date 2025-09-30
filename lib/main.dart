import 'dart:async';
//import 'dart:ffi';
import 'dart:ui' ;
import 'dart:math' as math;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart' ;

import 'package:learnfl/MF/Geo/Intersection/Ins.dart';
import 'MF/Alg/EquSolver/EquSolver.dart' as EquSolver;
import 'MF/main.dart';

void main() {
  runApp(const MyApp());
}

class SingleChoice extends StatefulWidget {
  const SingleChoice({super.key});

  @override
  State<SingleChoice> createState() => _SingleChoiceState();
}

enum Calendar { day, week, month, year }

class _SingleChoiceState extends State<SingleChoice> {
  Calendar calendarView = Calendar.day;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<Calendar>(
      segments: const <ButtonSegment<Calendar>>[
        ButtonSegment<Calendar>(
          value: Calendar.day,
          label: Text('Day'),
          icon: Icon(Icons.calendar_view_day),
        ),
        ButtonSegment<Calendar>(
          value: Calendar.week,
          label: Text('Week'),
          icon: Icon(Icons.calendar_view_week),
        ),
        ButtonSegment<Calendar>(
          value: Calendar.month,
          label: Text('Month'),
          icon: Icon(Icons.calendar_view_month),
        ),
        ButtonSegment<Calendar>(
          value: Calendar.year,
          label: Text('Year'),
          icon: Icon(Icons.calendar_today),
        ),
      ],
      selected: <Calendar>{calendarView},
      onSelectionChanged: (Set<Calendar> newSelection) {
        setState(() {
          // By default there is only a single segment that can be
          // selected at one time, so its value is always the first
          // item in the selected set.
          calendarView = newSelection.first;
        });
      },
    );
  }
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

    monxiv.setSize(size);
    monxiv.drawFramework(canvas);

    //创建GMK核心
    GMKCore gmkCore = GMKCore();

    //手动构建几何结构
    /*
    var ags = GMKStructure([
      GMKProcess("P", "A", [-1, 2, 0]),
      GMKProcess("P", "B", [1, 3, 0]),
      GMKProcess("MidP", "C", ["A", "B"]),
      GMKProcess("Cir", "cir", ["A", "B"]),
    ]);
     */

    //加载结构
    //gmkCore.loadStructure(ags);

    gmkCore.loadSourceStructure('''
``我是注释,我可以
换行``

@a is N of 1;
@A is P of <a>, 1;
@B is P of 2, -1;
@cir is Cir of <A>, <B>;
@M is MidP of <A>, <B>;
@l is L of <A>,<B>;
@dP1 is Ins of <l>,<cir>;
@c0_1 is C0 of <.o>,<A>,<B>;
@F12 is F of <c0_1>;


/@cir11 is Cir of <new P<1,3>>, <B>;

``样式可选声明``
#A color:blue, size:1, style:outline;

''');

    //print(gmkCore.outputSource);

    //运行
    GMKData gmkData = gmkCore.run;

    //print(gmkCore.gmkData.data['dP1']?.obj.toString());

    //画
    monxiv.drawGMKData(gmkData, canvas);


/*
    Vec A = Vec(1,1);
    Vec B = Vec(2,-1);
    Cir2 cir = Cir2(Vec(),2);
    Line l = Line.new2P(A, B);
    DPoint dP =  Ins(cir, l);
    //print(dP.toString());

    monxiv.drawPoint(A, canvas);
    monxiv.drawPoint(B, canvas);
    monxiv.drawCir2(cir, canvas);
    monxiv.drawLine(l, canvas);
    monxiv.drawDPoint(dP, canvas);

 */



  }

  @override
  bool shouldRepaint(covariant MyPainter oldDelegate) {
    return monxiv != oldDelegate.monxiv;
  }
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  // 使用Monxiv管理视图变换
  Monxiv monxiv = Monxiv()
    ..reset()
    ..infoMode = false;

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

  void hihi() {
    setState(() {});
    Mambo mambo = Mambo(context, '曼波');

    //Function print = mambo.ha;

    num dissolve(num x, num m, num n){
      num OoOoO = mod(x, pow(m,n));
      num oOoOo = pow(m,n-1);
      print(OoOoO);
      print(oOoOo);
      return floor(OoOoO/oOoOo);
    }

    for(int i = 33; i<35; i++){
      print('$i  ${dissolve(10, 5, i)}');
    }







    //var aaa = EquSolver. solveCosSinForMainRoot(1,1,-1);
    //print(aaa.toString());


    /*
    //var dn = EquSolver.solveComplexQuadratic(i, i, i);

    //创建GMK核心
    var gmkCore = GMKCore();

    //手动构建几何结构
    var ags = GMKStructure([
      GMKProcess("P", "A", [-1, 2, 0]),
      GMKProcess("P", "B", [1, 3, 0]),
      GMKProcess("MidP", "C", ["A", "B"]),
      GMKProcess("Cir", "cir", ["A", "B"]),

    ]);

    //加载结构
    gmkCore.loadStructure(ags);

    //运行
    var gmkData = gmkCore.run;

    //画
    //monxiv.drawGMKData(gmkData, canvas);

    mambo.ha(gmkCore.outputSource);

     */


  }

  void _showInfoDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('应用信息'),
          content: const Text(
            '测试中的MathForest-GeoMKY\n\n使用说明：\n- 拖拽：平移视图\n- 滚轮：缩放视图\n- 双击：重置视图',
          ),
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

  int _selectedIndex = 0;
  final List<String> chipLabels = ['Point', 'Line', 'Triangle', 'more'];

  @override
  Widget build(BuildContext context) {
    // 使用 Scaffold 提供了基本结构，但没有应用栏
    return Scaffold(
      body: Stack(
        // 使用 Column 垂直布局
        children: [
          Listener(
            onPointerSignal: monxiv.handlePointerSignal,
            child: GestureDetector(
              onScaleStart: monxiv.handleScaleStart,
              onScaleUpdate: monxiv.handleScaleUpdate,
              onScaleEnd: monxiv.handleScaleEnd,
              onDoubleTap: monxiv.handleDoubleTap,
              onTap: monxiv.onTap,
              onTapDown: monxiv.onTapDown,

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

          Container(
            height: 160, // 设定为你想要的固定高度
            color: Colors.blueGrey[100],
            child: DefaultTabController(
              initialIndex: 3,
              length: 8,
              child: Scaffold(
                appBar: AppBar(
                  title: const Text('TabBar Sample'),
                  actions: <Widget>[
                    IconButton(
                      icon: const Icon(Icons.add_alert),
                      tooltip: 'Show Snackbar',
                      onPressed: () {
                        hihi();
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.file_copy_outlined),
                      tooltip: 'Show Snackbar',
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('This is a snackbar')),
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.navigate_next),
                      tooltip: 'Go to the next page',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) {
                              return Scaffold(
                                appBar: AppBar(title: const Text('Next page')),
                                body: const Center(
                                  child: Text(
                                    'This is the next page',
                                    style: TextStyle(fontSize: 24),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ],
                  bottom: TabBar(
                    tabs: const <Widget>[
                      Tab(text: '文件'),
                      Tab(text: '工具'),
                      Tab(text: '属性'),
                      Tab(text: '线性'),
                      Tab(text: '经典'),
                      Tab(text: '退化'),
                      Tab(text: '共生'),
                      Tab(text: '元素'),
                    ],
                  ),
                ),
                body: TabBarView(
                  children: <Widget>[
                    const Center(child: Text("It's cloudy here")),
                    const Center(child: Text("It's rainy here")),
                    const Center(child: Text("It's sunny here")),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(width: 15),
                        ...List.generate(chipLabels.length, (index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: ChoiceChip(
                              //avatar: const Icon(Icons.music_note),
                              padding: const EdgeInsets.all(8),
                              label: Text(chipLabels[index]),
                              selected: _selectedIndex == index,
                              onSelected: (bool selected) {
                                setState(() {
                                  _selectedIndex = index;
                                });
                              },
                            ),
                          );
                        }),
                      ],
                    ),
                    const Center(child: Text("It's rainy here")),
                    const Center(child: Text("It's sunny here")),
                    const Center(child: Text("It's cloudy here")),
                    const Center(child: Text("It's rainy here")),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
