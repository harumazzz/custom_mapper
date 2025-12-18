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
