//import 'dart:ffi' as ffi;
import 'dart:math';
import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart' as painting;

import '../../Conic/Cir2.dart';
import 'MColor.dart' as MColor;


import '../../Linear/Vec.dart';
import '../../Linear/Line.dart';
import '../../Conic/Conic.dart';
import '../../Conic/Circle.dart';
import '../../Conic/Conic0.dart';
import '../../Conic/Conic1.dart';
import '../../Conic/Conic2.dart';
import '../../Fertile/DPoint.dart';


class Monxiv {
  Vec p = Vec();
  num lam = 10;
  bool infoMode = false;
  Vec size = Vec();

  // 用于处理手势
  Offset _startLocalPosition = Offset.zero;
  Vec _startMonxivP = Vec();
  double _startMonxivLam = 1.0;
  bool _isDragging = false;
  List<num>  monxivLamRestriction = [.5,5e3];

  //
  num get xStart => -p.x/lam;
  num get xEnd   => (size.x-p.x)/lam;
  num get yStart => -(size.y-p.y)/lam;
  num get yEnd   => p.y/lam;



  void setSize(Size size_){
    size = Vec(size_.width, size_.height);
  }


  Paint defaultPaint = Paint()..color = Colors.amber..style = PaintingStyle.stroke..strokeWidth = 2.5;
  Paint axisPaint = Paint()..color = Color.fromARGB(180, 0, 0, 0)..style = PaintingStyle.stroke..strokeWidth = 2.0;
  Paint gridPaint = Paint()..color = Color.fromARGB(80, 0, 0, 0)..style = PaintingStyle.stroke..strokeWidth = 2.0;


  Color bgc = Color.fromARGB(255, 230, 230, 230);


  Vec c2s(Vec c){
    return Vec(c.x * lam + p.x,-c.y * lam + p.y);
  }
  Vec s2c(Vec s){
    return Vec((s.x-p.x) / lam, -(s.y-p.y) / lam);
  }
  void reset(){
    p = Vec(150,150);
    lam = 100;
  }



  bool drawText(String str, Vec p, double fontSize, double width, Canvas canvas, {Color? color}){
    final ParagraphBuilder builder = ParagraphBuilder(
      ParagraphStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.normal,
      ),
    );


    builder.addText(str);

