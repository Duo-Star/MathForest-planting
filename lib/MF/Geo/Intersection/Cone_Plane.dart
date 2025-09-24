library Cone_Plane;
//Intersection
import 'dart:math';
import 'package:learnfl/MF/Alg/Fertile/DNum.dart';
import 'package:learnfl/MF/Geo/Conic/Circle.dart';
import 'package:learnfl/MF/Geo/Conic/XLine.dart';
import 'package:learnfl/MF/Geo/Fertile/DPoint.dart';

import '../../Alg/EquSolver/EquSolver.dart';
import '../Conic/Conic0.dart';
import '../Conic/Conic1.dart';
import '../Conic/Conic2.dart';
import '../Linear/Plane.dart';
import '../Linear/Vec.dart';
import '../SacredSurface/Cone.dart';

import 'Plane_Line.dart' as _Plane_Line;

bool PlaneThroughVertex(Cone cone, Plane plane) {
  Vec vertexToPlane = plane.p - cone.p;
  return vertexToPlane.dot(plane.n).abs() < 1e-10;
}

num PlaneAngleCone(Cone cone, Plane plane) {
  return pi/2 - cone.n.ang(plane.n);
}

enum ctp {
  Point,  HLine,  XLine,
  Conic0, Conic1, Conic2,
  Circle, Wipkyy
}

ctp getIntersectionType(Cone cone, Plane plane){
  bool _PlaneThroughVertex= PlaneThroughVertex(cone, plane);
  num _PlaneAngleCone = PlaneAngleCone(cone, plane);
  if (_PlaneThroughVertex){
    if (_PlaneAngleCone - cone.theta < 1e-10){
      return ctp.XLine;
    }else if (_PlaneAngleCone < cone.theta){
      return ctp.XLine;
    }else if (_PlaneAngleCone > cone.theta){
      return ctp.Point;
    }
  }else {
    if (_PlaneAngleCone - cone.theta < 1e-10){
      return ctp.Conic1;
    }else if (_PlaneAngleCone < cone.theta){
      return ctp.Conic2;
    }else if (_PlaneAngleCone > cone.theta){
      return ctp.Conic0;
    }
  }
  return ctp.Wipkyy;
}

Conic0 ifIThinkMustBeConic0(Cone cone, Plane plane){
  //首先，获得椭圆中心
  Vec stand = cone.n.cross(plane.n);
  Circle uC = cone.unitCircle;
  DNum edgeTheta = EquSolver.solveCosSinForMainRoot(uC.u.dot(stand),
      uC.v.dot(stand), (uC.p-cone.p).dot(stand));
  DPoint edgePoints = uC.indexPoints(edgeTheta);
  Vec O = edgePoints.mid;
  //获取ConjugatePoints
  XLine unitCircleConjugateXLine = cone.unitCircleConjugateXLine;
  DPoint conic0ConjugateDPoint = _Plane_Line.Plane_XLine(plane, unitCircleConjugateXLine);
  return Conic0(O, conic0ConjugateDPoint.p1-O, conic0ConjugateDPoint.p2-O);
}

Conic1 ifIThinkMustBeConic1(Cone cone, Plane plane){
  return Conic1();
}

Conic2 ifIThinkMustBeConic2(Cone cone, Plane plane){
  return Conic2();
}