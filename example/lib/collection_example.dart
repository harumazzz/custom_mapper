import 'package:custom_mapper_annotation/custom_mapper_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'collection_example.freezed.dart';
part 'collection_example.mapper.dart';

@freezed
sealed class Address with _$Address {
  const factory Address({
    required String street,
    required String city,
    required String country,
  }) = _Address;
}

@Mapper(
  domain: Address,
  toDomain: true,
  toData: true,
  collection: {
    MapperCollection.list,
    MapperCollection.set,
    MapperCollection.iterable,
  },
)
@freezed
sealed class AddressDto with _$AddressDto {
  const factory AddressDto({
    required String street,
    required String city,
    required String country,
  }) = _AddressDto;
}

@freezed
sealed class Company with _$Company {
  const factory Company({
    required String name,
    required List<Address> addresses,
  }) = _Company;
}

@Mapper(domain: Company, toDomain: true, toData: true)
@freezed
sealed class CompanyDto with _$CompanyDto {
  const factory CompanyDto({
    required String name,
    required List<AddressDto> addresses,
  }) = _CompanyDto;
}
