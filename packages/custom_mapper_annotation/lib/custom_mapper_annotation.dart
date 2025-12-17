/// Annotations for custom_mapper code generation.
///
/// This package contains the annotations used by the custom_mapper
/// build runner to generate mapping code.
library custom_mapper_annotation;

/// Annotation to mark a class for automatic mapper code generation.
///
/// The [Mapper] annotation tells the custom_mapper build runner to generate
/// mapping methods for converting between the annotated class and a domain object.
///
/// Example:
/// ```dart
/// @Mapper(domain: User, toDomain: true, toData: true)
/// class UserDto {
///   final String name;
///   final int age;
///
///   const UserDto({required this.name, required this.age});
/// }
/// ```
class Mapper {
  /// The domain type to map to/from.
  ///
  /// This specifies the target domain object type that the annotated class
  /// should be mapped to or from.
  final Type domain;

  /// Whether to generate a method to convert to the domain object.
  ///
  /// When `true`, generates a `toDomain()` method that converts from the
  /// annotated class to the specified [domain] type.
  ///
  /// Defaults to `true`.
  final bool toDomain;

  /// Whether to generate a method to convert from the domain object.
  ///
  /// When `true`, generates a `toData()` method that converts from the
  /// specified [domain] type to the annotated class.
  ///
  /// Defaults to `false`.
  final bool toData;

  /// Creates a new [Mapper] annotation.
  ///
  /// The [domain] parameter is required and specifies the target type.
  /// [toDomain] and [toData] control which mapping methods are generated.
  const Mapper({
    required this.domain,
    this.toDomain = true,
    this.toData = false,
  });
}

/// Annotation to mark a field to be ignored during mapping.
///
/// Fields annotated with [IgnoreField] will not be included in the
/// generated mapping code. This is useful for computed properties,
/// internal state, or fields that should not be mapped.
///
/// Example:
/// ```dart
/// class UserDto {
///   final String name;
///
///   @IgnoreField()
///   final String internalId; // This field will be ignored
///
///   const UserDto({required this.name, required this.internalId});
/// }
/// ```
class IgnoreField {
  /// Creates a new [IgnoreField] annotation.
  const IgnoreField();
}

/// Annotation to provide a default value when the source field is null.
///
/// When a field in the source object is null, the mapping will use the
/// specified [defaultValue] instead. This is particularly useful when
/// converting from nullable fields to non-nullable fields.
///
/// Example:
/// ```dart
/// class UserDto {
///   @DefaultIfNull('Unknown')
///   final String name; // Will use 'Unknown' if source name is null
///
///   @DefaultIfNull(0)
///   final int age; // Will use 0 if source age is null
///
///   const UserDto({required this.name, required this.age});
/// }
/// ```
class DefaultIfNull {
  /// The default value to use when the source field is null.
  ///
  /// This value will be used in the generated mapping code when the
  /// corresponding field in the source object is null.
  final dynamic defaultValue;

  /// Creates a new [DefaultIfNull] annotation with the specified [defaultValue].
  ///
  /// The [defaultValue] should be compatible with the target field type.
  const DefaultIfNull(this.defaultValue);
}
