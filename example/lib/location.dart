import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:custom_mapper_annotation/custom_mapper_annotation.dart';

part 'location.freezed.dart';
part 'location.mapper.dart';

@freezed
sealed class Location with _$Location {
  const factory Location({
    required String street,
    required String city,
    required String zipCode,
  }) = _Location;
}

@freezed
@Mapper(domain: Location, toDomain: true, toData: true)
sealed class LocationData with _$LocationData {
  const factory LocationData({
    required String street,
    required String city,
    required String zipCode,
  }) = _LocationData;
}

@freezed
sealed class Customer with _$Customer {
  const factory Customer({
    required String name,
    required int age,
    required Location location,
    String? department,
  }) = _Customer;
}

@freezed
@Mapper(domain: Customer, toDomain: true, toData: true)
sealed class CustomerData with _$CustomerData {
  const factory CustomerData({
    required String name,
    required int age,
    required LocationData location,
    @IgnoreField() String? internalId,
    @DefaultIfNull('Engineering') String? department,
  }) = _CustomerData;
}

@freezed
sealed class CustomerProfile with _$CustomerProfile {
  const factory CustomerProfile({
    required String name,
    required Location? location,
  }) = _CustomerProfile;
}

@freezed
@Mapper(domain: CustomerProfile, toDomain: true, toData: true)
sealed class CustomerProfileData with _$CustomerProfileData {
  const factory CustomerProfileData({
    required String name,
    required LocationData? location,
  }) = _CustomerProfileData;
}
