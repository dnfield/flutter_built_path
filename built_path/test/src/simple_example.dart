// stub this out instead of trying to depend on Flutter for this repo
import 'package:built_path_annotations/built_path_annotations.dart';

part 'simple_example.svg_path.g.dart';

class Path {
  void lineTo(double x, double y) {}
  void moveTo(double x, double y) {}
  void cubicTo(
      double x, double y, double x2, double y2, double x3, double y3) {}
  void close() {}
}

@SvgPath('M 10 10 L 20 20 z')
Path get path => _$path;

class Paths {
  @SvgPath('M 0 0 L 20 10 C 10 10 15 15 20 10 z')
  Path get anotherPath => _$Paths_anotherPath;
}
