import 'package:flutter/material.dart';

enum QueenCellColor {
  purple(Colors.purple),
  orange(Colors.orange),
  blue(Colors.blue),
  brown(Colors.brown),
  yellow(Colors.yellowAccent),
  grey(Colors.grey),
  green(Colors.lightGreenAccent),
  red(Colors.redAccent),
  cyan(Colors.cyan),
  ;

  final Color color;

  const QueenCellColor(this.color);

  QueenCellColor toggle() => switch (this) {
        purple => orange,
        orange => blue,
        blue => brown,
        brown => yellow,
        yellow => grey,
        grey => green,
        green => red,
        red => cyan,
        cyan => purple,
      };
}