    final Paragraph paragraph = builder.build();
    paragraph.layout(ParagraphConstraints(width: width));
    canvas.drawParagraph(paragraph, (c2s(p)).offset);
    return true;
  }

  bool drawPoint(Vec p, Canvas canvas, {Paint? paint}) {
    final Paint usedPaint = paint ?? defaultPaint;
    canvas.drawCircle(c2s(p).offset, 3, usedPaint);
    if (infoMode) {
      drawText(p.toString(), p, 12, 500.0, canvas);
    }
    return true;
  }


  bool drawDPoint(DPoint dP, Canvas canvas, {Paint? paint}) {
    drawPoint(dP.p1, canvas);
    drawPoint(dP.p2, canvas);
    return true;
  }


  bool drawCir2(Cir2 circle, Canvas canvas, {Paint? paint}) {
    final Paint usedPaint = paint ?? defaultPaint;
    canvas.drawCircle(
        c2s(circle.p).offset,
        (circle.r*lam).toDouble(),
        usedPaint
    );
    if (infoMode) {
      drawText(circle.toString(), circle.p, 12, 500, canvas);
    }
    return true;
  }


  bool drawLine(Line l, Canvas canvas, {Paint? paint}) {
    final Paint usedPaint = paint ?? defaultPaint;
    num long = 114514/lam;
    Offset p1 = c2s(l.indexPoint(-long)).offset;
    Offset p2 = c2s(l.indexPoint(long)).offset;
    canvas.drawLine(p1, p2, usedPaint);
    if (infoMode) {
      drawText(l.toString(), l.p, 12, 500, canvas);
    }
    return true;
  }

  bool drawSegmentBy2P(Vec p1_, Vec p2_, Canvas canvas, {Paint? paint}) {
    final Paint usedPaint = paint ?? defaultPaint;
    Offset p1 = c2s(p1_).offset;
    Offset p2 = c2s(p2_).offset;
    canvas.drawLine(p1, p2, usedPaint);
    if (infoMode) {
      drawText('SegmentBy2P : ${p1_.toString()}-${p2_.toString()}',p1_, 12, 500, canvas);
    }
    return true;
  }


  bool drawConic0(Conic0 c0, Canvas canvas, {Paint? paint}) {
    final Paint usedPaint = paint ?? defaultPaint;
    Path p = Path();
    Vec initVec = c2s(c0.indexPoint(0));
    p.moveTo(initVec.x.toDouble(), initVec.y.toDouble());
    for (double theta = 0.1; theta <= 2 * pi; theta += 0.1) {
      Vec nowVec =c2s(c0.indexPoint(theta));
      p.lineTo(nowVec.x.toDouble(), nowVec.y.toDouble());
    }
    p.close();
    canvas.drawPath(p, usedPaint);
    if (infoMode) {
      drawText(c0.toString(), c0.p, 12, 500, canvas);
    }
    return true;
  }

  bool drawConic2(Conic2 c2, Canvas canvas, {Paint? paint}) {
    final Paint usedPaint = paint ?? defaultPaint;
    num dt = 0.1;
    Path p1 = Path();
    Vec initVec1 = c2s(c2.indexPoint(-(pow(e,dt)-1)*.3));
    p1.moveTo(initVec1.x.toDouble(), initVec1.y.toDouble());
    for (num t = dt*.1; t <= 380/lam +5; t += dt) {
      Vec nowVec =c2s(c2.indexPoint(-(pow(e,t)-1)*.3));
      p1.lineTo(nowVec.x.toDouble(), nowVec.y.toDouble());
    }
    canvas.drawPath(p1, usedPaint);

    Path p2 = Path();
    Vec initVec2 = c2s(c2.indexPoint(dt));
    p2.moveTo(initVec2.x.toDouble(), initVec2.y.toDouble());
    for (num t = dt; t <= 380/lam + 5; t += dt) {
      Vec nowVec =c2s(c2.indexPoint((pow(e,t)-1)*.3));
      p2.lineTo(nowVec.x.toDouble(), nowVec.y.toDouble());
    }
    canvas.drawPath(p2, usedPaint);
    return true;
  }

  bool drawConic(Conic co, Canvas canvas, {Paint? paint}) {
    if (co.type=="Conic0"){
      drawConic0(co.reveal,canvas);
    } else if (co.type=="Conic1") {
      //drawConic1(co.reveal,canvas);
    } else if (co.type=="Conic2") {
      drawConic2(co.reveal,canvas);
    } else if (co.type=="XLine") {
      //drawXLine(co.reveal,canvas);
    } else if (co.type=="HLine") {
      //drawHLine(co.reveal,canvas);
    }
    return true;
  }

  bool drawGMKData(gmkData, canvas){
    //drawText('drawGMKData - error', c2s(Vec(10,10)), 12, 500, canvas);
    for (var key in gmkData.data.keys) {
      switch (gmkData.data[key]?.obj.runtimeType) {
        case const (DPoint) : //骈点
          drawDPoint(gmkData.data[key].obj, canvas);
        case const (Vec) :
          //var _ = MColor.initializePaints();
          drawPoint(gmkData.data[key].obj, canvas, paint: MColor.paints['green']);

        case const (Cir2) :
          drawCir2(gmkData.data[key].obj, canvas);
        case const (Line) :
          drawLine(gmkData.data[key].obj, canvas);
        case const (Conic0) :
          drawConic0(gmkData.data[key].obj, canvas);
        case const (num) :
          drawText(gmkData.data[key].obj.toString(), Vec(gmkData.data[key].obj,0), 12, 500, canvas);
        case const (String) :
          drawText(gmkData.data[key].obj.toString(), Vec(0,0), 12, 500, canvas);

          default:
            drawText('error: $key', Vec(0,0), 12, 500, canvas);
      }

    }

    return true;
  }


  bool drawFramework(Canvas canvas){
    canvas.drawColor(bgc, BlendMode.srcOver);
    drawSegmentBy2P(Vec(xStart,0), Vec(xEnd,0), canvas, paint: axisPaint);
    drawSegmentBy2P(Vec(0, yStart), Vec(0, yEnd), canvas, paint: axisPaint);

    int drawX = xStart.floor() - 1;
    if (drawX < 1) drawX = 1;
    int drawX_ = xEnd.floor() + 1;
    if (drawX_ > 100) drawX_ = 100;

    int drawY = yStart.floor() - 1;
    if (drawY < 1) drawY = 1;
    int drawY_ = yEnd.floor() + 1;
    if (drawY_ > 100) drawY_ = 100;

    for (int x = xStart.floor(); x <= xEnd; x++) {
      drawPoint(Vec(x),canvas, paint:axisPaint);
      drawText("$x", Vec(x) + Vec(-0.1, -0.1), 12, 500, canvas);
      drawSegmentBy2P(Vec(x, yEnd), Vec(x , yStart),canvas, paint: gridPaint);
    }

    for (int y = yStart.floor(); y <= yEnd; y++) {
      drawPoint(Vec(0, y),canvas, paint:axisPaint);
      drawText("$y", Vec(0, y) + Vec(-0.1, -0.1), 12, 500, canvas);
      drawSegmentBy2P(Vec(xStart, y), Vec(xEnd, y),canvas, paint: gridPaint);
    }

    return true;
  }














  // 处理缩放开始
  void handleScaleStart(ScaleStartDetails details) {
    print('开始移动');
    _isDragging = true;
    _startLocalPosition = details.localFocalPoint;
    _startMonxivP = Vec(p.x, p.y); // 保存当前平移状态
    _startMonxivLam = lam.toDouble(); // 保存当前缩放状态
  }

  // 处理缩放更新（同时处理平移和缩放）
  void handleScaleUpdate(ScaleUpdateDetails details) {
    //print('handleScaleUpdate');
    if (details.scale != 1.0) {
      // 缩放操作
      double newScale = _startMonxivLam * details.scale;
      // 限制缩放范围
      lam = newScale.clamp(monxivLamRestriction[0], monxivLamRestriction[1]);
    } else if (details.localFocalPoint != _startLocalPosition) {
      // 平移操作（没有缩放，只有位置变化）
      Offset delta = details.localFocalPoint - _startLocalPosition;
      p = Vec(
        _startMonxivP.x + delta.dx,
        _startMonxivP.y + delta.dy,
      );
    }
  }

  // 处理缩放结束
  void handleScaleEnd(ScaleEndDetails details) {
    _isDragging = false;
  }

  // 处理滚轮缩放
  void handlePointerSignal(PointerSignalEvent event) {
    print('滚轮缩放');
    if (event is PointerScrollEvent) {
      double zoomFactor = event.scrollDelta.dy > 0 ? 0.9 : 1.1;
      double newScale = lam * zoomFactor;
      lam = newScale.clamp(monxivLamRestriction[0], monxivLamRestriction[1]);
    }
  }

  // 双击重置视图
  void handleDoubleTap() {
    reset();
    p = Vec(400, 400); // 重置到初始位置
    lam = 100; // 重置到初始缩放
  }

  void onTap() {


  }

  void onTapDown(TapDownDetails details) {
    // 获取点击坐标
    Offset globalPosition = details.globalPosition; // 全局坐标
    Vec tapSP = Vec(globalPosition.dx, globalPosition.dy);
    Vec tapCP = s2c(tapSP);

    print(tapCP.toString());

  }


}