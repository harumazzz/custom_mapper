# custom_mapper

A powerful code generation package for creating type-safe mappers between domain objects and data transfer objects (DTOs) in Dart and Flutter applications.

## Installation

Add both packages to your `pubspec.yaml`:

```yaml
dependencies:
  custom_mapper_annotation: ^0.0.5

dev_dependencies:
  custom_mapper: ^0.0.9
  build_runner: ^2.4.13
```

## Usage

1. Import the annotation package
2. Annotate your DTO classes
3. Run code generation

```dart
import 'package:custom_mapper_annotation/custom_mapper_annotation.dart';
part 'user.mapper.dart'; // For generating with our package

@Mapper(domain: User, toDomain: true, toData: true)
class UserDto {
  final String name;
  final int age;
  final String email;

  const UserDto({
    required this.name,
    required this.age,
    required this.email,
  });
}
```

It works with freezed package as well:

```dart
import 'package:custom_mapper_annotation/custom_mapper_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'user.freezed.dart'; // For generating with freezed
part 'user.mapper.dart'; // For generating with our package

@Mapper(domain: User, toDomain: true, toData: true)
sealed class UserDto with _$UserDto {
  const factory UserDto({
    required String name,
    required int age,
    required String email,
  }) = _$UserDto;
}
```

Then run:

```bash
dart run build_runner build
```

This will generate mapping extensions for your classes.
