import 'dart:ui' show Path;

import 'package:built_path_annotations/built_path_annotations.dart';
import 'package:flutter/material.dart';

part 'main.svg_path.g.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @SvgPath('M20,30 Q40,5 60,30 T100,30')
  // @SvgPath('M10 20 C 10 10 20 10 25 20 S 40 30 40 20')
  Path get path => _$MyHomePage_path;

  @SvgPath('M 250,75 L 323,301 131,161 369,161 177,301 z',
      fillRule: FillRule.evenOdd)
  Path get star => _$MyHomePage_star;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(title),
      ),
      body: new Column(
        children: <Widget>[
          new CustomPaint(painter: new PathPainter(path)),
          new CustomPaint(painter: new PathPainter(star, false)),
        ],
      ),
    );
  }
}

class PathPainter extends CustomPainter {
  PathPainter(this.path, [this.isStroke = true]);

  final Path path;
  final bool isStroke;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawPath(
        path,
        new Paint()
          ..style = isStroke ? PaintingStyle.stroke : PaintingStyle.fill
          ..strokeWidth = 4.0);
  }

  @override
  bool shouldRepaint(PathPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(PathPainter oldDelegate) => false;
}
