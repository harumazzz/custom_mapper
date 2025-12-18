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
    final collectionSet = _extractCollectionTypes(
      annotation.read('collection'),
    );

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
      collections: collectionSet,
    );

    final buffer = StringBuffer();
    buffer.writeln('// GENERATED CODE - DO NOT MODIFY BY HAND\n');

    final dtoBuffer = StringBuffer();
    final domainBuffer = StringBuffer();

    final result = _strategy.generate(context);
    dtoBuffer.write(result.dtoExtension);
    domainBuffer.write(result.domainExtension);

    // Generate regular extensions
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
    _generateCollectionExtensions(buffer, context, result);

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

  Set<MapperCollection> _extractCollectionTypes(
    ConstantReader collectionReader,
  ) {
    final collections = <MapperCollection>{};

    if (collectionReader.isNull) {
      return collections;
    }

    try {
      final setConstant = collectionReader.setValue;
      for (final element in setConstant) {
        final enumName = element.getField('_name')?.toStringValue();
        switch (enumName) {
          case 'list':
            collections.add(MapperCollection.list);
            break;
          case 'set':
            collections.add(MapperCollection.set);
            break;
          case 'iterable':
            collections.add(MapperCollection.iterable);
            break;
        }
      }
    } catch (e) {
      return collections;
    }
    return collections;
  }

  void _generateCollectionExtensions(
    StringBuffer buffer,
    MapperContext context,
    dynamic result,
  ) {
    for (final collection in context.collections) {
      final collectionTypeName = _getCollectionTypeName(collection);
      final extensionName = '${collectionTypeName}${context.dtoName}Mapper';
      final collectionType = '${collectionTypeName}<${context.dtoName}>';

      buffer.writeln('extension $extensionName on $collectionType {');

      if (context.enableToDomain) {
        final domainCollectionType =
            '${collectionTypeName}<${context.domainName}>';
        buffer.writeln('  $domainCollectionType toDomain() {');
        _generateCollectionConversion(buffer, collection, 'item.toDomain()');
        buffer.writeln('  }');
        buffer.writeln();
      }

      buffer.writeln('}');
      buffer.writeln();
      if (context.enableToData) {
        final domainExtensionName =
            '${collectionTypeName}${context.domainName}ToDataMapper';
        final domainCollectionType =
            '${collectionTypeName}<${context.domainName}>';

        buffer.writeln(
          'extension $domainExtensionName on $domainCollectionType {',
        );

        final dataCollectionType = '${collectionTypeName}<${context.dtoName}>';
        buffer.writeln('  $dataCollectionType toData() {');
        _generateCollectionConversion(buffer, collection, 'item.toData()');
        buffer.writeln('  }');
        buffer.writeln();

        buffer.writeln('}');
        buffer.writeln();
      }
    }
  }

  String _getCollectionTypeName(MapperCollection collection) {
    switch (collection) {
      case MapperCollection.list:
        return 'List';
      case MapperCollection.set:
        return 'Set';
      case MapperCollection.iterable:
        return 'Iterable';
    }
  }

  void _generateCollectionConversion(
    StringBuffer buffer,
    MapperCollection collection,
    String itemConversion,
  ) {
    switch (collection) {
      case MapperCollection.list:
        buffer.writeln('    return map((item) => $itemConversion).toList();');
        break;
      case MapperCollection.set:
        buffer.writeln('    return map((item) => $itemConversion).toSet();');
        break;
      case MapperCollection.iterable:
        buffer.writeln('    return map((item) => $itemConversion);');
        break;
    }
  }
}
