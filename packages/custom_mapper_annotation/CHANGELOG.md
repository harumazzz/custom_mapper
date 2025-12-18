## 0.0.4

### Add Collection support

- **Add collection support**: Mapper now support generating extension method for Dart collections like Iterable, Set, List.

## 0.0.3

### Score Fixes

- **Fix errors**: Migrate and fixes errors.

## 0.0.2

### Bug Fixes

- **Platform Support**: Added explicit platform support declarations for all platforms (Android, iOS, Windows, macOS, Linux, Web)

## 0.0.1

### Initial Release

**Custom Mapper Annotation** - Lightweight annotations package for the custom_mapper code generation framework.

#### 📦 Annotations

- `@Mapper(domain: Type, toDomain: bool, toData: bool)` - Core annotation for generating type-safe mappers between domain objects and DTOs

  - `domain`: Target domain class to map to/from
  - `toDomain`: Generate `toDomain()` method (default: true)
  - `toData`: Generate `toData()` method (default: false)

- `@IgnoreField()` - Skip specific fields during mapping (planned for future releases)
- `@DefaultIfNull(value)` - Provide default values for null fields (planned for future releases)

#### ✨ Features

- **Zero Dependencies**: Lightweight package with no external dependencies
- **Null Safety**: Full support for Dart's null safety features
- **Type Safety**: Compile-time type checking for all annotations
- **Framework Integration**: Seamless integration with freezed, json_annotation, and other packages

#### 🚀 Usage

```dart
import 'package:custom_mapper_annotation/custom_mapper_annotation.dart';

@Mapper(domain: User, toDomain: true, toData: true)
sealed class UserDto {
  // Your DTO implementation
}
```

#### 🔗 Related Packages

- [`custom_mapper`](https://pub.dev/packages/custom_mapper) - Main code generation engine that uses these annotations
