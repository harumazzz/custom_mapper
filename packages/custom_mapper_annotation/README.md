# Custom Mapper Annotation

Annotations for the custom_mapper code generation package.

This package contains only the annotations used by `custom_mapper` to generate mapping code. It has no dependencies and is lightweight, making it safe to include in your main dependencies without adding bloat to your application.

## Features

- 🏷️ **@Mapper** - Mark classes for automatic mapping code generation
- 🚫 **@IgnoreField** - Exclude specific fields from mapping
- 🔄 **@DefaultIfNull** - Provide default values for null fields
- 📦 **Zero Dependencies** - Lightweight annotations-only package
- ✅ **Type Safe** - Full compile-time type checking

## Installation

Add this package to your `pubspec.yaml`:

```yaml
dependencies:
  custom_mapper_annotation: ^0.0.4

dev_dependencies:
  custom_mapper: ^0.0.8
  build_runner: ^2.4.13
```

## Annotations

### @Mapper

The main annotation that marks a class for mapper code generation.

```dart
part 'user_dto.mapper.dart'; // For code generation

@Mapper(domain: User, toDomain: true, toData: true)
class UserDto {
  final String name;
  final int age;

  const UserDto({required this.name, required this.age});
}
```

**Parameters:**

- `domain` (required): The domain type to map to/from
- `toDomain` (optional): Generate method to convert to domain (default: `true`)
- `toData` (optional): Generate method to convert from domain (default: `false`)
- `collections` (optional): Generate collections mapper to domain and from domain.

### @IgnoreField

Marks a field to be ignored during mapping operations.

```dart
part 'user_dto.mapper.dart'; // For code generation
class UserDto {
  final String name;

  @IgnoreField()
  final String internalId; // Won't be mapped
}
```

### @DefaultIfNull

Provides a default value when the source field is null.

```dart
part 'user_dto.mapper.dart'; // For code generation

class UserDto {
  @DefaultIfNull('Unknown')
  final String name; // Uses 'Unknown' if source is null

  @DefaultIfNull(0)
  final int age; // Uses 0 if source is null
}
```

## Usage Example

```dart
import 'package:custom_mapper_annotation/custom_mapper_annotation.dart';
part 'user.mapper.dart';

// Domain model
class User {
  final String name;
  final int age;
  final String? email;

  const User({required this.name, required this.age, this.email});
}

// DTO with mapping annotations
@Mapper(domain: User, toDomain: true, toData: true)
class UserDto {
  final String name;

  @DefaultIfNull(18)
  final int age;

  final String? email;

  @IgnoreField()
  final String processingId;

  const UserDto({
    required this.name,
    required this.age,
    this.email,
    required this.processingId,
  });
}
```

After running `dart run build_runner build`, you'll get generated extension methods:

```dart
// Generated methods (example)
final user = User(name: 'John', age: 30, email: 'john@example.com');
final dto = user.toData(); // Convert to DTO
final backToUser = dto.toDomain(); // Convert back to domain
```

## More Information

- See the [example](example/example.dart) for complete usage
- Check the main [custom_mapper package](https://pub.dev/packages/custom_mapper) for code generation
- Visit the [GitHub repository](https://github.com/harumazzz/custom_mapper) for source code

## Contributing

Contributions are welcome! Please read our contributing guidelines and submit pull requests to our GitHub repository.
