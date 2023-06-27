import 'package:path_parsing/path_parsing.dart';

class FlutterPathGenProxy extends PathProxy {
  StringBuffer code =
    StringBuffer()
      ..write('new Path()');

  @override
  void close() {
    code.write('..close()');
  }

  @override
  void cubicTo(
      double x1, double y1, double x2, double y2, double x3, double y3) {
    code.write('..cubicTo($x1, $y1, $x2, $y2, $x3, $y3)');
  }

  @override
  void lineTo(double x, double y) {
    code.write('..lineTo($x, $y)');
  }

  @override
  void moveTo(double x, double y) {
    code.write('..moveTo($x, $y)');
  }

  @override
  String toString() {
    return code.toString();
  }
}
