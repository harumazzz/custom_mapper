## 0.0.1

### Initial Release

**Custom Mapper** is a powerful code generation package for creating type-safe mappers between domain objects and data transfer objects (DTOs) in Dart and Flutter applications.

#### 🚀 Core Features

- **Automatic Code Generation**: Generate mapping methods using the `@Mapper` annotation with build_runner
- **Bidirectional Mapping**: Support for both `toDomain()` and `toData()` conversions using `toDomain` and `toData` parameters
- **Type Safety**: Compile-time checked mappings with full type inference
- **Null Safety**: Complete support for Dart's null safety features including nullable and optional fields

#### 📦 Annotations

- `@Mapper(domain: Type, toDomain: bool, toData: bool)` - Main annotation for generating mappers
- `@IgnoreField()` - Skip specific fields during mapping (planned)
- `@DefaultIfNull(value)` - Provide default values for null fields (planned)

#### 🔧 Advanced Support

- **Generic Types**: Full support for generic classes like `Container<T>`, `Pair<K, V>`
- **Complex Nested Objects**: Handle deeply nested object structures with automatic recursive mapping
- **Collections**: Automatic handling of `List`, `Set`, `Map`, and other iterable types
- **Freezed Integration**: Seamless integration with freezed classes and sealed classes
- **Nullable & Optional Fields**: Proper handling of nullable types and optional parameters

#### 📋 Example Use Cases

- User and UserData mapping with basic fields (String, int, email)
- Post and PostData with nested collections (tags, comments)
- Location mapping with coordinate data
- Generic container classes with type parameters
- Complex nested structures with multiple levels of objects

#### 🛠 Build Configuration

- Automatic `.map.dart` file generation alongside `.freezed.dart`
- Integration with `build_runner` for seamless code generation workflow
- Support for custom build configurations via `build.yaml`

#### 📚 Package Structure

This release includes two packages:

- `custom_mapper`: Main code generation engine
- `custom_mapper_annotation`: Lightweight annotations package with zero dependencies

#### 🔄 Generated Code

The package generates extension methods that provide:

- Clean, readable mapping code
- Type-safe conversions
- Null-safe handling
- Performance-optimized implementations
- IDE-friendly code completion and navigation
