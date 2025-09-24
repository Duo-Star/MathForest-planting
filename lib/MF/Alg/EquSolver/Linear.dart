library;

(num, num) solve2x2LinearSystem(num a1, num b1, num c1, num a2, num b2, num c2) {
  //[[a1 x + b1 y = c1, a2 x + b2 y = c2 ]]
  num D = a1 * b2 - a2 * b1;
  if (D == 0) {
    return (1 / 0, 1 / 0);
  } else {
    var x = (c1 * b2 - c2 * b1) / D;
    var y = (a1 * c2 - a2 * c1) / D;
  return (x, y); // 有顺序
  }
}