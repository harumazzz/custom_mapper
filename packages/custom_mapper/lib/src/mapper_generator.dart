import 'package:analyzer/dart/element/element2.dart';
import 'package:analyzer/dart/constant/value.dart';
import 'package:build/build.dart';
import 'package:custom_mapper_annotation/custom_mapper_annotation.dart';
import 'package:source_gen/source_gen.dart';
import 'bidirectional_mapper_strategy.dart';
import 'mapper_context.dart';
import 'mapper_strategy.dart';

class MapperGenerator extends GeneratorForAnnotation<Mapper> {
  late final MapperStrategy _strategy;

  MapperGenerator() {
    _strategy = BidirectionalMapperStrategy();
  }

  @override
  String generateForAnnotatedElement(
    Element2 element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    if (element is! ClassElement2) {
      throw InvalidGenerationSourceError(
        '@Mapper can only be applied to classes',
        element: element,
      );
    }

    final allFields = _getFields(element);
    final fieldAnnotations = _extractFieldAnnotations(element);
    if (element.name3 == null) {
      throw InvalidGenerationSourceError(
        'Class must have a name',
        element: element,
      );
    }
    final context = MapperContext(
      dtoElement: element,
      dtoName: element.name3!,
      domainName: annotation.read('domain').typeValue.element3!.name3!,
      fields: allFields
          .where((field) => !(fieldAnnotations[field]?.isIgnored ?? false))
          .toList(),
      fieldAnnotations: fieldAnnotations,
      enableToDomain: annotation.read('toDomain').boolValue,
      enableToData: annotation.read('toData').boolValue,
    );

    final buffer = StringBuffer();
    buffer.writeln('// GENERATED CODE - DO NOT MODIFY BY HAND\n');

    final dtoBuffer = StringBuffer();
    final domainBuffer = StringBuffer();

    final result = _strategy.generate(context);
    dtoBuffer.write(result.dtoExtension);
    domainBuffer.write(result.domainExtension);

    buffer.writeln(
      'extension ${context.dtoName}Mapper on ${context.dtoName} {',
    );
    buffer.write(dtoBuffer.toString());
    buffer.writeln('}');
    buffer.writeln();
    if (domainBuffer.toString().isNotEmpty) {
      buffer.writeln(
        'extension ${context.domainName}ToDataMapper on ${context.domainName} {',
      );
      buffer.write(domainBuffer.toString());
      buffer.writeln('}');
      buffer.writeln();
    }

    return buffer.toString();
  }

  List<String> _getFields(ClassElement2 element) {
    final constructors = element.constructors2;
    if (constructors.isNotEmpty) {
      final constructor = constructors.first;
      final parameterNames = constructor.formalParameters
          .where((param) => param.isNamed || param.isRequiredPositional)
          .map((param) => param.name3)
          .where((name) => name != null)
          .cast<String>()
          .toList();
      if (parameterNames.isNotEmpty) {
        return parameterNames;
      }
    }

    return element.fields2
        .where((f) => !f.isStatic && f.name3 != null)
        .map((f) => f.name3!)
        .toList();
  }

  Map<String, FieldAnnotationMetadata> _extractFieldAnnotations(
    ClassElement2 element,
  ) {
    final annotationMap = <String, FieldAnnotationMetadata>{};
    final constructor = element.constructors2.firstOrNull;
    if (constructor != null) {
      for (final param in constructor.formalParameters) {
        final (isIgnored, defaultValue) = _extractAnnotationsFromMetadata(
          param.metadata2.annotations,
        );
        if (isIgnored || defaultValue != null) {
          final paramName = param.name3;
          if (paramName != null) {
            annotationMap[paramName] = FieldAnnotationMetadata(
              isIgnored: isIgnored,
              defaultIfNullValue: defaultValue,
            );
          }
        }
      }
    }
    for (final field in element.fields2.where((f) => !f.isStatic)) {
      final fieldName = field.name3;
      if (fieldName != null && !annotationMap.containsKey(fieldName)) {
        final (isIgnored, defaultValue) = _extractAnnotationsFromMetadata(
          field.metadata2.annotations,
        );
        if (isIgnored || defaultValue != null) {
          final fieldName = field.name3;
          if (fieldName != null) {
            annotationMap[fieldName] = FieldAnnotationMetadata(
              isIgnored: isIgnored,
              defaultIfNullValue: defaultValue,
            );
          }
        }
      }
    }

    return annotationMap;
  }

  (bool, dynamic) _extractAnnotationsFromMetadata(
    List<ElementAnnotation> metadata,
  ) {
    bool isIgnored = false;
    dynamic defaultIfNullValue;

    for (final annotationElement in metadata) {
      final annotation = annotationElement.computeConstantValue();
      if (annotation == null) continue;

      final annotationType = annotation.type;
      final typeDisplayName = annotationType?.getDisplayString();

      if (typeDisplayName == 'IgnoreField') {
        isIgnored = true;
      } else if (typeDisplayName == 'DefaultIfNull') {
        final valueField = annotation.getField('defaultValue');
        if (valueField != null) {
          defaultIfNullValue = _extractConstantValue(valueField);
        }
      }
    }

    return (isIgnored, defaultIfNullValue);
  }

  dynamic _extractConstantValue(DartObject value) {
    if (value.isNull) return null;

    final dartType = value.type?.getDisplayString();

    if (dartType == 'bool') return value.toBoolValue();
    if (dartType == 'int') return value.toIntValue();
    if (dartType == 'double') return value.toDoubleValue();
    if (dartType == 'String') return value.toStringValue();

    return value.toString();
  }
}
