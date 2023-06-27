import 'dart:async';

import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:built_path/src/flutter_path_proxy.dart';
import 'package:built_path_annotations/built_path_annotations.dart';
import 'package:path_parsing/path_parsing.dart';
import 'package:source_gen/source_gen.dart';

Builder svgPathSharedPartBuilder({String formatOutput(String code)?}) {
  return new PartBuilder(
      <Generator>[new SvgPathGenerator()], '.svg_path.g.dart',
      formatOutput: formatOutput,
      header: '// ignore_for_file: non_constant_identifier_names\n'
          '// GENERATED CODE - DO NOT MODIFY BY HAND\n');
}

class SvgPathGenerator extends Generator {
  final TypeChecker _checker = const TypeChecker.fromRuntime(SvgPath);

  String _getFillRule(int index) {
    if (index == 0) {
      return '..fillType = PathFillType.nonZero';
    } else if (index == 1) {
      return '..fillType = PathFillType.evenOdd';
    }
    throw new StateError('Unhandled FillRule index $index');
  }

  void checkField(Element field, StringBuffer buffer, String friendlyName) {
    DartObject? annotation = _checker.firstAnnotationOf(field);
    if (annotation == null && field is FieldElement) {
      final PropertyAccessorElement? getter = field.getter;
      if (getter != null) {
        annotation = _checker.firstAnnotationOf(getter);
      }
    }
    if (annotation != null) {
      buffer.writeln('Path? __\$$friendlyName;');
      buffer.writeln(
          'Path get _\$$friendlyName => __\$$friendlyName ?? (__\$$friendlyName =');
      final FlutterPathGenProxy proxy = new FlutterPathGenProxy();

      writeSvgPathDataToPath(
        annotation.getField('data')?.toStringValue(),
        proxy,
      );
      buffer.write(proxy);

      final int? fillRuleIndex =
          annotation.getField('fillRule')?.getField('index')?.toIntValue();
      if (fillRuleIndex != null) {
        buffer.write(_getFillRule(fillRuleIndex));
      }
      buffer.writeln(');');
    }
  }

  @override
  FutureOr<String> generate(LibraryReader library, BuildStep buildStep) async {
    final StringBuffer buffer = new StringBuffer();
    for (Element el in library.allElements) {
      final String? name = el.name;
      if (name == null) {
        continue;
      }
      if (el is ClassElement) {
        for (FieldElement field in el.fields) {
          final String? fieldName = field.name;
          if (fieldName == null) {
            continue;
          }
          checkField(field, buffer, '${name}_$fieldName');
        }
      } else {
        checkField(el, buffer, name);
      }
    }
    return buffer.toString();
  }
}
