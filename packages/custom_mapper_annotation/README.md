# custom_mapper_annotation

Annotations for the custom_mapper code generation package.

This package contains only the annotations used by `custom_mapper` to generate mapping code. It has no dependencies and is lightweight.

## Usage

Add this package to your `pubspec.yaml`:

```yaml
dependencies:
  custom_mapper_annotation: ^0.0.1

dev_dependencies:
  custom_mapper: ^0.0.1
  build_runner: ^2.4.13
```

Then use the annotations in your code:

```dart
import 'package:custom_mapper_annotation/custom_mapper_annotation.dart';

@Mapper(domain: User, toDomain: true, toData: true)
class UserDto {
  // Your DTO class implementation
}
```
