# Custom Mapper

[![Build Status](https://img.shields.io/github/workflow/status/harumazzz/custom_mapper/Build)](https://github.com/harumazzz/custom_mapper/actions)
[![pub package](https://img.shields.io/pub/v/custom_mapper.svg)](https://pub.dartlang.org/packages/custom_mapper)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A powerful code generation package for creating type-safe, bidirectional mappers between domain objects and data transfer objects (DTOs) in Dart and Flutter applications.

# Motivation

When building clean architecture applications, you often need to separate your domain models from your data models (DTOs). This separation provides benefits like:

- **Decoupling**: Domain logic isn't tied to external data formats
- **Flexibility**: Easy to change API structures without affecting business logic
- **Testing**: Mock data layers without complex domain objects
- **Validation**: Different validation rules for external vs internal data

However, manually writing mapping code between these layers is:

- **Tedious**: Lots of repetitive boilerplate code
- **Error-prone**: Easy to miss fields or introduce bugs
- **Hard to maintain**: Changes require updates in multiple places

Custom Mapper solves this by automatically generating type-safe, bidirectional mapping methods, letting you focus on your business logic instead of plumbing code.

| Before                                                       | After                                                 |
| ------------------------------------------------------------ | ----------------------------------------------------- |
| Manual mapping methods with hundreds of lines of boilerplate | Simple `@Mapper` annotation with generated extensions |

# Index

- [Motivation](#motivation)
- [Index](#index)
- [How to use](#how-to-use)
  - [Install](#install)
  - [Run the generator](#run-the-generator)
  - [Creating Mappers](#creating-mappers)
    - [Basic Usage](#basic-usage)
    - [Bidirectional Mapping](#bidirectional-mapping)
    - [Field Annotations](#field-annotations)
      - [Ignoring Fields](#ignoring-fields)
      - [Default Values](#default-values)
    - [Generic Types](#generic-types)
    - [Nested Objects](#nested-objects)
- [Packages](#packages)
- [Examples](#examples)

# How to use

## Install

To use Custom Mapper, you will need your typical [build_runner]/code-generator setup.
First, install [build_runner] and Custom Mapper by adding them to your `pubspec.yaml` file:

For a Flutter project:

```bash
flutter pub add custom_mapper_annotation
flutter pub add --dev custom_mapper
```

For a Dart project:

```bash
dart pub add custom_mapper_annotation
dart pub add --dev custom_mapper
```

This installs three packages:

- [build_runner](https://pub.dev/packages/build_runner), the tool to run code-generators
- [custom_mapper], the code generator
- [custom_mapper_annotation], a package containing annotations for [custom_mapper].

## Run the generator

To run the code generator, execute the following command:

```
dart run build_runner build
```

Note that like most code-generators, Custom Mapper will need you to both import the annotation ([custom_mapper_annotation])
and use the `part` keyword on the top of your files.

As such, a file that wants to use Custom Mapper will start with:

```dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:custom_mapper_annotation/custom_mapper_annotation.dart';

part 'my_file.freezed.dart';
part 'my_file.map.dart';
```

## Creating Mappers

### Basic Usage

Custom Mapper works by annotating your data transfer objects (DTOs) with the `@Mapper` annotation:

```dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:custom_mapper_annotation/custom_mapper_annotation.dart';

part 'user.freezed.dart';
part 'user.map.dart';

// Domain model
@freezed
sealed class User with _$User {
  const factory User({
    required String name,
    required int age,
    required String email,
  }) = _User;
}

// Data model with mapper annotation
@freezed
@Mapper(domain: User, toDomain: true, toData: true)
sealed class UserData with _$UserData {
  const factory UserData({
    required String name,
    required int age,
    required String email,
  }) = _UserData;
}
```

This generates the following extensions in `user.map.dart`:

```dart
extension UserDataMapper on UserData {
  User toDomain() => User(
    name: name,
    age: age,
    email: email,
  );
}

extension UserToDataMapper on User {
  UserData toData() => UserData(
    name: name,
    age: age,
    email: email,
  );
}
```

Now you can easily convert between your domain and data models:

```dart
void main() {
  // Convert from data to domain
  final userData = UserData(name: 'John', age: 30, email: 'john@example.com');
  final user = userData.toDomain();

  // Convert from domain to data
  final newUserData = user.toData();
}
```

### Bidirectional Mapping

You can control which mapping directions are generated using the `toDomain` and `toData` parameters:

```dart
// Only generate toDomain() method
@freezed
@Mapper(domain: User, toDomain: true, toData: false)
sealed class UserData with _$UserData { ... }

// Only generate toData() method
@freezed
@Mapper(domain: User, toDomain: false, toData: true)
sealed class UserData with _$UserData { ... }

// Generate both methods (default)
@freezed
@Mapper(domain: User, toDomain: true, toData: true)
sealed class UserData with _$UserData { ... }
```

### Field Annotations

#### Ignoring Fields

Use `@IgnoreField()` to exclude fields from mapping:

```dart
@freezed
@Mapper(domain: User, toDomain: true, toData: true)
sealed class UserData with _$UserData {
  const factory UserData({
    required String name,
    required int age,
    @IgnoreField() required String internalId, // This field won't be mapped
  }) = _UserData;
}
```

#### Default Values

Use `@DefaultIfNull()` to provide default values when mapping:

```dart
@freezed
@Mapper(domain: User, toDomain: true, toData: true)
sealed class UserData with _$UserData {
  const factory UserData({
    required String name,
    @DefaultIfNull('Unknown') String? nickname,
  }) = _UserData;
}
```

### Generic Types

Custom Mapper supports generic types:

```dart
@freezed
sealed class Container<T> with _$Container<T> {
  const factory Container({
    required T value,
    required String label,
  }) = _Container<T>;
}

@freezed
@Mapper(domain: Container, toDomain: true, toData: true)
sealed class ContainerData<T> with _$ContainerData<T> {
  const factory ContainerData({
    required T value,
    required String label,
  }) = _ContainerData<T>;
}
```

### Nested Objects

Custom Mapper handles nested objects that also have mappers:

```dart
@freezed
sealed class Address with _$Address {
  const factory Address({
    required String street,
    required String city,
  }) = _Address;
}

@freezed
@Mapper(domain: Address, toDomain: true, toData: true)
sealed class AddressData with _$AddressData {
  const factory AddressData({
    required String street,
    required String city,
  }) = _AddressData;
}

@freezed
sealed class Person with _$Person {
  const factory Person({
    required String name,
    required Address address,
  }) = _Person;
}

@freezed
@Mapper(domain: Person, toDomain: true, toData: true)
sealed class PersonData with _$PersonData {
  const factory PersonData({
    required String name,
    required AddressData address, // Automatically maps nested objects
  }) = _PersonData;
}
```

# Packages

This repository contains two packages following the same pattern as freezed:

- **[custom_mapper_annotation](packages/custom_mapper_annotation/)** - Contains the annotations (`@Mapper`, `@IgnoreField`, `@DefaultIfNull`)
- **[custom_mapper](packages/custom_mapper/)** - Contains the build runner code generator that generates the mapping code

# Examples

The [example](example/) folder contains comprehensive examples demonstrating various use cases:

- **[Basic Usage](example/lib/user.dart)** - Simple domain/data mapping
- **[Generic Types](example/lib/generic_types.dart)** - Working with generic classes
- **[Nested Objects](example/lib/nested_complex.dart)** - Complex nested object mapping
- **[Nullable Fields](example/lib/nullable_optionals.dart)** - Handling optional and nullable fields
- **[Edge Cases](example/lib/edge_cases.dart)** - Advanced mapping scenarios

To run the examples:

```bash
cd example
dart pub get
dart run build_runner build
```

[build_runner]: https://pub.dev/packages/build_runner
[custom_mapper]: https://pub.dartlang.org/packages/custom_mapper
[custom_mapper_annotation]: https://pub.dartlang.org/packages/custom_mapper_annotation
