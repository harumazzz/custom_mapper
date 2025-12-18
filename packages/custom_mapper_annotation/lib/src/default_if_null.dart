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
