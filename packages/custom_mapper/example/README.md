# Custom Mapper Example

This example demonstrates how to use the `custom_mapper` package to generate type-safe mapping methods between domain objects and DTOs.

## Features Demonstrated

- **Bidirectional Mapping**: Converting between domain objects and DTOs in both directions
- **Default Values**: Using `@DefaultIfNull` to provide fallback values
- **Field Exclusion**: Using `@IgnoreField` to exclude fields from mapping
- **Integration with Freezed**: Working seamlessly with freezed classes
- **Type Safety**: Compile-time checked conversions between different object types

## Files

- `lib/models.dart` - Contains the domain and DTO class definitions with annotations
- `lib/main.dart` - Example usage and demonstration of the generated methods

## Running the Example

1. **Install dependencies:**

   ```bash
   dart pub get
   ```

2. **Generate mapping code:**

   ```bash
   dart run build_runner build
   ```

3. **Run the example:**
   ```bash
   dart run lib/main.dart
   ```

## Generated Code

After running build_runner, you'll find:

- `lib/models.map.dart` - Contains the generated mapping extensions
- Extension methods like `toDomain()` and `toData()` on your DTO classes
- Automatic handling of type conversions (e.g., `DateTime` ↔ `String`, `List<String>` ↔ `String`)
- Proper null safety and default value handling

## Key Annotations

### @Mapper

```dart
@Mapper(domain: User, toDomain: true, toData: true)
class UserDto { ... }
```

Generates both `toDomain()` and `toData()` methods.

### @DefaultIfNull

```dart
@DefaultIfNull(18)
final int age;
```

Provides a default value when the source field is null.

### @IgnoreField

```dart
@IgnoreField()
final bool internalFlag;
```

Excludes the field from mapping operations.

## Learn More

- See the main [custom_mapper documentation](../README.md)
- Check out [custom_mapper_annotation](../../custom_mapper_annotation/README.md) for annotation details
- Visit the [example directory](../../../example/) for more complex use cases
