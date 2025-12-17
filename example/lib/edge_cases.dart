import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:custom_mapper_annotation/custom_mapper_annotation.dart';

part 'edge_cases.freezed.dart';
part 'edge_cases.map.dart';

@freezed
sealed class ReadOnlyModel with _$ReadOnlyModel {
  const factory ReadOnlyModel({required String id, required String content}) =
      _ReadOnlyModel;
}

@freezed
@Mapper(domain: ReadOnlyModel, toDomain: true, toData: false)
sealed class ReadOnlyModelData with _$ReadOnlyModelData {
  const factory ReadOnlyModelData({
    required String id,
    required String content,
  }) = _ReadOnlyModelData;
}

@freezed
sealed class WriteOnlyModel with _$WriteOnlyModel {
  const factory WriteOnlyModel({required String name, required double value}) =
      _WriteOnlyModel;
}

@freezed
@Mapper(domain: WriteOnlyModel, toDomain: false, toData: true)
sealed class WriteOnlyModelData with _$WriteOnlyModelData {
  const factory WriteOnlyModelData({
    required String name,
    required double value,
  }) = _WriteOnlyModelData;
}

@freezed
sealed class SecureModel with _$SecureModel {
  const factory SecureModel({required String publicId, required String name}) =
      _SecureModel;
}

@freezed
@Mapper(domain: SecureModel, toDomain: true, toData: true)
sealed class SecureModelData with _$SecureModelData {
  const factory SecureModelData({
    required String publicId,
    required String name,
    @IgnoreField() String? internalToken,
    @IgnoreField() String? cacheKey,
    @IgnoreField() DateTime? lastAccessed,
  }) = _SecureModelData;
}

@freezed
sealed class DefaultsModel with _$DefaultsModel {
  const factory DefaultsModel({
    required String name,
    String? status,
    int? count,
    bool? isEnabled,
  }) = _DefaultsModel;
}

@freezed
@Mapper(domain: DefaultsModel, toDomain: true, toData: true)
sealed class DefaultsModelData with _$DefaultsModelData {
  const factory DefaultsModelData({
    required String name,
    @DefaultIfNull('active') String? status,
    @DefaultIfNull(0) int? count,
    @DefaultIfNull(true) bool? isEnabled,
    @DefaultIfNull('system') String? createdBy,
  }) = _DefaultsModelData;
}

@freezed
sealed class CollectionModel with _$CollectionModel {
  const factory CollectionModel({
    required String name,
    required List<String> items,
    required Set<int> numbers,
    required Map<String, dynamic> metadata,
  }) = _CollectionModel;
}

@freezed
@Mapper(domain: CollectionModel, toDomain: true, toData: true)
sealed class CollectionModelData with _$CollectionModelData {
  const factory CollectionModelData({
    required String name,
    required List<String> items,
    required Set<int> numbers,
    required Map<String, dynamic> metadata,
  }) = _CollectionModelData;
}
