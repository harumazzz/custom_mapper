/// Collection types that can be mapped.
enum MapperCollection { list, set, iterable }

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

  /// The collection type to use for mapping collections.
  ///
  /// Specifies which collection type should be used when mapping
  /// collection fields between objects.
  final Set<MapperCollection> collection;

  /// Creates a new [Mapper] annotation.
  ///
  /// The [domain] parameter is required and specifies the target type.
  /// [toDomain] and [toData] control which mapping methods are generated.
  const Mapper({
    required this.domain,
    this.toDomain = true,
    this.toData = false,
    this.collection = const {},
  });
}
