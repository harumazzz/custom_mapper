import 'package:analyzer/dart/element/element2.dart';
import 'package:custom_mapper_annotation/custom_mapper_annotation.dart';

class FieldAnnotationMetadata {
  final bool isIgnored;
  final dynamic defaultIfNullValue;

  FieldAnnotationMetadata({this.isIgnored = false, this.defaultIfNullValue});
}

class MapperContext {
  final ClassElement2 dtoElement;
  final String dtoName;
  final String domainName;
  final List<String> fields;
  final Map<String, FieldAnnotationMetadata> fieldAnnotations;
  final bool enableToDomain;
  final bool enableToData;
  final Set<MapperCollection> collections;

  MapperContext({
    required this.dtoElement,
    required this.dtoName,
    required this.domainName,
    required this.fields,
    this.fieldAnnotations = const {},
    this.enableToDomain = true,
    this.enableToData = false,
    this.collections = const {},
  });
}
