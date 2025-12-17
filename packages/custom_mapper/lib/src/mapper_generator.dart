import 'package:analyzer/dart/element/element.dart';
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
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    if (element is! ClassElement) {
      throw InvalidGenerationSourceError(
        '@Mapper can only be applied to classes',
        element: element,
      );
    }

    final allFields = _getFields(element);
    final fieldAnnotations = _extractFieldAnnotations(element);

    final context = MapperContext(
      dtoElement: element,
      dtoName: element.name,
      domainName: annotation.read('domain').typeValue.element!.name!,
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

  List<String> _getFields(ClassElement element) {
    final constructors = element.constructors;
    if (constructors.isNotEmpty) {
      final constructor = constructors.first;
      final parameterNames = constructor.parameters
          .where((param) => param.isNamed || param.isRequiredPositional)
          .map((param) => param.name)
          .toList();
      if (parameterNames.isNotEmpty) {
        return parameterNames;
      }
    }

    return element.fields.where((f) => !f.isStatic).map((f) => f.name).toList();
  }

  Map<String, FieldAnnotationMetadata> _extractFieldAnnotations(
    ClassElement element,
  ) {
    final annotationMap = <String, FieldAnnotationMetadata>{};
    final constructor = element.constructors.firstOrNull;
    if (constructor != null) {
      for (final param in constructor.parameters) {
        final (isIgnored, defaultValue) = _extractAnnotationsFromMetadata(
          param.metadata,
        );
        if (isIgnored || defaultValue != null) {
          annotationMap[param.name] = FieldAnnotationMetadata(
            isIgnored: isIgnored,
            defaultIfNullValue: defaultValue,
          );
        }
      }
    }
    for (final field in element.fields.where((f) => !f.isStatic)) {
      if (!annotationMap.containsKey(field.name)) {
        final (isIgnored, defaultValue) = _extractAnnotationsFromMetadata(
          field.metadata,
        );
        if (isIgnored || defaultValue != null) {
          annotationMap[field.name] = FieldAnnotationMetadata(
            isIgnored: isIgnored,
            defaultIfNullValue: defaultValue,
          );
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
      final typeDisplayName = annotationType?.getDisplayString(
        withNullability: false,
      );

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

    final dartType = value.type?.getDisplayString(withNullability: false);

    if (dartType == 'bool') return value.toBoolValue();
    if (dartType == 'int') return value.toIntValue();
    if (dartType == 'double') return value.toDoubleValue();
    if (dartType == 'String') return value.toStringValue();

    return value.toString();
  }
}
