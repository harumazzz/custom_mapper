/// A powerful code generation package for creating type-safe mappers between
/// domain objects and data transfer objects (DTOs) in Dart and Flutter applications.
///
/// Custom Mapper automatically generates mapping code using build_runner,
/// reducing boilerplate and ensuring type safety when converting between
/// different object representations.
///
/// ## Features
///
/// * **Automatic Code Generation**: Generate mapping methods using annotations
/// * **Bidirectional Mapping**: Support for both to-domain and from-domain conversions
/// * **Type Safety**: Compile-time checked mappings with full type inference
/// * **Null Safety**: Full support for Dart's null safety features
/// * **Flexible Configuration**: Control mapping behavior with annotations
/// * **Integration Ready**: Works seamlessly with freezed, json_annotation, and other packages
///
/// ## Usage
///
/// 1. Add the `@Mapper` annotation to your DTO classes
/// 2. Specify the domain type you want to map to/from
/// 3. Run `dart run build_runner build` to generate mapping code
///
/// ```dart
/// @freezed
/// @Mapper(domain: User, toDomain: true, toData: true)
/// sealed class UserDto with _$UserDto {
///   const factory UserDto({
///     required String name,
///     required int age,
///     required String email,
///   }) = _UserDto;
/// }
/// ```
///
/// This will generate extension methods like `toDomain()` and `toData()`
/// for seamless object conversion.
library custom_mapper;

// Export builder for build_runner
export 'builder.dart';
