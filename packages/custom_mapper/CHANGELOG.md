## 0.0.9

### Update README

- **Update readme**: Include part 'mapper.dart' to generate.

## 0.0.8

### Add Collection support

- **Add collection support**: Mapper now support generating extension method for Dart collections like Iterable, Set, List.

## 0.0.7

### Enhancements

- **Enhanced domain class resolution**: Domain classes can now be imported from other files
- **Fixed cross-file mapping**: Resolves empty extension generation when domain class is in a separate file
- **Improved library search**: Enhanced `findClassInLibrary` to search through imported libraries

## 0.0.6

### Score Fixes

- **Fix version errors**: Revert changes in 0.0.5.

## 0.0.5

### Score Fixes

- **Fix version conflict**: Migrate with future versions.

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
