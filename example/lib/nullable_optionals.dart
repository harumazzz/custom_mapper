import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:custom_mapper_annotation/custom_mapper_annotation.dart';

part 'nullable_optionals.freezed.dart';
part 'nullable_optionals.mapper.dart';

@freezed
sealed class NullableModel with _$NullableModel {
  const factory NullableModel({
    String? name,
    int? age,
    double? score,
    bool? isActive,
    DateTime? createdAt,
  }) = _NullableModel;
}

@freezed
@Mapper(domain: NullableModel, toDomain: true, toData: true)
sealed class NullableModelData with _$NullableModelData {
  const factory NullableModelData({
    String? name,
    int? age,
    double? score,
    bool? isActive,
    DateTime? createdAt,
  }) = _NullableModelData;
}

@freezed
sealed class NullableCollections with _$NullableCollections {
  const factory NullableCollections({
    required String id,
    List<String>? tags,
    Set<int>? numbers,
    Map<String, String>? metadata,
  }) = _NullableCollections;
}

@freezed
@Mapper(domain: NullableCollections, toDomain: true, toData: true)
sealed class NullableCollectionsData with _$NullableCollectionsData {
  const factory NullableCollectionsData({
    required String id,
    List<String>? tags,
    Set<int>? numbers,
    Map<String, String>? metadata,
  }) = _NullableCollectionsData;
}

@freezed
sealed class OptionalNested with _$OptionalNested {
  const factory OptionalNested({
    required String name,
    NullableModel? profile,
    required List<NullableModel?> relatedProfiles,
    Map<String, NullableModel?>? profileMap,
  }) = _OptionalNested;
}

@freezed
@Mapper(domain: OptionalNested, toDomain: true, toData: true)
sealed class OptionalNestedData with _$OptionalNestedData {
  const factory OptionalNestedData({
    required String name,
    NullableModelData? profile,
    required List<NullableModelData?> relatedProfiles,
    Map<String, NullableModelData?>? profileMap,
    @IgnoreField() String? cacheKey,
    @DefaultIfNull('unknown') String? source,
  }) = _OptionalNestedData;
}

@freezed
sealed class NestedOptional with _$NestedOptional {
  const factory NestedOptional({
    String? title,
    NestedOptional? parent,
    List<NestedOptional>? children,
  }) = _NestedOptional;
}

@freezed
@Mapper(domain: NestedOptional, toDomain: true, toData: true)
sealed class NestedOptionalData with _$NestedOptionalData {
  const factory NestedOptionalData({
    String? title,
    NestedOptionalData? parent,
    List<NestedOptionalData>? children,
  }) = _NestedOptionalData;
}

@freezed
sealed class OptionalComplexCollections with _$OptionalComplexCollections {
  const factory OptionalComplexCollections({
    required String name,
    List<NullableModel>? items,
    Set<NestedOptional>? categories,
    Map<String, List<OptionalNested>?>? groups,
  }) = _OptionalComplexCollections;
}

@freezed
@Mapper(domain: OptionalComplexCollections, toDomain: true, toData: true)
sealed class OptionalComplexCollectionsData
    with _$OptionalComplexCollectionsData {
  const factory OptionalComplexCollectionsData({
    required String name,
    List<NullableModelData>? items,
    Set<NestedOptionalData>? categories,
    Map<String, List<OptionalNestedData>?>? groups,
  }) = _OptionalComplexCollectionsData;
}
