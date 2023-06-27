# Built Path

This library can help Flutter applications pre-compile SVG Path data into 
Flutter (`dart:ui`) `Path` objects.

For example:

```dart
import 'package:built_path_annotations/built_path_annotations.dart';

part 'example.svg_path.g.dart';

@SvgPath('M10 10 L20 20 Z')
Path get diagonalLine => _$diagonalLine;
```

Will generate Dart code like the following:

```dart
part of 'example.dart'

Path __$diagonalLine;
Path get _$diagonalLine => __$diagonalLine ??
  (__$diagonalLine = new Path()
                      ..moveTo(10.0, 10.0)
                      ..lineTo(20.0, 20.0)
                      ..close());
```

Note that for a Flutter project, you'll have to run
`dart run build_runner build`.

The `example/` folder contains a full working example for Flutter, including 
the `build.yaml` and generated code.
