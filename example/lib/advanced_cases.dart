import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:custom_mapper_annotation/custom_mapper_annotation.dart';

part 'advanced_cases.freezed.dart';
part 'advanced_cases.map.dart';

@freezed
sealed class Product with _$Product {
  const factory Product({
    required String name,
    required double price,
    required int quantity,
    required bool isActive,
    required DateTime createdAt,
  }) = _Product;
}

@freezed
@Mapper(domain: Product, toDomain: true, toData: true)
sealed class ProductData with _$ProductData {
  const factory ProductData({
    required String name,
    required double price,
    required int quantity,
    required bool isActive,
    required DateTime createdAt,
  }) = _ProductData;
}

enum Status { pending, approved, rejected }

enum Priority { low, medium, high, critical }

@freezed
sealed class Task with _$Task {
  const factory Task({
    required String title,
    required Status status,
    required Priority priority,
  }) = _Task;
}

@freezed
@Mapper(domain: Task, toDomain: true, toData: true)
sealed class TaskData with _$TaskData {
  const factory TaskData({
    required String title,
    required Status status,
    required Priority priority,
  }) = _TaskData;
}

@freezed
sealed class Configuration with _$Configuration {
  const factory Configuration({
    required String name,
    required Map<String, String> settings,
    required Map<String, int> counters,
  }) = _Configuration;
}

@freezed
@Mapper(domain: Configuration, toDomain: true, toData: true)
sealed class ConfigurationData with _$ConfigurationData {
  const factory ConfigurationData({
    required String name,
    required Map<String, String> settings,
    required Map<String, int> counters,
  }) = _ConfigurationData;
}

@freezed
sealed class Category with _$Category {
  const factory Category({
    required String name,
    required Set<String> tags,
    required Set<int> relatedIds,
  }) = _Category;
}

@freezed
@Mapper(domain: Category, toDomain: true, toData: true)
sealed class CategoryData with _$CategoryData {
  const factory CategoryData({
    required String name,
    required Set<String> tags,
    required Set<int> relatedIds,
  }) = _CategoryData;
}
