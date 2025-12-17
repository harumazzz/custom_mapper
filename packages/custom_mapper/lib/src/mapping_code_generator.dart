import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'iterable_transformation_handler.dart';
import 'mapper_context.dart';

class MappingCodeGenerator {
  final _iterableHandler = IterableTransformationHandler();

  String generateMappingMethod({
    required String methodName,
    required String targetType,
    required List<String> fields,
    required Map<String, DartType> parameterTypes,
    required String transformationMethod,
    required Map<String, FieldAnnotationMetadata> fieldAnnotations,
  }) {
    final buffer = StringBuffer();
    buffer.writeln('  $targetType $methodName() => $targetType(');

    for (final fieldName in fields) {
      final fieldMapping = _generateFieldMapping(
        fieldName,
        parameterTypes[fieldName],
        transformationMethod,
        fieldAnnotations[fieldName],
      );
      buffer.writeln('    $fieldMapping,');
    }

    buffer.writeln('  );');
    return buffer.toString();
  }

  String _generateFieldMapping(
    String fieldName,
    DartType? paramType,
    String transformationMethod,
    FieldAnnotationMetadata? fieldAnnotation,
  ) {
    final defaultValue = fieldAnnotation?.defaultIfNullValue;
    final baseValue = _generateBaseValue(
      fieldName,
      paramType,
      transformationMethod,
    );

    if (defaultValue != null) {
      final formattedDefault = _formatDefaultValue(defaultValue);
      return '$fieldName: $fieldName != null ? $baseValue : $formattedDefault';
    }

    return '$fieldName: $baseValue';
  }

  String _generateBaseValue(
    String fieldName,
    DartType? paramType,
    String transformationMethod,
  ) {
    if (paramType == null) return fieldName;

    final isNullable =
        paramType.nullabilitySuffix == NullabilitySuffix.question;
    final mapInfo = _iterableHandler.getMapInfo(paramType);
    if (mapInfo != null) {
      final transformedValue = _generateBaseValue(
        'value',
        mapInfo.valueType,
        transformationMethod,
      );
      if (transformedValue != 'value') {
        final mapTransform =
            '$fieldName.map((key, value) => MapEntry(key, $transformedValue))';
        return isNullable
            ? '$fieldName?.map((key, value) => MapEntry(key, $transformedValue))'
            : mapTransform;
      }
      return fieldName;
    }

    final iterableInfo = _iterableHandler.getIterableInfo(paramType);
    if (iterableInfo != null) {
      final elementIsNullable =
          iterableInfo.elementType.nullabilitySuffix ==
          NullabilitySuffix.question;
      final elementIsCustomClass = _iterableHandler.isCustomClassType(
        iterableInfo.elementType,
      );

      if (!elementIsCustomClass) {
        if (isNullable) {
          return '$fieldName';
        }
        return fieldName;
      }
      final itemTransform = elementIsNullable
          ? 'item?.$transformationMethod()'
          : 'item.$transformationMethod()';
      final baseTransform =
          '$fieldName.map((item) => $itemTransform).${iterableInfo.containerMethod}';
      if (isNullable) {
        return '$fieldName?.map((item) => $itemTransform).${iterableInfo.containerMethod}';
      }
      return baseTransform;
    }

    final isCustomClass = _iterableHandler.isCustomClassType(paramType);
    if (isCustomClass) {
      if (isNullable) {
        return '$fieldName?.$transformationMethod()';
      }
      return '$fieldName.$transformationMethod()';
    }

    return fieldName;
  }

  String _formatDefaultValue(dynamic value) {
    if (value == null) return 'null';
    if (value is String) return "'$value'";
    if (value is bool) return value.toString();
    if (value is num) return value.toString();
    return value.toString();
  }
}
