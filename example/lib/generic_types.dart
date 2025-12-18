import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:custom_mapper_annotation/custom_mapper_annotation.dart';

part 'generic_types.freezed.dart';
part 'generic_types.mapper.dart';

@freezed
sealed class GenericContainer<T> with _$GenericContainer<T> {
  const factory GenericContainer({required T value, required String label}) =
      _GenericContainer<T>;
}

@freezed
@Mapper(domain: GenericContainer, toDomain: true, toData: true)
sealed class GenericContainerData<T> with _$GenericContainerData<T> {
  const factory GenericContainerData({
    required T value,
    required String label,
  }) = _GenericContainerData<T>;
}

@freezed
sealed class Pair<K, V> with _$Pair<K, V> {
  const factory Pair({required K key, required V value}) = _Pair<K, V>;
}

@freezed
@Mapper(domain: Pair, toDomain: true, toData: true)
sealed class PairData<K, V> with _$PairData<K, V> {
  const factory PairData({required K key, required V value}) = _PairData<K, V>;
}

@freezed
sealed class NumericContainer<T extends num> with _$NumericContainer<T> {
  const factory NumericContainer({required T value, required String unit}) =
      _NumericContainer<T>;
}

@freezed
@Mapper(domain: NumericContainer, toDomain: true, toData: true)
sealed class NumericContainerData<T extends num>
    with _$NumericContainerData<T> {
  const factory NumericContainerData({required T value, required String unit}) =
      _NumericContainerData<T>;
}

@freezed
sealed class GenericCollection<T> with _$GenericCollection<T> {
  const factory GenericCollection({
    required String name,
    required List<T> items,
    required Map<String, T> itemMap,
    required Set<T> uniqueItems,
  }) = _GenericCollection<T>;
}

@freezed
@Mapper(domain: GenericCollection, toDomain: true, toData: true)
sealed class GenericCollectionData<T> with _$GenericCollectionData<T> {
  const factory GenericCollectionData({
    required String name,
    required List<T> items,
    required Map<String, T> itemMap,
    required Set<T> uniqueItems,
  }) = _GenericCollectionData<T>;
}

@freezed
sealed class NestedGeneric<T> with _$NestedGeneric<T> {
  const factory NestedGeneric({
    required String id,
    required GenericContainer<T> container,
    required List<GenericContainer<T>> containers,
  }) = _NestedGeneric<T>;
}

@freezed
@Mapper(domain: NestedGeneric, toDomain: true, toData: true)
sealed class NestedGenericData<T> with _$NestedGenericData<T> {
  const factory NestedGenericData({
    required String id,
    required GenericContainerData<T> container,
    required List<GenericContainerData<T>> containers,
  }) = _NestedGenericData<T>;
}
