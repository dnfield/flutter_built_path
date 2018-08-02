// import 'dart:ui' show PathFillType;

class SvgPath {
  const SvgPath(this.data, {this.fillRule});

  /// The SVG Path data string, i.e. the `d` attribute from an SVG `<path>` element.
  final String data;
  /// The [PathFillType] for the [Path].
  final FillRule fillRule;
}

enum FillRule {
  nonZero,
  evenOdd
}