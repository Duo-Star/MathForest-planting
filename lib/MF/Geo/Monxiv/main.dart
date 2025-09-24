import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';

import '../Linear/Vec.dart';
import '../Linear/Line.dart';
import '../Conic/Conic.dart';
import '../Conic/Circle.dart';
import '../Conic/Conic0.dart';
import '../Conic/Conic1.dart';
import '../Conic/Conic2.dart';
import '../Fertile/DPoint.dart';


class Monxiv {
   Vec p = Vec();
   num lam = 10;
   bool infoMode = false;

   final Paint defaultPaint = Paint()
     ..color = Colors.amber..style = PaintingStyle.stroke..strokeWidth = 2.0;
   Color bgc = Colors.blueGrey;


  Vec C2S(Vec c){
    return Vec(c.x * lam + p.x,-c.y * lam + p.y);
  }
  Vec S2C(Vec s){
    return Vec((s.x-p.x) / lam, -(s.x-p.x) / lam);
  }
  void reset(){
    p = Vec(500,500);
    lam = 100;
  }

  bool drawText(String str, Vec p,  double fontSize, double width, Canvas canvas){
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
    canvas.drawParagraph(paragraph, (p).offset);
    return true;
  }

   bool drawPoint(Vec p, Canvas canvas, {Paint? paint}) {
     final Paint usedPaint = paint ?? defaultPaint;
     canvas.drawCircle(C2S(p).offset, 3, usedPaint);
     if (infoMode) {
       drawText(p.toString(), C2S(p), 12, 500.0, canvas);
     }
     return true;
   }


   bool drawDPoint(DPoint dP, Canvas canvas, {Paint? paint}) {
     drawPoint(dP.p1, canvas);
     drawPoint(dP.p2, canvas);
     return true;
   }


   bool drawCircle(Circle circle, Canvas canvas, {Paint? paint}) {
     final Paint usedPaint = paint ?? defaultPaint;
     canvas.drawCircle(
         C2S(circle.p).offset,
         (circle.r*lam).toDouble(),
         usedPaint
     );
     if (infoMode) {
       drawText(circle.toString(), C2S(circle.p), 12, 500, canvas);
     }
     return true;
   }


   bool drawLine(Line l, Canvas canvas, {Paint? paint}) {
     final Paint usedPaint = paint ?? defaultPaint;
     num long = 114514/lam;
     Offset p1 = C2S(l.indexPoint(-long)).offset;
     Offset p2 = C2S(l.indexPoint(long)).offset;
     canvas.drawLine(p1, p2, usedPaint);
     if (infoMode) {
       drawText(l.toString(), C2S(l.p), 12, 500, canvas);
     }
     return true;
   }


   bool drawConic0(Conic0 c0, Canvas canvas, {Paint? paint}) {
     final Paint usedPaint = paint ?? defaultPaint;
     Path p = Path();
     Vec initVec = C2S(c0.indexPoint(0));
     p.moveTo(initVec.x.toDouble(), initVec.y.toDouble());
     for (double theta = 0.1; theta <= 2 * pi; theta += 0.1) {
       Vec nowVec =C2S(c0.indexPoint(theta));
       p.lineTo(nowVec.x.toDouble(), nowVec.y.toDouble());
     }
     p.close();
     canvas.drawPath(p, usedPaint);
     if (infoMode) {
       drawText(c0.toString(), C2S(c0.p), 12, 500, canvas);
     }
     return true;
   }

   bool drawConic2(Conic2 c2, Canvas canvas, {Paint? paint}) {
     final Paint usedPaint = paint ?? defaultPaint;
     num dt = 0.1;
     Path p1 = Path();
     Vec initVec1 = C2S(c2.indexPoint(-(pow(e,dt)-1)*.3));
     p1.moveTo(initVec1.x.toDouble(), initVec1.y.toDouble());
     for (num t = dt*.1; t <= 380/lam +5; t += dt) {
       Vec nowVec =C2S(c2.indexPoint(-(pow(e,t)-1)*.3));
       p1.lineTo(nowVec.x.toDouble(), nowVec.y.toDouble());
     }
     canvas.drawPath(p1, usedPaint);

     Path p2 = Path();
     Vec initVec2 = C2S(c2.indexPoint(dt));
     p2.moveTo(initVec2.x.toDouble(), initVec2.y.toDouble());
     for (num t = dt; t <= 380/lam + 5; t += dt) {
       Vec nowVec =C2S(c2.indexPoint((pow(e,t)-1)*.3));
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


}