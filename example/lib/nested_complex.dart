import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:custom_mapper_annotation/custom_mapper_annotation.dart';

part 'nested_complex.freezed.dart';
part 'nested_complex.map.dart';

@freezed
sealed class Address with _$Address {
  const factory Address({
    required String street,
    required String city,
    required String country,
  }) = _Address;
}

@freezed
@Mapper(domain: Address, toDomain: true, toData: true)
sealed class AddressData with _$AddressData {
  const factory AddressData({
    required String street,
    required String city,
    required String country,
  }) = _AddressData;
}

@freezed
sealed class Company with _$Company {
  const factory Company({
    required String name,
    required Address address,
    required List<String> departments,
  }) = _Company;
}

@freezed
@Mapper(domain: Company, toDomain: true, toData: true)
sealed class CompanyData with _$CompanyData {
  const factory CompanyData({
    required String name,
    required AddressData address,
    required List<String> departments,
  }) = _CompanyData;
}

@freezed
sealed class Employee with _$Employee {
  const factory Employee({
    required String name,
    required String email,
    required Company company,
    required List<Address> previousAddresses,
  }) = _Employee;
}

@freezed
@Mapper(domain: Employee, toDomain: true, toData: true)
sealed class EmployeeData with _$EmployeeData {
  const factory EmployeeData({
    required String name,
    required String email,
    required CompanyData company,
    required List<AddressData> previousAddresses,
    @IgnoreField() String? employeeId,
    @DefaultIfNull('active') String? status,
  }) = _EmployeeData;
}

@freezed
sealed class Department with _$Department {
  const factory Department({
    required String name,
    required Employee manager,
    required List<Employee> employees,
  }) = _Department;
}

@freezed
@Mapper(domain: Department, toDomain: true, toData: true)
sealed class DepartmentData with _$DepartmentData {
  const factory DepartmentData({
    required String name,
    required EmployeeData manager,
    required List<EmployeeData> employees,
  }) = _DepartmentData;
}

@freezed
sealed class Project with _$Project {
  const factory Project({
    required String name,
    required Map<String, List<Employee>> teams,
    required List<Map<String, String>> configurations,
    required Set<List<String>> permissions,
  }) = _Project;
}

@freezed
@Mapper(domain: Project, toDomain: true, toData: true)
sealed class ProjectData with _$ProjectData {
  const factory ProjectData({
    required String name,
    required Map<String, List<EmployeeData>> teams,
    required List<Map<String, String>> configurations,
    required Set<List<String>> permissions,
  }) = _ProjectData;
}
