import 'package:analyzer/dart/element/element2.dart';

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

  MapperContext({
    required this.dtoElement,
    required this.dtoName,
    required this.domainName,
    required this.fields,
    this.fieldAnnotations = const {},
    this.enableToDomain = true,
    this.enableToData = false,
  });
}
