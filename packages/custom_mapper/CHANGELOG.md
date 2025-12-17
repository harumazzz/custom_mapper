## 0.0.4

### Score Fixes

- **Fix errors**: Migrate and fixes errors.

## 0.0.3

### Score Fixes

- **Fix errors**: Fixed errors relate to example

## 0.0.2

### Bug Fixes

- **Platform Support**: Added explicit platform support declarations for all platforms (Android, iOS, Windows, macOS, Linux, Web)
- **Dependencies**: Updated dependency constraints to support newer versions:
  - `analyzer`: Now supports up to `<10.0.0`
  - `build`: Now supports up to `<5.0.0`
  - `source_gen`: Now supports up to `<5.0.0`

## 0.0.1

### Initial Release

**Custom Mapper** - A build_runner code generator for `custom_mapper_annotation` package.

#### 🔧 What it does

This package generates type-safe mapping code for classes annotated with `@Mapper` from the `custom_mapper_annotation` package.

#### 🚀 Features

- **Code Generator**: Processes `@Mapper` annotations to generate mapping methods
- **Build Runner Integration**: Works seamlessly with `build_runner` to generate `.map.dart` files
- **Type Safety**: Generated code is fully type-safe with compile-time checking
- **Bidirectional Mapping**: Supports both `toDomain()` and `toData()` method generation
- **Advanced Types**: Handles generics, collections, nested objects, and nullable types

#### 📦 Usage

1. Add `custom_mapper_annotation` to dependencies
2. Add `custom_mapper` and `build_runner` to dev_dependencies
3. Annotate your classes with `@Mapper`
4. Run `dart run build_runner build`

#### 🔗 Related Packages

- [`custom_mapper_annotation`](https://pub.dev/packages/custom_mapper_annotation) - Contains the `@Mapper` and other annotations used by this generator
