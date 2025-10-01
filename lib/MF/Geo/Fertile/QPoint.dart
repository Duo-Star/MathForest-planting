import '../Conic/XLine.dart';
import '../Linear/Line.dart';
import '../Linear/Vec.dart';
import 'DPoint.dart';
import '../Intersection/IntersectionSolver.dart' as InsSolver;
import 'DXLine.dart';

//合点
class QPoint {
  //顺序四点
  Vec p1 = Vec();
  Vec p2 = Vec();
  Vec p3 = Vec();
  Vec p4 = Vec();

  //构建
  QPoint(this.p1, this.p2, this.p3, this.p4);

  //分对成为两个骈点
  DPoint get dP1 => DPoint(p1, p3);
  DPoint get dP2 => DPoint(p2, p4);

  //对定点连线
  Line get l1 => dP1.l;
  Line get l2 => dP2.l;

  //中心 - 对定点连线交点
  Vec get heart => InsSolver.Line_Line(l1, l2);

  //四条直线
  Line get l12 => Line.new2P(p1, p2);
  Line get l14 => Line.new2P(p1, p4);
  Line get l32 => Line.new2P(p3, p2);
  Line get l34 => Line.new2P(p3, p4);

  //衍骈点
  DPoint get deriveDP =>
      DPoint(InsSolver.Line_Line(l14, l32), InsSolver.Line_Line(l12, l34));

  //衍线
  Line get deriveL => deriveDP.l;

  //DXLine 骈叉线
  DXLine get net {
    Vec deriveDP1 = InsSolver.Line_Line(l14, l32);
    Vec deriveDP2 = InsSolver.Line_Line(l12, l34);
    return DXLine(
        XLine(deriveDP1, p1 - deriveDP1, p2 - deriveDP1),
        XLine(deriveDP2, p1 - deriveDP1, p4 - deriveDP1)
    );
  }



}
