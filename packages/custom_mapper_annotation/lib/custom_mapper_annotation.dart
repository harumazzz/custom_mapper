/// Annotations for custom_mapper code generation.
///
/// This package contains the annotations used by the custom_mapper
/// build runner to generate mapping code.
library custom_mapper_annotation;

class Mapper {
  final Type domain;
  final bool toDomain;
  final bool toData;

  const Mapper({
    required this.domain,
    this.toDomain = true,
    this.toData = false,
  });
}

class IgnoreField {
  const IgnoreField();
}

class DefaultIfNull {
  final dynamic defaultValue;

  const DefaultIfNull(this.defaultValue);
}
