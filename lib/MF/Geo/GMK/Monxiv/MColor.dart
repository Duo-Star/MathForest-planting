library MColor;

import 'dart:ui';
import 'dart:math';
import 'package:flutter/material.dart';

// 创建 Paint 的函数
Paint createPaint(Color color, {double strokeWidth = 2.0, PaintingStyle style = PaintingStyle.stroke, int alpha = 255}) {
  final effectiveColor = color.withAlpha(alpha);
  return Paint()
    ..color = effectiveColor
    ..style = style
    ..strokeWidth = strokeWidth;
}

num aaa=1;

// 颜色表
Map<String, Color> colors = {
  'amber': Color.fromARGB(255, 255, 204, 51),
  'yellow': Color.fromARGB(255, 255, 215, 0),
  'hui': Color.fromARGB(255, 128, 128, 128),
  'red': Color.fromARGB(255, 255, 0, 51),
  'blue': Color.fromARGB(255, 0, 51, 204),
  'green': Color.fromARGB(255, 0, 153, 0),
};

Map<String, Paint> paints = {};

void initializePaints() {
  colors.forEach((colorName, color) {
    // 生成正常版本的 Paint
    paints[colorName] = createPaint(color);

    // 生成带透明度的 Paint_ (alpha = 200)
    paints['${colorName}_'] = createPaint(color, alpha: 200);

    // 可选：生成填充版本的 Paint
    paints['${colorName}Fill'] = createPaint(color, style: PaintingStyle.fill);
    paints['${colorName}Fill_'] = createPaint(color, style: PaintingStyle.fill, alpha: 200);
  });
}



var _ = initializePaints();





